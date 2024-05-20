import hilog from '@ohos.hilog';

/**
 * 日志工具
 */
export class Logger {
  private static domain: number = 0xFF00;
  private static prefix: string = 'NkOa';

  private static formatter: string = '%{public}s ';

  static debug(...args: string[]): void {
    hilog.debug(this.domain, this.prefix, this.formatter, args);
  }

  static info(...args: string[]): void {
    hilog.info(this.domain, this.prefix, this.formatter, args);
  }

  static warn(...args: string[]): void {
    hilog.warn(this.domain, this.prefix, this.formatter, args);
  }

  static error(...args: string[]): void {
    hilog.error(this.domain, this.prefix, this.formatter, args);
  }
}