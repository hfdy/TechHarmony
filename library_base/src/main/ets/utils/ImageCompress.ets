import image from '@ohos.multimedia.image';
import fs from '@ohos.file.fs';
import fileUri from "@ohos.file.fileuri";
import { Logger } from './Logger';

const BYTE_CONVERSION: number = 1024; // 字节转换
const MAXCOMPRESSEDIMAGESIZE: number = 30; // 指定图片压缩目标大小，单位kb

// 压缩后的图片信息类，用于刷新显示压缩后的图片和图片字节长度
class CompressedImageInfo {
  imageUri: string = ""; // 压缩后图片保存位置的uri
  imageByteLength: number = 0; // 压缩后图片字节长度
}

export class ImageCompress {

  imageCompression(path: string): Promise<string> {
    let file = fs.openSync(path, fs.OpenMode.READ_WRITE);
    let sta = fs.statSync(file.fd);
    Logger.info('压缩前文件大小:'+sta.size/BYTE_CONVERSION);
    Logger.info("压缩前文件fd:" + file.fd);
    if (sta.size <= MAXCOMPRESSEDIMAGESIZE * BYTE_CONVERSION) {
      return Promise.resolve(path);
    }
    let buffer = new ArrayBuffer(sta.size); // 创建一个ArrayBuffer对象
    fs.readSync(file.fd, buffer);   // 读取文件
    // 创建ImageSource实例
    const imageSource: image.ImageSource = image.createImageSource(buffer);
    // 设置解码参数DecodingOptions，解码获取PixelMap图片对象。
    const decodingOptions: image.DecodingOptions = {
      editable: true, // 是否可编辑。当取值为false时，图片不可二次编辑，如crop等操作将失败。
      desiredPixelFormat: 3, // 解码的像素格式。3表示RGBA_8888。
    }
    // 创建pixelMap
    return imageSource.createPixelMap(decodingOptions).then(async (originalPixelMap: image.PixelMap) => {
      // 压缩图片
      let showImage: CompressedImageInfo = await this.compressedImage(originalPixelMap, MAXCOMPRESSEDIMAGESIZE);
      // 获取压缩后的图片信息
      Logger.info('压缩后文件路径:'+fileUri.getUriFromPath(showImage.imageUri));
      Logger.info('压缩后文件大小:'+(showImage.imageByteLength / BYTE_CONVERSION).toFixed(1));
      return fileUri.getUriFromPath(showImage.imageUri);
    }).catch((err: Error) => {
      Logger.info(`Failed to create PixelMap with error message: ${err.message}`);
      return "";
    });
  }

  /**
   * 图片压缩，保存
   * @param sourcePixelMap：原始待压缩图片的PixelMap对象
   * @param maxCompressedImageSize：指定图片的压缩目标大小，单位kb
   * @returns compressedImageInfo：返回最终压缩后的图片信息
   */
  async compressedImage(sourcePixelMap: image.PixelMap, maxCompressedImageSize: number): Promise<CompressedImageInfo> {
    // 创建图像编码ImagePacker对象
    const imagePackerApi = image.createImagePacker();
    // 定义图片质量参数
    const IMAGE_QUALITY = 0;
    // 设置编码输出流和编码参数。图片质量参数quality范围0-100。
    const packOpts: image.PackingOption = { format: "image/jpeg", quality: IMAGE_QUALITY };
    // 通过PixelMap进行编码。compressedImageData为打包获取到的图片文件流。
    let compressedImageData: ArrayBuffer = await imagePackerApi.packing(sourcePixelMap, packOpts);
    // 压缩目标图像字节长度
    const maxCompressedImageByte = maxCompressedImageSize * BYTE_CONVERSION;
    // TODO 知识点：图片压缩。先判断设置图片质量参数quality为0时，packing能压缩到的图片最小字节大小是否满足指定的图片压缩大小。如果满足，则使用packing方式二分查找最接近指定图片压缩目标大小的quality来压缩图片。如果不满足，则使用scale对图片先进行缩放，采用while循环每次递减0.4倍缩放图片，再用packing（图片质量参数quality设置0）获取压缩图片大小，最终查找到最接近指定图片压缩目标大小的缩放倍数的图片压缩数据。
    if (maxCompressedImageByte > compressedImageData.byteLength) {
      // 使用packing二分压缩获取图片文件流
      compressedImageData = await this.packingImage(compressedImageData, sourcePixelMap, IMAGE_QUALITY, maxCompressedImageByte);
    } else {
      // 使用scale对图片先进行缩放，采用while循环每次递减0.4倍缩放图片，再用packing（图片质量参数quality设置0）获取压缩图片大小，最终查找到最接近指定图片压缩目标大小的缩放倍数的图片压缩数据
      let imageScale = 1; // 定义图片宽高的缩放倍数，1表示原比例。
      const REDUCE_SCALE = 0.4; // 图片缩小倍数
      // 判断压缩后的图片大小是否大于指定图片的压缩目标大小，如果大于，继续降低缩放倍数压缩。
      while (compressedImageData.byteLength > maxCompressedImageByte) {
        if (imageScale > 0) {
          // 性能知识点: 由于scale会直接修改图片PixelMap数据，所以不适用二分查找scale缩放倍数。这里采用循环递减0.4倍缩放图片，来查找确定最适
          // 合的缩放倍数。如果对图片压缩质量要求不高，建议调高每次递减的缩放倍数reduceScale，减少循环，提升scale压缩性能。
          imageScale = imageScale - REDUCE_SCALE; // 每次缩放倍数减0.4
          // 使用scale对图片进行缩放
          await sourcePixelMap.scale(imageScale, imageScale);
          // packing压缩
          compressedImageData = await this.packing(sourcePixelMap, IMAGE_QUALITY);
        } else {
          // imageScale缩放小于等于0时，没有意义，结束压缩。这里不考虑图片缩放倍数小于reduceScale的情况。
          break;
        }
      }
    }
    // 保存图片，返回压缩后的图片信息。
    const compressedImageInfo: CompressedImageInfo = await this.saveImage(compressedImageData);
    return compressedImageInfo;
  }

  /**
   * packing二分方式循环压缩
   * @param compressedImageData：图片压缩的ArrayBuffer
   * @param sourcePixelMap：原始待压缩图片的PixelMap
   * @param imageQuality：图片质量参数
   * @param maxCompressedImageByte：压缩目标图像字节长度
   * @returns compressedImageData：返回二分packing压缩后的图片数据
   */
  async packingImage(compressedImageData: ArrayBuffer, sourcePixelMap: image.PixelMap, imageQuality: number, maxCompressedImageByte: number): Promise<ArrayBuffer> {
    // 图片质量参数范围为0-100，这里以10为最小二分单位创建用于packing二分图片质量参数的数组。
    const packingArray: number[] = [];
    const DICHOTOMY_ACCURACY = 10;
    // 性能知识点: 如果对图片压缩质量要求不高，建议调高最小二分单位dichotomyAccuracy，减少循环，提升packing压缩性能。
    for (let i = 0; i <= 100; i += DICHOTOMY_ACCURACY) {
      packingArray.push(i);
    }
    let left = 0; // 定义二分搜索范围的左边界
    let right = packingArray.length - 1; // 定义二分搜索范围的右边界
    // 二分压缩图片
    while (left <= right) {
      const mid = Math.floor((left + right) / 2); // 定义二分搜索范围的中间位置
      imageQuality = packingArray[mid]; // 获取二分中间位置的图片质量值
      // 根据传入的图片质量参数进行packing压缩，返回压缩后的图片文件流数据。
      compressedImageData = await this.packing(sourcePixelMap, imageQuality);
      // 判断查找一个尽可能接近但不超过压缩目标的压缩大小
      if (compressedImageData.byteLength <= maxCompressedImageByte) {
        // 二分目标值在右半边，继续在更高的图片质量参数（即mid + 1）中搜索
        left = mid + 1;
        // 判断mid是否已经二分到最后，如果二分完了，退出
        if (mid === packingArray.length - 1) {
          break;
        }
        // 获取下一次二分的图片质量参数（mid+1）压缩的图片文件流数据
        compressedImageData = await this.packing(sourcePixelMap, packingArray[mid + 1]);
        // 判断用下一次图片质量参数（mid+1）压缩的图片大小是否大于指定图片的压缩目标大小。如果大于，说明当前图片质量参数（mid）压缩出来的
        // 图片大小最接近指定图片的压缩目标大小。传入当前图片质量参数mid，得到最终目标图片压缩数据。
        if (compressedImageData.byteLength > maxCompressedImageByte) {
          compressedImageData = await this.packing(sourcePixelMap, packingArray[mid]);
          break;
        }
      } else {
        // 目标值不在当前范围的右半部分，将搜索范围的右边界向左移动，以缩小搜索范围并继续在下一次迭代中查找左半部分。
        right = mid - 1;
      }
    }
    return compressedImageData;
  }

  /**
   * packing压缩
   * @param sourcePixelMap：原始待压缩图片的PixelMap
   * @param imageQuality：图片质量参数
   * @returns data：返回压缩后的图片数据
   */
  async packing(sourcePixelMap: image.PixelMap, imageQuality: number): Promise<ArrayBuffer> {
    const imagePackerApi = image.createImagePacker();
    const packOpts: image.PackingOption = { format: "image/jpeg", quality: imageQuality };
    const data: ArrayBuffer = await imagePackerApi.packing(sourcePixelMap, packOpts);
    return data;
  }

  /**
   * 图片保存
   * @param compressedImageData：压缩后的图片数据
   * @returns compressedImageInfo：返回压缩后的图片信息
   */
  async saveImage(compressedImageData: ArrayBuffer): Promise<CompressedImageInfo> {
    const context: Context = getContext();
    // 定义要保存的压缩图片uri。afterCompressiona.jpeg表示压缩后的图片。
    const compressedImageUri: string = context.filesDir + '/' + 'afterNK.jpeg';
    try {
      const res = fs.accessSync(compressedImageUri);
      if (res) {
        // 如果图片afterCompressiona.jpeg已存在，则删除
        fs.unlinkSync(compressedImageUri);
      }
    } catch (err) {
      Logger.info(`AccessSync failed with error message: ${err.message}, error code: ${err.code}`);
    }
    // TODO 知识点：保存图片。获取最终图片压缩数据compressedImageData，保存图片。
    // 压缩图片数据写入文件
    const file: fs.File = fs.openSync(compressedImageUri, fs.OpenMode.READ_WRITE | fs.OpenMode.CREATE);
    fs.writeSync(file.fd, compressedImageData);
    fs.closeSync(file);
    // 获取压缩图片信息
    let compressedImageInfo: CompressedImageInfo = new CompressedImageInfo();
    compressedImageInfo.imageUri = compressedImageUri;
    compressedImageInfo.imageByteLength = compressedImageData.byteLength;
    return compressedImageInfo;
  }

}