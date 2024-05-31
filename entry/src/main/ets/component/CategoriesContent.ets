/**
 * 分类
 */
import { CategoryItem, CategorySecondItem } from '../http/apiService';
import { CategoriesContentViewModel } from '../viewmodel/CategoriesContentViewModel';
import { window } from '@kit.ArkUI';

@Component
export struct CategoriesContent {
  @State currentIndex: number = 0;
  @State listData: Array<CategoryItem> = [];
  @StorageProp("MainWindow") mainWindow: window.Window | null = null;
  private categoriesViewModel: CategoriesContentViewModel = new CategoriesContentViewModel();

  aboutToAppear(): void {
    this.categoriesViewModel.getCategoryData((data)=>{
      this.listData = data as Array<CategoryItem>;
    });
    this.mainWindow?.setWindowLayoutFullScreen(false);
  }

  onPageShow(): void {
    this.mainWindow?.setWindowLayoutFullScreen(false);
  }

  build(){
    Row(){
      List({space: 3}) {
        ForEach(this.listData, (item: CategoryItem, index: number) => {
          ListItem() {
            Text(item.name)
              .width(100)
              .height(50)
              .fontSize(14)
              .fontColor('#222427')
              .textAlign(TextAlign.Center)
              .backgroundColor(this.currentIndex === index?"#fff":"#f0f2f4")
              .borderRadius({topRight: this.currentIndex + 1 === index? 5 : 0, bottomRight: this.currentIndex - 1 === index? 5 : 0})
          }
          .onClick(()=>{
            this.currentIndex = index;
          })
        }, (index?:number) => `${index}`)
      }
      .backgroundColor('#fff')
      .alignListItem(ListItemAlign.Center)
      .width(100)
      .height('100%')
      .scrollBar(BarState.Off)

      Grid() {
        ForEach(this.listData != null && this.listData.length > 0 ? this.listData[this.currentIndex].articles : [], (item: CategorySecondItem, index: number) => {
          GridItem() {
            Text(item.title)
              .width('100%')
              .height(60)
              .fontSize(12)
              .fontColor("#4F5356")
              .backgroundColor("#b2d0e9")
              .border({radius: 10})
              .textAlign(TextAlign.Center)
          }
        }, (index?:number) => `${index}`)
      }
      .columnsTemplate('1fr 1fr')
      .layoutDirection(GridDirection.Column)
      .rowsGap(10)
      .columnsGap(10)
      .layoutWeight(1)
      .margin({ left: 10, right: 10})
      .scrollBar(BarState.Off)
    }
    .width('100%')
    .height('100%')
    .margin({top: 15})
  }
}