import Home from "../view/Home"
import Setting from "../view/Setting"

@Entry
@Component
export struct MainPage {
  private tabsController: TabsController = new TabsController();
  @State curIndex: number = 0;
  @Builder
  TabBuilder(title: Resource, index: number, selectedImg: Resource) {
    Column() {
      SymbolGlyph(selectedImg)
        .fontSize('24fp')
        .renderingStrategy(SymbolRenderingStrategy.MULTIPLE_OPACITY)
        .symbolEffect(new BounceSymbolEffect(EffectScope.WHOLE, EffectDirection.UP),
          this.curIndex === index ? true : false
        )
        .fontColor(this.curIndex === index ? ['#0a59f7'] : ['#666666'])

      Text(title)
        .margin({top: '4vp'})
        .fontSize(10)
        .fontWeight(500)
        .fontColor(this.curIndex === index ? '#0a59f7' : '#666666')
    }
    .backgroundColor('#f1f3f5')
    .justifyContent(FlexAlign.Center)
    .height('56vp')
    .onClick(() => {
      this.tabsController.changeIndex(index)
    })
  }

  build() {
    Column() {
        Tabs({
          barPosition: BarPosition.End,
          controller: this.tabsController
        }) {
          TabContent(){
            Home()
          }
          .tabBar(this.TabBuilder($r('app.string.Tab_Bar_One'), 0, $r('sys.symbol.house_fill')))

          TabContent() {
            Setting()
          }
          .tabBar(this.TabBuilder($r('app.string.Tab_Bar_Two'), 1, $r('sys.symbol.person_crop_circle_fill_1')))
        }
        .width('100%')
        .height('100%')
        .onChange((index: number) => {
          this.curIndex = index;
        })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#f5f5f5')
  }
}