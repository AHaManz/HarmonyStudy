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
        })
      }
    }
    .padding({left: '12vp', right: '12vp'})
    .width('100%')
    .height('100%')
    .backgroundColor('#f5f5f5')
  }
}