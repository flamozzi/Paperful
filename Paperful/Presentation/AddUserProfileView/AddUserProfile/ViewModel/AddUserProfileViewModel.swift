import SwiftUI
import Foundation
import Combine
import Alamofire

class AddUserProfileViewModel: ObservableObject {
    
    func postNewUserProfile(nickname: String, image: Data?, intro: String?, globalData: GlobalData) {
        self.addUserProfileWithImage(nickname: nickname, image: image, intro: intro, globalData: globalData) { (isSuccess, id) in
            if isSuccess {
                globalData.currentUserProfile.id = id
            }
        }
    }
    
    private func addUserProfileWithImage(nickname: String, image: Data?, intro: String?, globalData: GlobalData, completion: @escaping (Bool, Int) -> Void) {
        
        print(type(of: image))
        
        let url = "https://api.paperful.co.kr/userprofiles"
        
        let headers: HTTPHeaders = [
            "Content-Type": "multipart/form-data",
            "Authorization": "Token \(globalData.token)"
        ]
        
        AF.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(Data(nickname.utf8), withName: "nickname")
            multipartFormData.append(Data(intro!.utf8), withName: "intro")
            if let imageData = image {
                multipartFormData.append(imageData, withName: "image", fileName: "filename.jpeg", mimeType: "image/jpeg")
            }
        }, to: url, headers: headers)
        .responseDecodable(of: AddUserProfileModel.self) { response in
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

