import Foundation
import SwiftUI
import Alamofire


class UserProfileSelectViewModel: ObservableObject {
    @Published var userProfileImageViewList: [UserProfileView] = []
    
    // 뷰 최상단에서 당겨서 새로고침 (새로운 10개의 썸네일만 받아서 render)
    func loadUserProfileImageList(globalData: GlobalData) {
        self.getUserProfileImageList(globalData: globalData) { (isSuccess, userProfileModelList) in
            if isSuccess {
                for userProfileModel in userProfileModelList {
                    let userProfileView: UserProfileView = .init()
                    userProfileView.userProfileViewModel.changeUserProfileImage(userProfileModel: userProfileModel)
                    self.userProfileImageViewList.append(userProfileView)
                }
            }
        }
    }
    
    private func getUserProfileImageList(globalData: GlobalData, completion: @escaping (Bool, [UserProfileModel]) -> Void) {
        
        let url = "https://api.paperful.co.kr/userprofiles"
        
        let headers: HTTPHeaders = [
            "Authorization": "Token \(globalData.token)"
        ]

        
        AF.request(url,
                   headers: headers)
        .responseDecodable(of: UserProfileListModel.self) { response in
            print(response)
            guard let result = response.value else { return }
            DispatchQueue.main.async {
                completion(true, result.results)
            }
        }
    }
}
