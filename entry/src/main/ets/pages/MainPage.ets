/**
 * 首页
 */
import { CategoriesContent } from '../component/CategoriesContent'
import { FindContent } from '../component/FindContent'
import { HomeContent } from '../component/HomeContent'
import { MineContent } from '../component/MineContent'
import common from '@ohos.app.ability.common'

@Entry
@Component
struct MainPage {
  @State fontColor: string = '#182431'
  @State selectedFontColor: string = '#0159a5'
  @State currentIndex: number = 0
  private controller: TabsController = new TabsController()
  private tabNormalArray: Array<Resource> = [
    $r('app.media.ic_navi_home'),
    $r('app.media.ic_navi_categories'),
    $r('app.media.ic_navi_find'),
    $r('app.media.ic_navi_mine'),
  ];
  private tabSelectArray: Array<Resource> = [
    $r('app.media.ic_navi_home_select'),
    $r('app.media.ic_navi_categories_select'),
    $r('app.media.ic_navi_find_select'),
    $r('app.media.ic_navi_mine_select'),
  ];
  private tabsArray: Array<string> = [
    "首页",
    "分类",
    "体系",
    "我的"
  ];

  aboutToAppear() {

  }

  @Builder
  TabBuilder(index: number) {
    Column() {
      Text(this.tabsArray[index])
        .fontColor(this.currentIndex === index ? this.selectedFontColor : this.fontColor)
        .fontSize(16)
        .fontWeight(this.currentIndex === index ? 500 : 400)
      Image(this.currentIndex === index ? this.tabSelectArray[index] : this.tabNormalArray[index])
        .width(20)
        .height(20)
        .margin({ top: 5 })
    }
    .width('100%')
    .align(Alignment.Center)
  }

  build() {
    Tabs({ barPosition: BarPosition.End, controller: this.controller }) {
      ForEach(this.tabsArray, (item: string, index: number) => {
        TabContent() {
          if (this.currentIndex == 0) {
            HomeContent()
          } else if (this.currentIndex == 1){
            CategoriesContent()
          } else if (this.currentIndex == 2) {
            FindContent()
          } else if (this.currentIndex == 3) {
            MineContent()
          }
        }
        .tabBar(this.TabBuilder(index))
      }, (item: string) => item)
    }
    .scrollable(false)
    .vertical(false)
    .barMode(BarMode.Fixed)
    .barWidth('100%')
    .barHeight(56)
    .onChange((index: number) => {
      this.currentIndex = index;
    })
    .width('100%')
    .height('100%')
    .backgroundColor('#F1F3F5')
  }
}