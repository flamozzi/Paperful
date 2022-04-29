import SwiftUI

@main
struct PaperfulApp: App {
    @StateObject var editContentViewModel = EditContentViewModel()
    
    var body: some Scene {        
        WindowGroup {
            ContentView().environmentObject(editContentViewModel)
        }
    }
}
