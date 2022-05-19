import Foundation
import SwiftUI


class PreviewViewModel_General: ObservableObject {
    func getDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let current_data_string = formatter.string(from: Date())
        return current_data_string
    }
}
