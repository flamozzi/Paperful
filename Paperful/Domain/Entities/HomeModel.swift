import Foundation

struct Results: Codable {
    var results: [HomeModel]
    var next: String?
    
    init() {
        self.results = []
        self.next = nil
    }
}

struct HomeModel: Codable, Identifiable {
    var id: Int = 0
    var title: String 
    var intro: String
    var content: String
    var writer: Writer
    var object_type: String
    
    var thumbnail: String?
    
    struct Writer: Codable {
        var id: Int
        var nickname: String
        
        init() {
            self.id = 0
            self.nickname = "default nickname"
        }
    }
    
    init() {
        self.id = 0
        self.title = "default title"
        self.intro = "default intro"
        self.content = "default content"
        self.writer = .init()
        self.thumbnail = nil
        self.object_type = "general"
    }
    
}

struct EditHomeModel: Codable, Identifiable {
    var id: Int = 0
    var title: String
    var intro: String
    var content: String
    var writer: Writer
    
    var thumbnail: String?
    
    struct Writer: Codable {
        var id: Int
        var nickname: String
        
        init() {
            self.id = 0
            self.nickname = "default nickname"
        }
    }
    
    init() {
        self.id = 0;
        self.title = "default title"
        self.intro = "default intro"
        self.content = "default content"
        self.writer = .init()
        self.thumbnail = "plusSquareImage"
    }
    
}
