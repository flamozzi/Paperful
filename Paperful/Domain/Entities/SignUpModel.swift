import Foundation

class SignUpModel: Codable {
    var email: String = ""
    var username: String = ""
    var password: String = ""
    var password2: String = ""
}

class EmailValidationModel: Codable {
    var is_valid: Bool = true
    var form: Bool = true
    var unique: Bool = true
}
