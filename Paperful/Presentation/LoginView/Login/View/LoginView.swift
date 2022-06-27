import SwiftUI

struct LoginView: View {
    
    @EnvironmentObject var globalData: GlobalData
    
    @State var email: String = ""
    @State var password: String = ""
    
    @StateObject private var loginViewModel: LoginViewModel = .init()
    
    var body: some View {
        NavigationView {
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
                        
                        NavigationLink (
                            destination: SignUpView()
                        ) {
                            SignUpButtonContent()
                        }
                        
                        NavigationLink (
                            destination: ContentView()
                        ) {
                            SkipButton()
                                .onTapGesture {
                                    globalData.isGuest = true
                                }
                        }
                        
                        // 테스트용 아이디 자동입력 장치 (다 쓰고 지워야 함)
                        Button( action: {
                            self.email = "test1@test.com"
                            self.password = "test"
                        }) {
                           TestEnter()
                        }
                    }
                }
            }
            .onAppear(perform: UIApplication.shared.hideKeyboard)
        }
    }
}


struct LoginButtonContent : View {
    var body: some View {
        return Text("로그인")
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

struct SignUpButtonContent : View {
    var body: some View {
        return Text("회원가입")
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

struct SkipButton : View {
    var body: some View {
        return Text("건너뛰기")
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

struct TestEnter : View {
    var body: some View {
        return Text("테스트용 아이디/비번 자동입력 장치")
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
