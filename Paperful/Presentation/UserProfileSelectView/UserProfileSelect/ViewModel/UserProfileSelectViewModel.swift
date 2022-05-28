import Foundation
import SwiftUI
import Alamofire


class UserProfileSelectViewModel: ObservableObject {
    @Published var userProfileViewList: [UserProfileView] = []
    
    func loadUserProfileList(globalData: GlobalData) {
        self.getUserProfileList(globalData: globalData) { (isSuccess, userProfileModelList) in
            if isSuccess {
                for userProfileModel in userProfileModelList {
                    let userProfileView: UserProfileView = .init()
                    userProfileView.userProfileViewModel.changeUserProfile(userProfileModel: userProfileModel)
                    self.userProfileViewList.append(userProfileView)
                }
            }
        }
    }
    
    private func getUserProfileList(globalData: GlobalData, completion: @escaping (Bool, [UserProfileModel]) -> Void) {
        
        let url = "https://api.paperful.co.kr/userprofiles"
        
        let headers: HTTPHeaders = [
            "Authorization": "Token \(globalData.token)"
        ]

        
        AF.request(url,
                   headers: headers)
        .responseDecodable(of: UserProfileListModel.self) { response in
            guard let result = response.value else { return }
            DispatchQueue.main.async {
                completion(true, result.results)
            }
        }
    }
    
//    func loadUserProfileList(globalData: GlobalData) {
//        self.getUserProfileList(globalData: globalData) { (isSuccess, userProfileModelList) in
//            if isSuccess {
//                for userProfileModel in userProfileModelList {
//                    let userProfileView: UserProfileView = .init()
//                    userProfileView.userProfileViewModel.changeUserProfile(userProfileModel: userProfileModel)
//                    self.userProfileViewList.append(userProfileView)
//                }
//            }
//        }
//    }
//
//    private func getUserProfileList(globalData: GlobalData, completion: @escaping (Bool, String) -> Void) {
//
//        let url = "https://api.paperful.co.kr/userprofiles"
//
//        let headers: HTTPHeaders = [
//            "Authorization": "Token \(globalData.token)"
//        ]
//
//
//        AF.request(url,
//                   headers: headers)
//        .responseDecodable(of: UserProfileListModel.self) { response in
//            guard let result = response.value else { return }
//            DispatchQueue.main.async {
//                completion(true, result.next)
//            }
//        }
//    }
}
