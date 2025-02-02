import { connection } from '@kit.NetworkKit'
import { hilog } from '@kit.PerformanceAnalysisKit';
import { BusinessError } from '@kit.BasicServicesKit';
import { promptAction } from '@kit.ArkUI'

const TAG: string = 'CounnectionUtils'

export class ConnectionUtils {
  netConnection = connection.createNetConnection()

  async isNetworkConnected(): Promise<boolean> {
    let result: boolean = false;
    await connection.getDefaultNet().then(async (data: connection.NetHandle) => {
        if (data.netId === 0) {
          hilog.info(0x0000, TAG, 'network error')
          return
        }
        await connection.getNetCapabilities(data).then((data: connection.NetCapabilities) => {
          let bearerTypes: Set<number> = new Set(data.bearerTypes)
          let bearerTypesNum = Array.from(bearerTypes.values())
          for (let item of bearerTypesNum) {
            if (item === 0) {
              result = true
              hilog.info(0x0000, TAG, 'BEARER_CELLULAR')
            } else if (item === 1) {
              result = true;
              hilog.info(0x0000, TAG, 'BEARER_WIFI');
            } else if (item === 3) {
              result = true;
              hilog.info(0x0000, TAG, 'BEARER_ETHERNET');
            } else {
              return;
            }
          }
        })
    })
    return result
  }

  openRegister() {
    this.netConnection.register((error: BusinessError) => {
      hilog.info(0x0000, TAG, JSON.stringify(error))
    })
  }

  closeRegister() {
    this.netConnection.unregister((error: BusinessError) => {
      hilog.info(0x0000, TAG, JSON.stringify(error))
    })
  }

  registerNetworkAvailableStatus() {
    this.netConnection.on('netAvailable', () => {
      promptAction.showToast({
        message: $r('app.string.Network_Available'),
        duration: 2000
      });
    });

    this.netConnection.on('netUnavailable', () => {
      promptAction.showToast({
        message: $r('app.string.Network_Unavailable'),
        duration: 2000
      });
    });

    this.netConnection.on('netLost', () => {
      promptAction.showToast({
        message: $r('app.string.Network_Lost'),
        duration: 2000
      });
    });
  }

}

export default new ConnectionUtils()