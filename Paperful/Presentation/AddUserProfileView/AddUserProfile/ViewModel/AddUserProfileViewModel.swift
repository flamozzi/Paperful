import SwiftUI
import Foundation
import Combine
import Alamofire

class AddUserProfileViewModel: ObservableObject {
    //    @Published var adduserProfileModel: AddUserProfileModel = .init()
    //
    //    // user profile id
    //    var addUserProfileID: Int {
    //        return adduserProfileModel.id
    //    }
    //
    //    // MARK: - 새로운 값을 받아서 기존의 property 값을 바꿈
    //    func changeAddUserProfile(addUserProfileModel: AddUserProfileModel) {
    //        self.adduserProfileModel.id = addUserProfileModel.id
    //    }
    
    // 뷰 최상단에서 당겨서 새로고침 (새로운 10개의 썸네일만 받아서 render)
    func postNewUserProfile(nickname: String, image: Data?, intro: String?, globalData: GlobalData) {
        self.addUserProfileWithImage(nickname: nickname, image: image, intro: intro, globalData: globalData) { (isSuccess, id) in
            if isSuccess {
                globalData.currentUserProfile.id = id
            }
        }
//
//        if checkChange == true {
//            self.addUserProfileWithImage(nickname: nickname, image: image, intro: intro, globalData: globalData) { (isSuccess, id) in
//                if isSuccess {
//                    print(id)
//
//                    globalData.currentUserProfile.id = id
//                }
//            }
//        }
//        else {
//            self.addUserProfile(nickname: nickname, image: image, intro: intro, globalData: globalData) { (isSuccess, id) in
//                if isSuccess {
//                    print(id)
//
//                    globalData.currentUserProfile.id = id
//                }
//            }
//        }
    }
    
//    private func addUserProfile(nickname: String, image: Data?, intro: String?, globalData: GlobalData, completion: @escaping (Bool, Int) -> Void) {
//
//        print(type(of: image))
//
//        let url = "https://api.paperful.co.kr/userprofiles"
//
//        let headers: HTTPHeaders = [
//            "Content-Type": "multipart/form-data",
//            "Authorization": "Token \(globalData.token)"
//        ]
//
//        let newProfile = NewProfile(nickname: nickname, image: image, intro: intro)
//
//        AF.request(url,
//                   method: .post,
//                   parameters: newProfile,
//                   encoder: JSONParameterEncoder.default,
//                   headers: headers)
//        .validate(statusCode: 200..<300)
//        .responseDecodable(of: AddUserProfileModel.self) { response in
//            debugPrint(response)
//            switch response.result {
//            case .success(_):
//                guard let result = response.value else { return }
//                completion(true, result.id)
//            case let .failure(error):
//                print(error)
//            }
//        }
//
//        struct NewProfile: Encodable {
//            let nickname: String
//            let image: Data?
//            let intro: String?
//        }
//    }
    
    private func addUserProfileWithImage(nickname: String, image: Data?, intro: String?, globalData: GlobalData, completion: @escaping (Bool, Int) -> Void) {
        
        print(type(of: image))
        
        let url = "https://api.paperful.co.kr/userprofiles"
        
        let headers: HTTPHeaders = [
            "Content-Type": "multipart/form-data",
            "Authorization": "Token \(globalData.token)"
        ]
        
        AF.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(Data(nickname.utf8), withName: "nickname")
            multipartFormData.append(Data(intro!.utf8), withName: "profile_intro")
            if let imageData = image {
                multipartFormData.append(imageData, withName: "profile_image")
            }
        }, to: url, headers: headers)
        .responseDecodable(of: AddUserProfileModel.self) { response in
//            print(String(data: response.data!, encoding: .utf8))
//            print(response.response?.statusCode)
            debugPrint(response)
            switch response.result {
            case .success(_):
                guard let result = response.value else { return }
                completion(true, result.id)
            case let .failure(error):
                print(error)
            }
        }
    }
}

