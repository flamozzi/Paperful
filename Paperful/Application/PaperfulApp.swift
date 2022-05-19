import SwiftUI

@main
struct PaperfulApp: App {
    @StateObject var globalData = GlobalData()
    
    var body: some Scene {
        // 원래 버전
        WindowGroup {
            if self.globalData.token != "" {
                ContentView().environmentObject(globalData)
            }
            else {
                LoginView().environmentObject(globalData)
            }
        }
    }
}
