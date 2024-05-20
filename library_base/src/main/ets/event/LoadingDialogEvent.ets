/**
 * 展示Loading的Event
 * @param showLoading
 * @param "
 * @returns
 */
import emitter from '@ohos.events.emitter'

export function LoadingDialogEvent(showLoading: boolean, loadingTips: string = "加载中...") : emitter.EventData{
  return {
    data: {
      "showLoading": showLoading,
      "loadingTips": loadingTips
    }
  }
}
