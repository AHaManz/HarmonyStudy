import ItemData from "../viewModel/ItemData"
import mainViewModel from "../viewModel/MainViewModel"

@Preview
@Component
export default struct Home {
  build() {
    Column() {
      Text('首页')
        .width('100%')
        .margin({top: '48vp', bottom: '12vp'})
        .fontSize('26fp')
        .fontWeight(700)
      Swiper() {
        ForEach(mainViewModel.getSwiperImages(), (img: Resource) => {
            Image(img)
              .width('100%')
              .borderRadius('16vp')
        }, (img: Resource) => JSON.stringify(img.id))
      }
      .autoPlay(true)
      Grid() {
        ForEach(mainViewModel.getFirstGridData(), (item: ItemData) => {
            GridItem() {
              Column() {
                Image(item.img)
                  .width('40vp').height('40vp')
                Text(item.title).fontSize('12fp').margin({top: '4vp'})
              }
            }
        }, (item: ItemData) => JSON.stringify(item))
      }
      .columnsTemplate('1fr 1fr 1fr 1fr')
      .rowsTemplate('1fr 1fr')
      .rowsGap('12vp')
      .padding({top: '12vp', bottom: '12vp'})
      .backgroundImage($r('app.media.backgroundImage'))
      .backgroundColor('#ffffff')
      .width('100%')
      .height('156vp')
      .borderRadius('16fp')
      .margin({top: '12vp'})
    }
    .padding({left: '12vp', right: '12vp'})
    .width('100%')
    .height('100%')
    .backgroundColor('#f5f5f5')
  }
}