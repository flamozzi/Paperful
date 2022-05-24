import SwiftUI
import Foundation
import Combine
import Alamofire

class UserProfileViewModel: ObservableObject {
    @Published var userProfileModel: UserProfileModel = .init()
    
    // user profile id
    var userProfileID: Int {
        return userProfileModel.id
    }
    
    // user profile image
    var userProfileImage: String? {
        return userProfileModel.image
    }
    
    // user profile intro
    var userProfileIntro: String {
        return userProfileModel.intro
    }
    
    // user profile nickname
    var userProfileNickname: String {
        return userProfileModel.nickname
    }
    
    // user profile number of subscribers
    var userProfileNumberOfSubscribers: Int {
        return userProfileModel.num_subscribers
    }
    
    // MARK: - 새로운 값을 받아서 기존의 property 값을 바꿈
    func changeUserProfileImage(userProfileModel: UserProfileModel) {
        self.userProfileModel.id = userProfileModel.id
        self.userProfileModel.image = userProfileModel.image
        self.userProfileModel.intro = userProfileModel.intro
        self.userProfileModel.nickname = userProfileModel.nickname
        self.userProfileModel.num_subscribers = userProfileModel.num_subscribers
    }
}
