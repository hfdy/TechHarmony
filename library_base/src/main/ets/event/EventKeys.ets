import emitter from '@ohos.events.emitter'

/**
 * 事件的EventNum
 */
export class EventKeys {
  //展示loading的事件处理EventID
  static readonly LOADING_DIALOG_EVENT = 0x10000
  static readonly SCAN_EVENT = 0x20000
}

/**
 * 对应的事件
 */
export const loadingEvent:emitter.InnerEvent  = {
  eventId: EventKeys.LOADING_DIALOG_EVENT
}

export const scanEvent:emitter.InnerEvent  = {
  eventId: EventKeys.SCAN_EVENT
}
