import common from '@ohos.app.ability.common';
import mediaLibrary from '@ohos.multimedia.mediaLibrary';
import wantConstant from '@ohos.ability.wantConstant';
import { MediaBean } from '../bean/MediaBean';
import { StringUtils } from './StringUtils';
import picker from '@ohos.file.picker';
import { Logger } from './Logger';
import Want from '@ohos.app.ability.Want';
import { BusinessError } from '@ohos.base';
import ability from '@ohos.ability.ability';

export interface PhotoSelectResult{
  photoUris: Array<string>;
  isOriginalPhoto: boolean;
}

/**
 * 多媒体辅助类
 */
export class MediaHelper {
  private readonly TAG: string = 'MediaHelper';

  private mContext: common.Context;

  constructor(context: common.Context) {
    this.mContext = context;
  }

  /**
   * 选择图片
   */
  public async selectPicture(): Promise<MediaBean> {
    try {
      let photoSelectOptions = new picker.PhotoSelectOptions();
      photoSelectOptions.MIMEType = picker.PhotoViewMIMETypes.IMAGE_TYPE;
      photoSelectOptions.maxSelectNumber = 1;
      let photoPicker = new picker.PhotoViewPicker();
      return photoPicker.select(photoSelectOptions)
        .then((photoSelectResult: PhotoSelectResult) => {
          Logger.info(this.TAG, 'PhotoViewPicker.select successfully, PhotoSelectResult uri: ' + JSON.stringify(photoSelectResult));
          if (photoSelectResult && photoSelectResult.photoUris && photoSelectResult.photoUris.length > 0) {
            let filePath = photoSelectResult.photoUris[0];
            Logger.info(this.TAG, 'PhotoViewPicker.select successfully, PhotoSelectResult uri: ' + filePath);
            return filePath;
          } else {
            return "";
          }
        }).catch((err: BusinessError) => {
          Logger.error(this.TAG, 'PhotoViewPicker.select failed with err: ' + err);
          return "";
        })
        .then(async (filePath) => {
          const mediaBean = await this.buildMediaBean(filePath);
          return mediaBean;
        });
    } catch (err) {
      Logger.error(this.TAG, 'PhotoViewPicker failed with err: ' + err);
      return Promise.reject(err);
    }
  }

  /**
   * 选择文件
   */
  public selectFile(): Promise<MediaBean> {
    try {
      let documentSelectOptions = new picker.DocumentSelectOptions();
      let documentPicker = new picker.DocumentViewPicker();
      return documentPicker.select(documentSelectOptions)
        .then((documentSelectResult: Array<string>) => {
          Logger.info(this.TAG, 'DocumentViewPicker.select successfully, DocumentSelectResult uri: ' + JSON.stringify(documentSelectResult));
          if (documentSelectResult && documentSelectResult.length > 0) {
            let filePath = documentSelectResult[0];
            Logger.info(this.TAG, 'DocumentViewPicker.select successfully, DocumentSelectResult uri: ' + filePath);
            return filePath;
          } else {
            return "";
          }
        }).then(async (filePath: string) => {
          let mediaBean: MediaBean = await this.buildMediaBean(filePath);
          return mediaBean;
        }).catch((err: BusinessError) => {
          Logger.error(this.TAG, 'PhotoViewPicker.select failed with err: ' + err);
          return new MediaBean();
        });
    } catch (err) {
      Logger.error(this.TAG, 'PhotoViewPicker failed with err: ' + err);
      return Promise.reject(err);
    }
  }

  /**
   * 拍照
   */
  public async takePhoto(context: common.UIAbilityContext): Promise<MediaBean> {
    let want: Want = {
      action: "ohos.want.action.imageCapture",
      parameters: {
        "callBundleName": context.abilityInfo.bundleName,
      }
    };
    return context.startAbilityForResult(want)
      .then(async (result: ability.AbilityResult)=>{
        if (result.resultCode === 0 && result.want && StringUtils.isNotNullOrEmpty(result.want.uri?result.want.uri:"")) {
          let mediaBean = await this.buildMediaBean(result.want.uri?result.want.uri:"");
          return mediaBean;
        } else {
          return new MediaBean();
        }
      }).catch((error: BusinessError) => {
        Logger.info(`startAbility error , ${JSON.stringify(error)}`);
        return new MediaBean();
      });
  }

  /**
   * 拍照
   */
  public async takePhotoInput(context: common.UIAbilityContext): Promise<string> {
    let want: Want = {
      action: "ohos.want.action.imageCapture",
      parameters: {
        "callBundleName": context.abilityInfo.bundleName,
      }
    };
    return context.startAbilityForResult(want)
      .then((result: ability.AbilityResult) => {
        if (result.resultCode === 0 && result.want) {
          return result.want?.parameters?.resourceUri as string;;
        } else {
          return "";
        }
      }).catch((error: BusinessError) => {
        Logger.info(`startAbility error , ${JSON.stringify(error)}`);
        return "";
      });
  }

  /**
   * 选择相册
   */
  public async startAlbumAbility(context: common.UIAbilityContext): Promise<MediaBean>{
    let str: Want = {
      "deviceId": "",
      "bundleName": "",
      "abilityName": "",
      "uri": "",
      "action": "android.intent.action.GET_CONTENT",
      "type":"image/*"
    };
    return context.startAbilityForResult(str)
      .then(async (result: ability.AbilityResult)=>{
        Logger.info(`startAbility call back , ${JSON.stringify(result)}`);
        if (result.resultCode === 0 && result.want && StringUtils.isNotNullOrEmpty(result.want.uri?result.want.uri:"")) {
          Logger.info('Operation successfully, Operation uri: ' + result.want.uri);
          let mediaBean: MediaBean = await this.buildMediaBean(result.want.uri?result.want.uri:"");
          return mediaBean;
        } else {
          return new MediaBean();
        }
      }).catch((error: BusinessError) => {
        Logger.info(`startAbility error , ${JSON.stringify(error)}`);
        return new MediaBean();
      });
  }

  /**
   * 选择相册
   */
  public async startAlbumAbilityInput(context: common.UIAbilityContext): Promise<string>{
    let str: Want = {
      "deviceId": "",
      "bundleName": "",
      "abilityName": "",
      "uri": "",
      "action": "android.intent.action.GET_CONTENT",
      "type":"image/*"
    };
    return context.startAbilityForResult(str)
      .then((result: ability.AbilityResult)=>{
        Logger.info(`startAbility call back , ${JSON.stringify(result)}`);
        if (result.resultCode === 0 && result.want) {
          return result.want?.parameters?.resourceUri as string;;
        } else {
          return "";
        }
      }).catch((error: BusinessError) => {
        Logger.info(`startAbility error , ${JSON.stringify(error)}`);
        return "";
      });
  }


  /**
   * 封装多媒体实体类
   *
   * @param uri 文件路径
   */
  private async buildMediaBean(uri: string): Promise<MediaBean> {
    if (StringUtils.isNullOrEmpty(uri)) {
      return new MediaBean();
    }
    const mediaBean: MediaBean = new MediaBean();
    mediaBean.localUrl = uri;
    await this.appendFileInfoToMediaBean(mediaBean, uri);
    return mediaBean;
  }

  /**
   * 通过Uri查找所选文件信息，插入到MediaBean中
   * @param mediaBean
   * @param uri
   */
  private async appendFileInfoToMediaBean(mediaBean: MediaBean, uri: string) {

    if (StringUtils.isNullOrEmpty(uri)) {
      return;
    }
    let fileList: Array<mediaLibrary.FileAsset> = [];

    const parts: string[] = uri.split('/');
    const id: string = parts.length > 0 ? parts[parts.length - 1] : '-1';

    try {

      let media = mediaLibrary.getMediaLibrary(this.mContext);
      let mediaFetchOptions: mediaLibrary.MediaFetchOptions = {
        selections: mediaLibrary.FileKey.ID + '= ?',
        selectionArgs: [id],
        uri: uri
      };

      let fetchFileResult = await media.getFileAssets(mediaFetchOptions);
      Logger.info(this.TAG, `fileList getFileAssetsFromType fetchFileResult.count = ${fetchFileResult.getCount()}`);
      fileList = await fetchFileResult.getAllObject();
      fetchFileResult.close();
      await media.release();

    } catch (e) {
      Logger.error(this.TAG, "query: file data  exception ");
    }

    if (fileList && fileList.length > 0) {

      let fileInfoObj = fileList[0];
      Logger.info(`file id = ${JSON.stringify(fileInfoObj.id)} , uri = ${JSON.stringify(fileInfoObj.uri)}`);
      Logger.info(`file fileList displayName = ${fileInfoObj.displayName} ,size = ${fileInfoObj.size} ,mimeType = ${fileInfoObj.mimeType}`);

      mediaBean.fileName = fileInfoObj.displayName;
      mediaBean.fileSize = fileInfoObj.size;
      mediaBean.fileType = fileInfoObj.mimeType;
      mediaBean.fileId = fileInfoObj.id;

    }
  }




}