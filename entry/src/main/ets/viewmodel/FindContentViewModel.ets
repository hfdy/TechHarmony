import { BaseViewModel, Logger, ResultCallback } from 'library_base/Index';
import { getSystemList } from '../http/apiService';

export class FindContentViewModel extends BaseViewModel{
  /**
   * 发现列表
   */
  async getSystemList(resultCallback?: ResultCallback) {
    await this.httpRequest()
      .promise(getSystemList(), false)
      .then(async result => {
        Logger.info("发现列表结果："+JSON.stringify(result));
        if (result.errorCode == 0) {
          resultCallback?.(result.data);
        } else {
          resultCallback?.([]);
        }
      });
  }
}