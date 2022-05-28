import SwiftUI
import Foundation
import Combine

class GlobalData: ObservableObject {
    // 임시 스테이터스 코드 (삭제 될 지도 구조 변경하면)
    @Published var statusCode: Int = 0
    
    //MARK: - 유저 토큰
    @Published var token: String = ""
    @Published var isChangeToken: Bool = false
    
    func resetUserToken() {
        self.token = ""
        self.isChangeToken = false
    }
    
    //MARK: - 유저 게스트 or 회원
    @Published var isGuest: Bool = false
    @Published var isMember: Bool = false
    
    func resetAccessToggle() {
        self.isGuest = false
        self.isMember = false
    }
    
    
    //MARK: - 유저 프로필 정보
    @Published var currentUserProfile: CurrentUserProfileModel = .init()
    
    func resetCurrentUserProfile() {
        self.currentUserProfile.id = 0
        self.currentUserProfile.image = nil
        self.currentUserProfile.intro = ""
        self.currentUserProfile.nickname = ""
        self.currentUserProfile.numberOfSubscribers = 0
    }
    
    //MARK: - 글쓰기에서 가지고 있는 정보들
    @Published var editContent: EditGeneralModel = .init()
    
    func resetEditContent() {
        self.editContent.title = ""
        self.editContent.content = ""
        self.editContent.thumbnail = ""
        self.editContent.intro = ""
        self.editContent.writerNickname = ""
    }
    
    //MARK: - HomeView의 Thumbnail -> DeatilView로 갈 때의 글 id
    @Published var currentPostID: Int = 0
    
//    //MARK: - 현재 조회하고 있는 글 정보
//    @Published var currentPost: PostModel = .init()
//
//    func resetCurrentPost() {
//        self.currentPost.object_type = ""
//        self.currentPost.id = 0
//        self.currentPost.title = ""
//        self.currentPost.thumbnail = ""
//        self.currentPost.intro = ""
//        self.currentPost.writer = .init()
//        self.currentPost.content = ""
//        self.currentPost.create_at = ""
//        self.currentPost.update_at = ""
//        self.currentPost.status = ""
//        self.currentPost.num_comments = 0
//        self.currentPost.hits = 0
//        self.currentPost.attentions = 0
//        self.currentPost.href = ""
//        self.currentPost.diary_day = ""
//        self.currentPost.weather = ""
//    }
}
