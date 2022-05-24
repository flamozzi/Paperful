import Foundation
import SwiftUI
import Alamofire


class EditThumbnailViewModel_General: ObservableObject {
    @Published var thumbnailView: ThumbnailView = .init()
    
    var homeModel: HomeModel = .init()
    
    func setThumbnail(title: String, thumbnail: String) {
        self.setHomeModel(title: title, thumbnail: thumbnail)
        self.thumbnailView.thumbnailViewModel.changeHomeModel(homeModel: self.homeModel)
    }
    
    func setHomeModel(title: String, thumbnail: String) {
        self.homeModel.title = title
        self.homeModel.thumbnail = thumbnail
    }
    
    // request login api
    func requestLogin(email: String, password: String, globalData: GlobalData) {
        self.postToServer(email: email, password: password) { (isSuccess, response) in
            if isSuccess {
                globalData.token = response!
            }
        }
    }
    
    // getLoginToken
    private func postToServer(email: String, password: String, completion: @escaping (Bool, String?) -> Void) {
        
        let url = "https://api.paperful.co.kr/auth"
        
        let login = Login(email: email, password: password)
        
        AF.request(url,
                   method: .post,
                   parameters: login,
                   encoder: JSONParameterEncoder.default)
        .validate(statusCode: 200..<300)
        .responseDecodable(of: LoginTokenModel.self) { response in
            switch response.result {
            case .success(_):
                guard let result = response.value else { return }
                completion(true, result.token)
            case let .failure(error):
                print(error)
            }
        }
    }
    
    struct Login: Encodable {
        let email: String
        let password: String
    }
}
