import Foundation
import SwiftUI
import Alamofire


class LoginViewModel: ObservableObject {
    
    // request login api
    func requestLogin(email: String, password: String, globalData: GlobalData) {
        self.getLoginAPI(email: email, password: password) { (isSuccess, response) in
            if isSuccess {
                globalData.token = response!
                globalData.isChangeToken = true
            }
        }
    }
    
    // getLoginToken
    private func getLoginAPI(email: String, password: String, completion: @escaping (Bool, String?) -> Void) {
        
        let url = "https://api.paperful.co.kr/auth/user"
        
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
