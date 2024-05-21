/**
 * 首页
 */
import { Banner, ProjectSubInfo, ProjectSubList, ProjectTabItem } from '../http/apiService';
import { HomeViewModel } from '../viewmodel/HomeViewModel';

@Component
export struct HomeContent {
  @State bannerData: Array<Banner> = [];
  @State tabData: Array<ProjectTabItem> = [];
  @State listData: Array<ProjectSubInfo> = [];
  @State fontColor: string = '#182431';
  @State selectedFontColor: string = '#0159a5';
  @State currentIndex: number = 0;
  private homeViewModel: HomeViewModel = new HomeViewModel();
  private swiperController: SwiperController = new SwiperController();
  private scrollerForScroll: Scroller = new Scroller();
  private mPage: number = 1;

  aboutToAppear(): void {
    this.homeViewModel.getHomeBanner((data)=>{
      this.bannerData = data as Array<Banner>;
    });
    this.homeViewModel.getProjectTab((data)=>{
      this.tabData = data as Array<ProjectTabItem>;
      this.homeViewModel.getProjectList(this.mPage, this.tabData[this.currentIndex].id, (result)=> {
        let tempResult = result as ProjectSubList;
        this.listData = tempResult.datas;
      });
    });
  }

  build(){
    Scroll(this.scrollerForScroll){
      Column(){
        this.TopBanner()
        this.MiddleTab()
      }
    }
    .scrollBar(BarState.Off)
    .width('100%')
    .height('100%')
  }

  /**
   * 顶部轮播
   */
  @Builder
  TopBanner() {
    Swiper(this.swiperController) {
      ForEach(this.bannerData, (item: Banner, index: number) => {
        Image(item.imagePath)
          .width('100%')
          .height('100%')
          .alt($r('app.media.default_img'))
      }, (index?: number) => `${index}`)
    }
    .width('100%')
    .height(160)
    .loop(true)
    .autoPlay(true)
    .interval(2000)
    .indicator(
      Indicator.dot()
      .itemWidth(8)
      .itemHeight(8)
      .selectedItemWidth(13)
      .selectedItemHeight(8)
      .color($r('app.color.color_aaa'))
      .selectedColor($r('app.color.color_0159a5'))
    )
  }

  /**
   * 中间吸顶tab
   */
  @Builder
  MiddleTab() {
    Tabs({ barPosition: BarPosition.Start }) {
      ForEach(this.tabData, (item: ProjectTabItem, index: number) => {
        TabContent() {
          Grid(){
            ForEach(this.listData, (info: ProjectSubInfo, index: number) => {
              GridItem() {
                Column(){
                  Image(info.envelopePic)
                    .width('100%')
                    .height(200)
                    .alt($r('app.media.default_img'))
                  Text(info.title)
                    .fontSize(13)
                    .fontColor(Color.Black)
                    .maxLines(2)
                    .ellipsisMode(EllipsisMode.END)
                    .margin({top: 8})
                    .fontWeight(FontWeight.Bold)
                  Text(info.desc)
                    .fontSize(11)
                    .fontColor('#898e92')
                    .maxLines(1)
                    .ellipsisMode(EllipsisMode.END)
                    .margin({top: 2})
                  Row(){
                    Text(info.author)
                      .fontSize(9)
                      .fontColor('#898e92')
                      .maxLines(1)
                      .ellipsisMode(EllipsisMode.END)
                    Text(info.niceDate)
                      .fontSize(9)
                      .fontColor('#898e92')
                      .maxLines(1)
                      .ellipsisMode(EllipsisMode.END)
                  }
                  .justifyContent(FlexAlign.SpaceBetween)
                  .alignItems(VerticalAlign.Center)
                  .margin({top: 2})
                }
                .backgroundColor(Color.White)
                .borderRadius(5)
              }
            }, (index?:number) => `${index}`)
          }
          .width('100%')
          .height('100%')
          .columnsTemplate('1fr 1fr')
          .layoutDirection(GridDirection.Column)
          .rowsGap(10)
          .columnsGap(10)
          .margin({ left: 10, right: 10})
          .edgeEffect(EdgeEffect.None)
          .scrollBar(BarState.Off)
          .nestedScroll({
            scrollForward: NestedScrollMode.PARENT_FIRST,
            scrollBackward: NestedScrollMode.SELF_FIRST
          })
        }
        .tabBar(this.TabBuilder(index))
      }, (item: string) => item)
    }
    .vertical(false)
    .barMode(BarMode.Scrollable)
    .animationDuration(400)
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
    .padding({left: 10, right: 10})
    .onChange((index: number) => {
      this.currentIndex = index
    })
  }

  @Builder
  TabBuilder(index: number) {
    Column() {
      Text(this.tabData[index].name)
        .fontColor(this.currentIndex === index ? this.selectedFontColor : this.fontColor)
        .fontSize(16)
        .fontWeight(this.currentIndex === index ? 500 : 400)
        .margin({ top: 18, bottom: 8 })
      Line()
        .width(20)
        .height(5)
        .borderRadius(5)
        .backgroundColor($r('app.color.color_0159a5'))
        .opacity(this.currentIndex === index ? 1 : 0)
    }
    .margin({right: 15})
  }
}