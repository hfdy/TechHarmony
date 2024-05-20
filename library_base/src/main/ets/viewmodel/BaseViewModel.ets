import useRequestStatus, { LoadStateResult } from '../http/useRequestStatus'

export type StateCallback = (state: string) => void

export type ResultCallback = (result: object) => void

export class BaseViewModel {
  private stateCallback?: StateCallback

  observeState(stateCallback: StateCallback) {
    this.stateCallback = stateCallback
  }

  dispatchViewState(state: string) {
    this.stateCallback?.(state)
  }

  httpRequest(checkResult?: boolean): LoadStateResult{
    return useRequestStatus((state): void => this.dispatchViewState(state), checkResult);
  }
}