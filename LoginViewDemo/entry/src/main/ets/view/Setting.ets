import ItemData from '../viewModel/ItemData'
import mainViewModel from '../viewModel/MainViewModel'
import { SliderCustomDialog } from './SliderCustomDialog'

@Preview
@Component
export default struct Setting {
  @StorageLink('fontSizeOffset') fontSizeOffset: number = 0;
  SliderCustomDialogController: CustomDialogController = new CustomDialogController({
    builder: SliderCustomDialog({}),
    alignment: DialogAlignment.Bottom,
    customStyle: true,
    offset: {dx: 0, dy: -25}
  });

  @Builder
  settingCell(item: ItemData, dialogController: CustomDialogController) {
    Row() {
      Row() {
        Image(item.img)
          .height('22vp')
          .margin({left: '16vp', right: '16vp'})
        Text(item.title)
          .fontSize(16 + this.fontSizeOffset)
      }
      if (item.others == undefined) {
        Image($r('app.media.right_grey'))
          .width('12vp')
          .height('24vp')
      } else {
        Toggle({type: ToggleType.Switch})
      }
    }
    .justifyContent(FlexAlign.SpaceBetween)
    .width('100%')
    .padding({
      left: '8vp',
      right: '22vp'
    })
    .onClick(() => {
      if (item.id === 1) {
        dialogController.open();
      }
    })
  }

  build() {
    Column() {
      Text('我的')
        .width('100%')
        .margin({
          top: '48vp',
          bottom: '12vp'
        })
        .fontWeight(700)
        .fontSize(26 + this.fontSizeOffset)
      Row() {
        Image($r('app.media.account'))
          .width('48vp')
          .height('48vp')
        Column() {
          Text('李先生')
            .fontSize(20 + + this.fontSizeOffset)
          Text('2010230@qq.com')
            .fontSize(12 + + this.fontSizeOffset)
            .margin({top: '4vp'})
        }
        .alignItems(HorizontalAlign.Start)
        .margin({left: '12vp'})
      }
      .alignItems(VerticalAlign.Center)
      .width('100%')
      List({space: '12vp'}) {
         ForEach(mainViewModel.getSettingData(), (item: ItemData[]) => {
           ListItemGroup() {
             ForEach(item, (cell: ItemData) => {
               ListItem() {
                 this.settingCell(cell, this.SliderCustomDialogController)
               }
               .height('48vp')
             })
           }
           .divider({
             strokeWidth: '1vp',
             color: '#0d00000',
             startMargin: '42vp',
             endMargin: '24vp'
           })
           .backgroundColor('#ffffff')
           .borderRadius('16vp')

         }, (item: ItemData) => JSON.stringify(item))
      }
      .width('100%')
      .scrollBar(BarState.Off)
      .padding({
        top: '4vp',
        bottom: '4vp'
      })

      Blank()

      Button('退出登录', {type: ButtonType.Capsule})
        .width('90%')
        .height('40vp')
        .fontColor('#fa2a2d')
        .backgroundColor('#e5e8ea')
        .margin({bottom: '16vp'})
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#f5f5f5')
  }
}