import Foundation

class LoginTokenModel: Codable {
    var token: String = ""
    
    func setToken(token: String) {
        self.token = token
    }
}
