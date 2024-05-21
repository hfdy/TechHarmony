import { ApiResponse, API_DOMAIN, axiosClient, AxiosRequestHeaders } from 'library_base';

/**
 * 获取banner
 */
export interface Banner{
  id: number;
  url: string; //网站地址
  imagePath: string; //图片地址
  title: string;
  desc: string;
  isVisible: number;
  order: number;
  type: number;
}

export function getHomeBanner() {
  return axiosClient.get<ApiResponse<Array<Banner>>>({
    headers: {"Content-Type": "application/json"} as AxiosRequestHeaders,
    url: API_DOMAIN + "banner/json",
    showLoading: false,
  })
}

/**
 * 首页Tab
 */
export interface ProjectTabItem{
  id: number;
  name: string;
}

export function getProjectTab() {
  return axiosClient.get<ApiResponse<Array<ProjectTabItem>>>({
    headers: {"Content-Type": "application/json"} as AxiosRequestHeaders,
    url: API_DOMAIN + "project/tree/json",
    showLoading: false,
  })
}

/**
 * 首页项目列表
 */
export interface ProjectSubList{
  datas: Array<ProjectSubInfo>;
}

export interface ProjectSubInfo{
  id: number;
  author: string;
  desc: string;
  envelopePic: string;
  link: string;
  niceDate: string;
  title: string;
  shareUser: string;
}

export function getProjectList(page: number, cid: number) {
  return axiosClient.get<ApiResponse<ProjectSubList>>({
    headers: {"Content-Type": "application/json"} as AxiosRequestHeaders,
    url: API_DOMAIN + `project/list/${page}/json?cid=${cid}`,
    showLoading: false,
  });
}

