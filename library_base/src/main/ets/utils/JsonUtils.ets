export class JsonUtils {
  private constructor() {
  }

  static stringify(data: object, space: number = 2): string {
    return JSON.stringify(data, null, space);
  }

  static parse(jsonString: string): object {
    return JSON.parse(jsonString);
  }
}