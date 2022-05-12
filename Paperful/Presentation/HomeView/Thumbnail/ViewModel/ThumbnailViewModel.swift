import SwiftUI
import Foundation
import Combine
import Alamofire

class ThumbnailViewModel: ObservableObject {
    @Published var homeModel: HomeModel = .init()
    
    // MARK: - Thumbnail View에 뿌려줄 값들
    
    // thumbnail image
    var thumbnail: String? {
        return homeModel.thumbnail
    }
    
    // title
    var title: String {
        return homeModel.title
    }
    
    // writer nickname
    var writerNickname: String {
        return homeModel.writer.nickname
    }
    
    // intro
    var intro: String {
        return homeModel.intro
    }
    
    // MARK: - View로부터 새로운 값을 받아서 기존의 property 들의 값을 바꿈
    func changeHomeModel(homeModel: HomeModel) {
        self.homeModel.thumbnail = homeModel.thumbnail
        self.homeModel.title = homeModel.title
        self.homeModel.writer.nickname = homeModel.writer.nickname
        self.homeModel.intro = homeModel.intro
    }
}
