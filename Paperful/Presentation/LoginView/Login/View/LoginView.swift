import SwiftUI

struct LoginView: View {
    
    @EnvironmentObject var globalData: GlobalData
    
    @State var email: String = ""
    @State var password: String = ""
    
    @StateObject private var loginViewModel: LoginViewModel = .init()
    
    var body: some View {
        ZStack {
            Color.backgroundColor
                .ignoresSafeArea(.all)
            
            VStack (spacing: 80){
                
                // Logo
                VStack(spacing: 8) {
                    Text("Paperful")
                        .font(.title)
                    Text("당신의 이야기가 담기는 곳")
                        .font(.subheadline)
                }
                
                // Login TextField and Login Button
                VStack {
                    // login textfield
                    TextField("이메일을 입력해주세요.", text: $email)
                        .disableAutocorrection(true)
                        .textInputAutocapitalization(.never)
                        .padding()
                        .background(Color.lightGreyColor)
                        .cornerRadius(5.0)
                        .padding(.bottom, 16)
                        .padding(.horizontal, 16)
                    
                    // password secure field
                    SecureField("비밀번호를 입력해주세요.", text: $password)
                        .disableAutocorrection(true)
                        .textInputAutocapitalization(.never)
                        .padding()
                        .background(Color.lightGreyColor)
                        .cornerRadius(5.0)
                        .padding(.bottom, 16)
                        .padding(.horizontal, 16)
                    
                    Button( action: {
                        self.loginViewModel.requestLogin(email: self.email, password: self.password, globalData: globalData)
                    }) {
                       LoginButtonContent()
                    }
                }
            }
        }
        .onAppear(perform: UIApplication.shared.hideKeyboard)
    }
}


struct LoginButtonContent : View {
    var body: some View {
        return Text("LOGIN")
            .font(.headline)
            .foregroundColor(.black)
            .padding()
            .frame(width: 220, height: 60)
            .background(Color.loginButtonColor)
            .cornerRadius(15.0)
            .overlay(
                RoundedRectangle(cornerRadius: 15.0)
                    .stroke(Color.borderColor, lineWidth: 2)
            )
    }
}
