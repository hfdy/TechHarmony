import { BaseViewModel, Logger, ResultCallback } from 'library_base/Index';
import { getKnowledge, getSystemList } from '../http/apiService';

export class MineContentViewModel extends BaseViewModel{
  /**
   * 资讯列表
   */
  async getKnowledge(currentPage:number, pageSize: number, resultCallback?: ResultCallback) {
    await this.httpRequest()
      .promise(getKnowledge(currentPage, pageSize), false)
      .then(async result => {
        Logger.info("资讯列表结果："+JSON.stringify(result));
        if (result.errorCode == 0) {
          resultCallback?.(result.data);
        } else {
          resultCallback?.([]);
        }
      });
  }
}