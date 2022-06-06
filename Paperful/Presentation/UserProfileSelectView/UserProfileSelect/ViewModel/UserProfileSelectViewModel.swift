import Foundation
import SwiftUI
import Alamofire


class UserProfileSelectViewModel: ObservableObject {
    @Published var userProfileViewList: [UserProfileView] = []
    @Published var userProfileList: UserProfileListModel = .init()
    
    func loadUserProfileList(globalData: GlobalData) {
        self.getUserProfileList(globalData: globalData, url: nil) { (isSuccess, userProfileModelList) in
            if isSuccess {
                for userProfileModel in userProfileModelList.results {
                    let userProfileView: UserProfileView = .init()
                    userProfileView.userProfileViewModel.changeUserProfile(userProfileModel: userProfileModel)
                    self.userProfileViewList.append(userProfileView)
                }
            }
        }
    }
    
    func loadNextProfileList(globalData: GlobalData) {
        self.getUserProfileList(globalData: globalData, url: self.userProfileList.next) { (isSuccess, userProfileModelList) in
            if isSuccess && self.userProfileList.next != nil {
                for userProfileModel in userProfileModelList.results {
                    let userProfileView: UserProfileView = .init()
                    userProfileView.userProfileViewModel.changeUserProfile(userProfileModel: userProfileModel)
                    self.userProfileViewList.append(userProfileView)
                }
                self.userProfileList.next = userProfileModelList.next
            }
        }
    }
    
    func settingUserProfileListModel(globalData: GlobalData) {
        self.getUserProfileList(globalData: globalData, url: nil) { (isSuccess, result) in
            if isSuccess {
                self.userProfileList = result
            }
        }
    }
    
    private func getUserProfileList(globalData: GlobalData, url: String?, completion: @escaping (Bool, UserProfileListModel) -> Void) {
        
        let url = url ?? "https://api.paperful.co.kr/userprofiles"
        
        let headers: HTTPHeaders = [
            "Authorization": "Token \(globalData.token)"
        ]

        
        AF.request(url,
                   headers: headers)
        .responseDecodable(of: UserProfileListModel.self) { response in
            guard let result = response.value else { return }
            DispatchQueue.main.async {
                completion(true, result)
            }
        }
    }
}
