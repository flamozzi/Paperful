import Foundation

struct PostModel: Codable {
    var object_type: String = ""
    var id: Int = 0
//    var tags: Tag[] = [] 나중에 태그 기능 추가되면 추가
    var title: String = ""
    var thumbnail: String?
    var intro: String = ""
    var writer: UserProfileModel = .init()
    var content: String = ""
    var create_at: String = ""
    var update_at: String = ""
    var status: String = ""
    var num_comments: Int = 0
    var hits: Int = 0
    var attentions: Int = 0
    var href: String?
    var diary_day: String?
    var weather: String?
}
