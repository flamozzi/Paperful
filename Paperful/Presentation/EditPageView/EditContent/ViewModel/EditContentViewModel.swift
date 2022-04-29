import SwiftUI
import Foundation
import Combine

class EditContentViewModel: ObservableObject {
    @Published var content: String = ""
//    var localEditContentModel: LocalEditContentModel
    
//    init(localEditContentModel: LocalEditContentModel) {
//        self.localEditContentModel = localEditContentModel
//        self.content = localEditContentModel.content
//    }
//
//    func getContent() -> String {
//        return localEditContentModel.content
//    }
}
