import { BaseViewModel, Logger, ResultCallback } from 'library_base/Index';
import { getCategoryData } from '../http/apiService';

export class CategoriesContentViewModel extends BaseViewModel{
  /**
   * 分类列表
   */
  async getCategoryData(resultCallback?: ResultCallback) {
    await this.httpRequest()
      .promise(getCategoryData(), false)
      .then(async result => {
        Logger.info("分类列表结果："+JSON.stringify(result));
        if (result.errorCode == 0) {
          resultCallback?.(result.data);
        } else {
          resultCallback?.([]);
        }
      });
  }
}