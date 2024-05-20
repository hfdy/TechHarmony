export class PermissionUtils{
  static getPermission(code: Array<string>) : Array<string>{
    let list = new Array<string>();
    if (code != null && code.length > 0) {
      for (let index = 0; index < code.length; index++) {
        let permissionList = PermissionUtils.convertPermission(code[index]);
        for (let perIndex = 0; perIndex < code.length; perIndex++) {
          list.push(permissionList[perIndex]);
        }
      }
    }
    return list;
  }

  static convertPermission(realKey: string) : Array<string>{
    let list = new Array<string>();
    if ("11006" == realKey) {
      //模糊定位
      list.push('ohos.permission.APPROXIMATELY_LOCATION');
      list.push('ohos.permission.LOCATION');
    } else if ("11007" == realKey) {
      //精准定位
      list.push('ohos.permission.APPROXIMATELY_LOCATION');
      list.push('ohos.permission.LOCATION');
    } else if ("11009" == realKey) {
      //通知
      list.push('ohos.permission.ACCESS_NOTIFICATION_POLICY');
      list.push('ohos.permission.NOTIFICATION_CONTROLLER');
    } else if ("11004" == realKey) {
      //通讯录
      list.push('ohos.permission.READ_CONTACTS');
    } else if ("11008" == realKey) {
      //麦克风
      list.push('ohos.permission.READ_AUDIO');
      list.push('ohos.permission.WRITE_AUDIO');
    } else if ("11001" == realKey) {
      // "相机"
      list.push('ohos.permission.CAMERA');
    } else if ("11002" == realKey || "11003" == realKey) {
      //相册、存储
      list.push('ohos.permission.READ_MEDIA');
      list.push('ohos.permission.WRITE_MEDIA');
    } else if ("11100" == realKey) {
      //蓝牙
      list.push('ohos.permission.MANAGE_BLUETOOTH');
      list.push('ohos.permission.DISCOVER_BLUETOOTH');
      list.push('ohos.permission.USE_BLUETOOTH');
    } else if ("11005" == realKey) {
      //设备信息、电话状态
      list.push('ohos.permission.ENTERPRISE_GET_DEVICE_INFO');
    } else if ("11101" == realKey) {
      //面容 允许应用使用生物特征识别能力进行身份认证
      list.push('ohos.permission.ACCESS_BIOMETRIC');
    }
    return list;
  }
}