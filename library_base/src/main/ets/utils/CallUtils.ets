import call from '@ohos.telephony.call';
import { ToastUtils } from './ToastUtils';

/**
 * 跳转拨号
 */
export class CallUtils{
  public static callPhone(phone: string) {
    if (phone) {
      // 调用查询能力接口
      let isSupport = call.hasVoiceCapability();
      if (!isSupport) {
        ToastUtils.show("当前设备不支持呼叫能力");
        return;
      }
      call.makeCall(phone);
    }
  }
}