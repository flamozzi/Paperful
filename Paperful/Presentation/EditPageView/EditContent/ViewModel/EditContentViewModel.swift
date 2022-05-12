import SwiftUI
import Foundation
import Combine

class EditContentViewModel: ObservableObject {
    @Published var content: String = ""
}
