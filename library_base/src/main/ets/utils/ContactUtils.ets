import { Context } from '@ohos.abilityAccessCtrl';
import { contact } from '@kit.ContactsKit';
import { CallBackResult, sendFailCallBack, sendSuccessCallBack } from '../bean/DataCallBack';
import { ToastUtils } from './ToastUtils';
import SysPermissionUtils from './SysPermissionUtils';

/**
 * 获取联系人信息
 */
export class ContactUtils{
  async getAllContacts(context: Context): Promise<CallBackResult>{
    return new Promise((resolve)=>{
      SysPermissionUtils.request(context, async (isGranted: boolean, permission: string) => {
        if (permission === "ohos.permission.READ_CONTACTS") {
          if (isGranted) {
            if (canIUse("SystemCapability.Applications.ContactsData")) {
              let contactData = await contact.queryContacts(context, {
                holderId: 0,
                bundleName: "",
                displayName: ""
              }, {
                attributes: [contact.Attribute.ATTR_NAME, contact.Attribute.ATTR_PHONE]
              });
              resolve(sendSuccessCallBack(contactData));
            } else {
              ToastUtils.show("该设备暂不支持联系人");
              resolve(sendFailCallBack());
            }
          } else {
            ToastUtils.show("请开启联系人权限");
            resolve(sendFailCallBack());
          }
        }
      }, "ohos.permission.READ_CONTACTS");
    });
  }
}