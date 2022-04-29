import Foundation
import SwiftUI

struct HomeModel: Codable, Identifiable {
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
        self.thumbnail = nil
    }
}
