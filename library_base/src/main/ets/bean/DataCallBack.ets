import { ResultCode, ResultMessage } from './Result';

export interface CallBackResult{
  success: string;
  msg: string;
  payload?: object;
}

export function dataCallBack(code: string, message: string, data?: object) :CallBackResult{
  let result: CallBackResult = {
    success: code,
    msg: message,
  };
  if (data) {
    if (Object.keys(data).includes('payload')) {
      result.payload = data['payload'];
    } else {
      result.payload = data;
    }
  }
  return result;
}

/**
 * 同步成功回调
 * @param data
 * @returns
 */
export function sendSuccessCallBack(data?: object): CallBackResult{
  return dataCallBack(ResultCode.SUCCESS, ResultMessage.SUCCESS, data);
}

/**
 * 同步失败回调
 * @param data
 * @returns
 */
export function sendFailCallBack(data?: object): CallBackResult{
  return dataCallBack(ResultCode.FAIL, ResultMessage.FAIL, data);
}


