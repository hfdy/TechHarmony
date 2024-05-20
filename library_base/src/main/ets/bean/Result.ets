export class ResultCode{
  static readonly DEFAULT:string="0";
  static readonly SUCCESS:string="1";
  static readonly FAIL:string="0";
  static readonly OTHER:string="2";
  static readonly CANCEL:string="3";
}
export class ResultMessage{
  static readonly DEFAULT:string="操作失败";
  static readonly SUCCESS:string="操作成功";
  static readonly FAIL:string="操作失败";
  static readonly FAIL_PERMISSION_DENIED:string="拒绝授权";
}