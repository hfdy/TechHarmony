export class HeaderStyleDefault {
  static readonly BAR_COLOR: string = '#ffffff';
  static readonly TITLE_COLOR: string = '#333333';
}


export const PERCENTAGE_100='100%';

enum VisiableState{
  HIDE='0',
  DEFAULT='1',
  CUSTOM='2',
}


/**
 * 字体的大小
 */
enum AppFontSize{
  SMALLER=13,
  SMALL=14,
  NORMAL=16,
  LARGE=20,
  LARGER=35,
}

/**
 * 字体加粗
 */
enum AppFontWeight{
  BOLD ='400',
  BOLDER ='500',
}

export{AppFontSize,AppFontWeight,VisiableState}