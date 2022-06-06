import Foundation

struct PostListModel: Codable {
    var results: [PostModel]
    var next: String?
    var previous: String?
    var size: Int
    var start: Int
    var limit: Int
    var total: Int
    
    init() {
        self.results = []
        self.next = nil
        self.previous = nil
        self.size = 0
        self.start = 0
        self.limit = 0
        self.total = 0
    }
}

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
    var diary_day: String?
    var weather: String?
}
