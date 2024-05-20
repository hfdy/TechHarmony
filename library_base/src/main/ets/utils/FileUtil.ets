import zlib from '@ohos.zlib';
import fs from '@ohos.file.fs';
import { Logger } from './Logger';
import SysPermissionUtils from './SysPermissionUtils';
import { ToastUtils } from './ToastUtils';

/**
 * 复制rawfile文件到本地
 * /data/storage/el2/base/haps/entry/files/index.html
 */
export async function copyFromResource(context:Context, fileName: string, destPath:string): Promise<string>{
  return new Promise((resolve)=>{
    SysPermissionUtils.request(context, async (isGranted: boolean, permission: string) => {
      if (permission === "ohos.permission.READ_MEDIA") {
        if (isGranted) {
          let array = await context.resourceManager.getRawFileContent(fileName);
          let file = fs.openSync(destPath, fs.OpenMode.READ_WRITE | fs.OpenMode.CREATE);
          fs.writeSync(file.fd, array.buffer);
          fs.closeSync(file);
          resolve(destPath);
        } else {
          ToastUtils.show("请开启读写权限");
          resolve("");
        }
      }
    }, "ohos.permission.READ_MEDIA", "ohos.permission.WRITE_MEDIA");
  });
}

/**
 * 解压文件
 * @param zipPath
 */
@Concurrent
export async function unzipFile(zipFilePath:string,outFliePath:string): Promise<number>{
  Logger.info("--------开始解压-------输入："+zipFilePath+"------输出："+outFliePath);
  Logger.info("--------开始解压-------输入："+fs.accessSync(zipFilePath)+"------输出："+fs.accessSync(outFliePath));
  try {
    let result = await zlib.decompressFile(zipFilePath, outFliePath);
    return 0;
  } catch (e) {
    return -1;
  }
}



/**
 * 创建文件
 */
export function createFile(filePath:string){
  fs.mkdirSync(filePath);
}

/**
 * 删除文件
 */
export function deleteFile(filePath:string){
  fs.rmdirSync(filePath);
}
