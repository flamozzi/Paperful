import SwiftUI
import Foundation
import Combine

class GlobalData: ObservableObject {
    @Published var token: String = ""

    @Published var editContent: EditGeneralModel = .init()
    
    func resetEditContent() {
        self.editContent.title = ""
        self.editContent.content = ""
        self.editContent.thumbnail = ""
        self.editContent.intro = ""
        self.editContent.writerNickname = ""
    }
}
