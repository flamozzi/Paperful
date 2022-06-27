import Foundation
import SwiftUI
import Alamofire


class SignUpViewModel: ObservableObject {
    @Published var is_valid: Bool = false
    @Published var form: Bool = false
    @Published var unique: Bool = false
    
    // request login api
    func requestEmailValidationChecking(email: String, globalData: GlobalData){
        self.checkEamilValidation(email: email) { (isSuccess, response) in
            if isSuccess {
                self.is_valid = response.is_valid
                self.form = response.form
                self.unique = response.unique
            }
        }
    }
    
    
    // getLoginToken
    private func checkEamilValidation(email: String, completion: @escaping (Bool, EmailValidationModel) -> Void) {
        
        let url = "https://api.paperful.co.kr/signup/validate/email"
        
        let email = Email(email: email)
        
        AF.request(url,
                   method: .post,
                   parameters: email,
                   encoder: JSONParameterEncoder.default)
        .validate(statusCode: 200..<300)
        .responseDecodable(of: EmailValidationModel.self) { response in
            switch response.result {
            case .success(_):
                guard let result = response.value else { return }
                completion(true, result)
            case let .failure(error):
                print(error)
            }
        }
    }
    
    struct Email: Encodable {
        let email: String
    }
}

//
//// getLoginToken
//private func getStatusCodeAPI(email: String, password: String, passwordChecker: String, completion: @escaping (Bool, Int) -> Void) {
//
//    let url = "https://api.paperful.co.kr/signup"
//
//    let signUp = SignUp(email: email, password: password, passwordChecker: passwordChecker)
//
//    AF.request(url,
//               method: .post,
//               parameters: signUp,
//               encoder: JSONParameterEncoder.default)
//    .responseDecodable(of: SignUpModel.self) { response in
//        completion(true, response.response!.statusCode)
//    }
//}
//
//struct SignUp: Encodable {
//    let email: String
//    let password: String
//    let passwordChecker: String
//}
