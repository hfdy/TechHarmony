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

/**
 * 分类列表
 */
export interface CategoryItem{
  cid: number;
  name: string;
  isSelected: Boolean;
  articles: Array<CategorySecondItem>;
}

export interface CategorySecondItem{
  id: number;
  link: string;
  title: string;
  chapterId: number;
}

export function getCategoryData() {
  return axiosClient.get<ApiResponse<Array<CategoryItem>>>({
    headers: {"Content-Type": "application/json"} as AxiosRequestHeaders,
    url: API_DOMAIN + "navi/json",
    showLoading: false,
  })
}

/**
 * 发现列表
 */
export interface SystemList{
  id: number;
  courseId: number;
  name: string;       //一级名称
  children: Array<SystemSecondList>;
  visible: number;
}

export interface SystemSecondList{
  id: number;
  name: string; // 二级名称
  visible: number;
}

export function getSystemList() {
  return axiosClient.get<ApiResponse<Array<SystemList>>>({
    headers: {"Content-Type": "application/json"} as AxiosRequestHeaders,
    url: API_DOMAIN + "tree/json",
    showLoading: false,
  })
}

/**
 * 我的
 */
export interface ArticleList{
  curPage: number;
  offset: number;
  size: number;
  total: number;
  pageCount: number;
  datas: Array<ArticleInfo>;
}

export interface ArticleInfo{
  id: number;
  userId: number;
  courseId: number;
  originId: number;
  collect: boolean;
  title: string;
  desc: string;
  link: string;
  zan: number;
  niceShareDate: string;
  niceDate: string;
  publishTime: number;
  shareUser: string;
  author: string;
  superChapterName: string;
  chapterName: string;
  tags: Array<object>;
}

export function getKnowledge(currentPage:number, pageSize: number) {
  return axiosClient.get<ApiResponse<Array<ArticleList>>>({
    headers: {"Content-Type": "application/json"} as AxiosRequestHeaders,
    url: API_DOMAIN + `article/list/${currentPage}/json?page_size=${pageSize}`,
    showLoading: false,
  })
}

