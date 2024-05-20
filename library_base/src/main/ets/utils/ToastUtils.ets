import promptAction from '@ohos.promptAction';

export class ToastUtils{
  public static show(msg: string) {
    if (msg) {
      promptAction.showToast({
        message: msg,
        duration: 2000,
      });
    }
  }
}