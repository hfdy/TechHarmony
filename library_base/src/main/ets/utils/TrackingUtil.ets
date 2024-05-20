export class TrackingUtil {
  private static eventStart: number = 0;
  private static eventEnd: number = 0;

  static setEventStart(start: number) {
    TrackingUtil.eventStart = start;
  }

  static setEventEnd(end: number) {
    TrackingUtil.eventEnd = end;
  }

  static getEventTime() :number{
    let time = TrackingUtil.eventEnd - TrackingUtil.eventStart;
    TrackingUtil.eventEnd = 0;
    TrackingUtil.eventStart = 0;
    return time > 0 ? time : -1;
  }

  static obtainStart() :boolean{
    return TrackingUtil.eventStart > 0;
  }
}