export class StringUtils{
  public static isNullOrEmpty(content: string | undefined) :boolean{
    return content == undefined || content == null || content == "" || content.length <= 0;
  }

  public static isNotNullOrEmpty(content: string | undefined) :boolean{
    return !StringUtils.isNullOrEmpty(content);
  }
}