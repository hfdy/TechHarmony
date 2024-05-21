import { ApiResponse } from './AxiosHttp';
import axios from "@ohos/axios"
import { ViewStateConstant } from '../constants/ViewStateConstant';
import { BusinessError } from '@kit.BasicServicesKit';

/**
 * 定义请求状态的hooks，根据请求接口来使用,需要配置页面多状态的StateComponent一起使用
 * 本来想类似React或Vue中使用hook的方式，但是ArkTs没有组件状态共享在组件外使用的方法，退而求其次使用回调实现
 */
export interface LoadStateResult {
  promise: <T>(requestPromise: Promise<T>, showLoadingState?: boolean) => Promise<T>;
}

function updateViewState(realState: string, stateCallback?: (state: string) => void) {
  stateCallback?.(realState);
}

function run<T>(requestPromise: Promise<T>, showLoadingState?: boolean, checkResult: boolean = false, stateCallback?: (state: string) => void): Promise<T> {
  if (showLoadingState !== false) {
    updateViewState(ViewStateConstant.VIEW_STATE_LOADING, stateCallback)
  }
  return new Promise<T>((resolve, reject) => {
    requestPromise.then((res) => {
      if (checkResult) {
        const result: ApiResponse = res as ApiResponse;
        const resultData: object = result.data;
        if (result.errorCode !== 0) {
          updateViewState(ViewStateConstant.VIEW_STATE_ERROR, stateCallback)
        } else if (Array.isArray(resultData) && resultData.length === 0) {
          updateViewState(ViewStateConstant.VIEW_STATE_EMPTY)
        } else {
          updateViewState(ViewStateConstant.VIEW_STATE_SUCCESS, stateCallback)
        }
      } else {
        updateViewState(ViewStateConstant.VIEW_STATE_SUCCESS, stateCallback)
      }
      resolve(res);
    }).catch((error: BusinessError) => {
      if (axios.isAxiosError(error)) {
        updateViewState(ViewStateConstant.VIEW_STATE_NETWORK_ERROR, stateCallback)
      } else {
        updateViewState(ViewStateConstant.VIEW_STATE_ERROR, stateCallback)
      }
      reject(error);
    })
  })
}

const useRequestStatus = (stateCallback?: (state: string) => void, checkResult: boolean = false) => {
  let result:LoadStateResult = {
    promise: run
  };
  return result;
}

export default useRequestStatus;

