import pasteboard from '@ohos.pasteboard';
import { ClipBean } from '../bean/ClipBean';

/**
 * 剪贴板
 */
export class ClipUtils{

  /**
   * 写入剪切板
   * @param msg
   */
  public async copyMsg(msg: string) {
    let clip = pasteboard.getSystemPasteboard();
    if (clip != null) {
      await clip.setData(pasteboard.createData('text/plain',msg));
    }
  }

  /**
   * 获取剪切板
   */
  public async getCopy(clipBean: ClipBean){
    let clip = pasteboard.getSystemPasteboard();
    if (clip != null) {
      let pasteData = await clip.getData();
      let text = pasteData.getPrimaryText();
      if (text != undefined && text != "") {
        clipBean.payload.clip = text;
      } else {
        clipBean.payload.clip = "";
      }
    }
  }

  /**
   * 清空剪切板
   * @param msg
   */
  public async clearCopy() {
    let clip = pasteboard.getSystemPasteboard();
    if (clip != null) {
      await clip.clearData();
    }
  }
}