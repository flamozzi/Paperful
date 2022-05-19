import SwiftUI
import Foundation
import Combine
import Alamofire

class FormViewModel: ObservableObject {
    @Published var form: FormModel = .init()
    
    // MARK: - Thumbnail View에 뿌려줄 값들
    
    // image
    var image: String {
        return form.image
    }
    
    // title
    var title: String {
        return form.title
    }
    
    // intro
    var intro: String {
        return form.intro
    }
    
    var id: Int {
        return form.id
    }
    
    // MARK: - set Form
    func setForm(form: FormModel) {
        self.form.image = form.image
        self.form.title = form.title
        self.form.intro = form.intro
        self.form.id = form.id
    }
}
