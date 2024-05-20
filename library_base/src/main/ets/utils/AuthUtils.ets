import userIAM_userAuth from '@ohos.userIAM.userAuth';
import { Logger } from './Logger';
import { ToastUtils } from './ToastUtils';

export class AuthUtils{
  callFaceAuth() {
    // 查询认证能力是否支持
    try {
      userIAM_userAuth.getAvailableStatus(userIAM_userAuth.UserAuthType.FACE, userIAM_userAuth.AuthTrustLevel.ATL1);
      Logger.info("current auth trust level is supported");
      let challenge = new Uint8Array([1, 2, 3, 4, 5, 6, 7, 8]);
      let authType = userIAM_userAuth.UserAuthType.FACE;
      let authTrustLevel = userIAM_userAuth.AuthTrustLevel.ATL1;

      // 获取认证对象
      let auth = userIAM_userAuth.getAuthInstance(challenge, authType, authTrustLevel);
      Logger.info("get auth instance success");
      // 订阅认证结果
      auth.on("result", {
        callback: (result: userIAM_userAuth.AuthResultInfo) => {
          Logger.info("authV9 result " + result.result);
          Logger.info("authV9 token " + result.token);
          Logger.info("authV9 remainAttempts " + result.remainAttempts);
          Logger.info("authV9 lockoutDuration " + result.lockoutDuration);
          auth.cancel();
        }
      });
      Logger.info("subscribe authentication event success");

      // 开始认证
      auth.start();
      Logger.info("authV9 start auth success");
    } catch (error) {
      ToastUtils.show("当前设备不支持人脸认证");
      Logger.info("current auth trust level is not supported, error = " + error);
    }
  }

  callFingerAuth() {
    // 查询认证能力是否支持
    try {
      userIAM_userAuth.getAvailableStatus(userIAM_userAuth.UserAuthType.FINGERPRINT, userIAM_userAuth.AuthTrustLevel.ATL1);
      Logger.info("current auth trust level is supported");
      let challenge = new Uint8Array([1, 2, 3, 4, 5, 6, 7, 8]);
      let authType = userIAM_userAuth.UserAuthType.FINGERPRINT;
      let authTrustLevel = userIAM_userAuth.AuthTrustLevel.ATL1;

      // 获取认证对象
      let auth = userIAM_userAuth.getAuthInstance(challenge, authType, authTrustLevel);
      Logger.info("get auth instance success");
      // 订阅认证结果
      auth.on("result", {
        callback: (result: userIAM_userAuth.AuthResultInfo) => {
          Logger.info("authV9 result " + result.result);
          Logger.info("authV9 token " + result.token);
          Logger.info("authV9 remainAttempts " + result.remainAttempts);
          Logger.info("authV9 lockoutDuration " + result.lockoutDuration);
          auth.cancel();
        }
      });
      Logger.info("subscribe authentication event success");

      // 开始认证
      auth.start();
      Logger.info("authV9 start auth success");
    } catch (error) {
      ToastUtils.show("当前设备不支持指纹认证");
      Logger.info("current auth trust level is not supported, error = " + error);
    }
  }
}