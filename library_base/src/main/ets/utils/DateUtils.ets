export function formateTime(timestamp: number): string{
  const date = new Date(timestamp);
  // 获取年、月、日等信息
  const year = date.getFullYear();
  const month = (date.getMonth() + 1).toString().padStart(2, '0');
  const day = date.getDate().toString().padStart(2, '0');
  const hours = date.getHours().toString().padStart(2, '0');
  const minutes = date.getMinutes().toString().padStart(2, '0');
  const seconds = date.getSeconds().toString().padStart(2, '0');
  let str=`${year}-${month}-${day} ${hours}:${minutes}:${seconds}`;
  return str;
}