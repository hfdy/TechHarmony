import { HeaderStyleDefault, VisiableState } from '../constants/Style';
import { StringUtils } from '../utils/StringUtils';

export interface HeaderStyleConfig{
  barColor?:string;
  barState?:string;
  title?:string;
  titleColor?:string;
  backState?:string;
  closeState?:string;
  moreState?:string;
  moreAction?:Array<Action>;
}

export interface Action{
  name?:string;
}

export function initHeaderStyleConfig(options?: Partial<HeaderStyleConfig>): HeaderStyleConfig {
  const defaults: HeaderStyleConfig = {
    barColor:HeaderStyleDefault.BAR_COLOR,
    barState:VisiableState.HIDE,
    titleColor:HeaderStyleDefault.TITLE_COLOR,
    backState:VisiableState.HIDE,
    closeState:VisiableState.HIDE,
    moreState:VisiableState.HIDE
  };
  if (options == undefined) {
    return defaults;
  } else {
    if (StringUtils.isNullOrEmpty(options.barColor)) {
      options.barColor = HeaderStyleDefault.BAR_COLOR;
    }
    if (StringUtils.isNullOrEmpty(options.barState)) {
      options.barState = VisiableState.HIDE;
    }
    if (StringUtils.isNullOrEmpty(options.titleColor)) {
      options.titleColor = HeaderStyleDefault.TITLE_COLOR;
    }
    if (StringUtils.isNullOrEmpty(options.backState)) {
      options.backState = VisiableState.HIDE;
    }
    if (StringUtils.isNullOrEmpty(options.closeState)) {
      options.closeState = VisiableState.HIDE;
    }
    if (StringUtils.isNullOrEmpty(options.moreState)) {
      options.moreState = VisiableState.HIDE;
    }
    return options;
  }
}