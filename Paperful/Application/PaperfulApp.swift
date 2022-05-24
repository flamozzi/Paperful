import SwiftUI

@main
struct PaperfulApp: App {
    @StateObject var globalData = GlobalData()
    
    var body: some Scene {
        // 원래 버전
        WindowGroup {
            // globalData의 resetAccessToggle으로 조건 끄기 가능
            if globalData.isGuest == true || globalData.isMember == true {
                ContentView().environmentObject(globalData)
            }
            
            // globalData의 resetUserToken으로 조건 끄기 가능
            else if globalData.token != "" && globalData.isChangeToken == true {
                UserProfileSelectView(globalData: globalData).environmentObject(globalData)
            }
            else {
                LoginView().environmentObject(globalData)
            }
        }
    }
}
