import Foundation
import SwiftUI
import Alamofire


class EditThumbnailViewModel_General: ObservableObject {
    
    func requestAddPost(object_type: String, status: String, userProfileID: Int, title: String, content: String, image: Data?, intro: String?, globalData: GlobalData) {
        self.addPost(object_type: object_type, status: status, userProfileID: userProfileID, title: title, content: content, image: image, intro: intro, globalData: globalData) { (isSuccess, PostResponse) in
            if isSuccess {
                globalData.postSuccessTogle = !globalData.postSuccessTogle
            }
            else {
                print("add Post failed!")
            }
        }
    }
    
    private func addPost(object_type: String, status: String, userProfileID: Int, title: String, content: String, image: Data?, intro: String?, globalData: GlobalData, completion: @escaping (Bool, PostResponse) -> Void) {
        
        let url = "https://api.paperful.co.kr/userprofiles/\(userProfileID)/posts"
        
        let headers: HTTPHeaders = [
            "Content-Type": "multipart/form-data",
            "Authorization": "Token \(globalData.token)"
        ]
        
        AF.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(Data(object_type.utf8), withName: "object_type")
            multipartFormData.append(Data(status.utf8), withName: "status")
            multipartFormData.append(Data(title.utf8), withName: "title")
            multipartFormData.append(Data(content.utf8), withName: "content")
            multipartFormData.append(Data(intro!.utf8), withName: "intro")
            if let thumbnail = image {
                multipartFormData.append(thumbnail, withName: "thumbnail", fileName: "thumbnailFileName.jpeg", mimeType: "image/jpeg")
            }
        }, to: url, headers: headers)
        .responseDecodable(of: PostResponse.self) { response in
            switch response.result {
            case .success(_):
                guard let result = response.value else { return }
                completion(true, result)
            case let .failure(error):
                print(error)
            }
        }
    }
}
