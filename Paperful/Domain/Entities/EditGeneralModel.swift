import Foundation
import UIKit

struct EditGeneralModel: Codable {
    var title: String = ""
    var content: String = ""
    var thumbnail: String = ""
    var thumbnailData: Data?
    var intro: String = ""
    var writerNickname: String = ""
}
