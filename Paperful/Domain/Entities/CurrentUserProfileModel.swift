import Foundation
import UIKit

struct CurrentUserProfileModel: Codable {
    var id: Int = 0
    var image: String? = nil
    var intro: String = ""
    var nickname: String = ""
    var num_subscribers: Int = 0
}
