/**
 * 体系
 */
import { SystemList, SystemSecondList } from '../http/apiService';
import { FindContentViewModel } from '../viewmodel/FindContentViewModel';
import { AppUtil } from '@pura/harmony-utils';

@Component
export struct FindContent {
  @State listData: Array<SystemList> = [];
  private findViewModel: FindContentViewModel = new FindContentViewModel();

  aboutToAppear(): void {
    this.findViewModel.getSystemList((data)=>{
      this.listData = data as Array<SystemList>;
    });
    AppUtil.setStatusBar(false, true);
  }

  onPageShow(): void {
    AppUtil.setStatusBar(false, true);
  }

  build(){
    List({space: 15}) {
      ForEach(this.listData, (item: SystemList, index: number) => {
        ListItem() {
          Row(){
            Column(){
              Text(item.name)
                .fontColor("#222427")
                .fontSize(15)
                .fontWeight(500)
              this.TagContent(item.children);
            }
            .alignItems(HorizontalAlign.Start)
            .layoutWeight(1)
            Image($r('app.media.ic_next'))
              .width(18)
              .height(18)
              .align(Alignment.Center)
              .margin({left: 15, right: 10})
          }
          .backgroundColor("#fff")
          .border({ radius: 10 })
          .padding({top: 10, bottom: 10, left: 10})
        }
        .onClick(()=>{
        })
      }, (index:number) => `${index}`)
    }
    .width('100%')
    .height('100%')
    .padding({left: 15, right: 15, top: 15})
    .backgroundColor('#f0f2f4')
    .alignListItem(ListItemAlign.Center)
  }

  @Builder
  TagContent(innerListData: Array<SystemSecondList>){
    Flex({direction: FlexDirection.Row, wrap: FlexWrap.Wrap}) {
      ForEach(innerListData, (item: SystemSecondList) => {
        Text(item.name)
          .fontSize(13)
          .fontColor("#898e92")
          .margin({top: 10, right: 10})
      })
    }
    .width("100%")
  }
}