import { connection } from '@kit.NetworkKit'


export class ConnectionUtils {
  async isNetworkConnected(): Promise<boolean> {
    let result: boolean = false;
    await connection.getDefaultNet().then(async (data: connection.NetHandle) => {

    })

    return result
  }
}