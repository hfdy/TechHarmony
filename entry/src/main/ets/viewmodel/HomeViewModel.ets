import { BaseViewModel, Logger, ResultCallback } from 'library_base/Index';
import { getHomeBanner, getProjectList, getProjectTab } from '../http/apiService';

export class HomeViewModel extends BaseViewModel{
  /**
   * banner
   */
  async getHomeBanner(resultCallback?: ResultCallback) {
    await this.httpRequest()
      .promise(getHomeBanner(), false)
      .then(async result => {
        Logger.info("banner结果："+JSON.stringify(result));
        if (result.errorCode == 0) {
          resultCallback?.(result.data);
        } else {
          resultCallback?.([]);
        }
      });
  }

  /**
   * tab
   */
  async getProjectTab(resultCallback?: ResultCallback) {
    await this.httpRequest()
      .promise(getProjectTab(), false)
      .then(async result => {
        Logger.info("tab结果："+JSON.stringify(result));
        if (result.errorCode == 0) {
          resultCallback?.(result.data);
        } else {
          resultCallback?.([]);
        }
      });
  }

  /**
   * 列表
   */
  async getProjectList(page: number, cid: number, resultCallback?: ResultCallback) {
    await this.httpRequest()
      .promise(getProjectList(page, cid), true)
      .then(async result => {
        Logger.info("列表结果："+JSON.stringify(result));
        if (result.errorCode == 0) {
          resultCallback?.(result.data);
        } else {
          resultCallback?.([]);
        }
      });
  }
}