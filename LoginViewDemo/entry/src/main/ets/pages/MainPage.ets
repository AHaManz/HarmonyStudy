import Home from "../view/Home"
import Setting from "../view/Setting"

@Entry
@Component
struct MainPage {
  build() {
    Column() {
        Tabs() {
          TabContent(){
            Home()
          }

          TabContent() {
            Setting()
          }
        }
        .width('100%')
        .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#f5f5f5')
  }
}