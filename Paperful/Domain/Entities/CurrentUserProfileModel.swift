import Foundation
import UIKit

struct CurrentUserProfileModel: Codable {
    var id: Int = 0
    var image: String? = nil
    var intro: String = ""
    var nickname: String = ""
    var numberOfSubscribers: Int = 0
}
