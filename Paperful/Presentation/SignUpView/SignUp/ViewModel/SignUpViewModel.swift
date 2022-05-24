import Foundation
import SwiftUI
import Alamofire


class SignUpViewModel: ObservableObject {
    
    // request login api
    func checkDuplicateEamil(email: String, password: String, passwordChecker: String, globalData: GlobalData){
        self.getStatusCodeAPI(email: email, password: password, passwordChecker: passwordChecker) { (isSuccess, response) in
            if isSuccess {
                globalData.statusCode = response
            }
        }
    }
    
    
    
    // getLoginToken
    private func getStatusCodeAPI(email: String, password: String, passwordChecker: String, completion: @escaping (Bool, Int) -> Void) {
        
        let url = "https://api.paperful.co.kr/signup"
        
        let signUp = SignUp(email: email, password: password, passwordChecker: passwordChecker)
        
        AF.request(url,
                   method: .post,
                   parameters: signUp,
                   encoder: JSONParameterEncoder.default)
        .responseDecodable(of: SignUpModel.self) { response in
            completion(true, response.response!.statusCode)
        }
    }
    
    struct SignUp: Encodable {
        let email: String
        let password: String
        let passwordChecker: String
    }
}
