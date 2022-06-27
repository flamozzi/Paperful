import SwiftUI

struct SignUpView: View {
    @EnvironmentObject var globalData: GlobalData
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    // MARK: - 입력
    @State var username: String = ""
    @State var email: String = ""
    @State var password: String = ""
    @State var passwordChecker: String = ""

    // MARK: - 다음 스탭 진입 여부
    @State var allConditionOK: Bool = false

    @State var usernameOK: Bool = true // 실명인증 정상 (실명 인증 만들기 전까진 그냥 true로 패스)
    @State var emailOK: Bool = false // Email 중복 확인
    @State var passwordOK: Bool = false // password 동일 확인
    @State var enterOk: Bool = false // 모든 입력 정상 확인

    // MARK: - 입력 확인 Bool type var
    @State var enterUsernameOK: Bool = false
    @State var enterEmailOK: Bool = false
    @State var enterPasswordOK: Bool = false
    @State var enterPasswordCheckerOK: Bool = false

    // MARK: - 경고 메시지 랜더 여부
    @State var emailValidationAlert: Bool = false
    @State var passwordAlert: Bool = false

    // MARK: - VM
    @StateObject private var SignUpViewModel: SignUpViewModel = .init()

    var btnBack : some View { Button(action: {
        self.presentationMode.wrappedValue.dismiss()
    }) {
        Text("뒤로")
    }
    }

    var body: some View {
        ZStack {
            Color.backgroundColor
                .edgesIgnoringSafeArea(.all)

            VStack {
                HStack {
                    Text("회원가입")
                        .font(.title)
                        .bold()
                        .padding(.horizontal, 16)
                    Spacer()
                }
                TextField("실명을 입력해주세요.", text: $username)
                    .disableAutocorrection(true)
                    .textInputAutocapitalization(.never)
                    .padding()
                    .background(Color.lightGreyColor)
                    .cornerRadius(5.0)
                    .padding(.bottom, 16)
                    .padding(.horizontal, 16)
                    .onChange(of: username, perform: { _ in
                        if self.username.isEmpty {
                            self.enterUsernameOK = false
                        }
                        else {
                            self.enterUsernameOK = true
                        }
                        checkCondition()
                    })

                TextField("이메일을 입력해주세요.", text: $email)
                    .disableAutocorrection(true)
                    .textInputAutocapitalization(.never)
                    .padding()
                    .background(Color.lightGreyColor)
                    .cornerRadius(5.0)
                    .padding(.bottom, 16)
                    .padding(.horizontal, 16)
                    .onChange(of: email, perform: { _ in
                        if self.email.isEmpty {
                            self.enterEmailOK = false
                        }
                        else {
                            self.enterEmailOK = true
                        }
                        checkCondition()
                    })

                // password secure field
                SecureField("비밀번호를 입력해주세요.", text: $password)
                    .disableAutocorrection(true)
                    .textInputAutocapitalization(.never)
                    .padding()
                    .background(Color.lightGreyColor)
                    .cornerRadius(5.0)
                    .padding(.bottom, 16)
                    .padding(.horizontal, 16)
                    .onChange(of: password, perform: { _ in
                        if self.password.isEmpty {
                            self.enterPasswordOK = false
                        }
                        else {
                            self.enterPasswordOK = true
                        }
                        checkCondition()
                        self.passwordAlert = false
                    })

                // password checker secure field
                SecureField("비밀번호 확인을 위해 한번 더 입력해주세요.", text: $passwordChecker)
                    .disableAutocorrection(true)
                    .textInputAutocapitalization(.never)
                    .padding()
                    .background(Color.lightGreyColor)
                    .cornerRadius(5.0)
                    .padding(.bottom, 16)
                    .padding(.horizontal, 16)
                    .onChange(of: passwordChecker, perform: { _ in
                        if self.passwordChecker.isEmpty {
                            self.enterPasswordCheckerOK = false
                        }
                        else {
                            self.enterPasswordCheckerOK = true
                        }
                        checkCondition()
                        self.passwordAlert = false
                    })
                
                if self.emailValidationAlert == true {
                    if self.SignUpViewModel.form == false {
                        HStack {
                            Text("이메일 형식을 확인해주세요.")
                                .font(.subheadline)
                                .foregroundColor(Color.red)
                                .padding(.horizontal, 16)
                            Spacer()
                        }
                    }
                    else if self.SignUpViewModel.unique == false {
                        HStack {
                            Text("이미 존재하는 이메일 입니다.")
                                .font(.subheadline)
                                .foregroundColor(Color.red)
                                .padding(.horizontal, 16)
                            Spacer()
                        }
                    }
                }
                else {
                    if self.passwordAlert == true {
                        HStack {
                            Text("비밀 번호가 일치하지 않습니다.")
                                .font(.subheadline)
                                .foregroundColor(Color.red)
                                .padding(.horizontal, 16)
                            Spacer()
                        }
                    }
                }

                // MARK: - 가입 버튼 활성화 및 처리

                if self.enterOk {
                    // 모든 조건이 만족하면 전화번호 인증 화면으로 이동
                    if self.allConditionOK {
                        NavigationLink(
                            destination: PhoneNumberCheckView()
                        ) {
                            Button(action: {}) {
                                SignUpButton()
                            }
                        }
                    }
                    
                    // 입력은 모두 되었지만, 이메일이 이미 존재하는지, 비밀번호는 일치하는지 체크
                    else {
                        Button(action: {
                            self.SignUpViewModel.requestEmailValidationChecking(email: self.email, globalData: globalData)
                            checkCondition()
                            
                            // 이메일 중복 체크
                            if self.SignUpViewModel.is_valid == true {
                                self.emailOK = true
                                self.emailValidationAlert = false
                            }
                            else {
                                self.emailOK = false
                                self.emailValidationAlert = true
                            }
                            
                            // 비밀번호 동일 체크
                            if self.password != self.passwordChecker {
                                self.passwordOK = false
                                self.passwordAlert = true
                            }
                            else {
                                self.passwordOK = true
                                self.passwordAlert = false
                            }
                        }) {
                            SignUpButton()
                        }
                    }
                }
                Spacer()
            } 
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                btnBack
                    .foregroundColor(Color.black)
            }
        }
        // navigation bar 공백 없애기 위해 inline style의 공백 명시
        .navigationBarTitle("", displayMode: .inline)
    }

    func checkCondition() {
        if self.enterEmailOK && self.enterPasswordOK && self.enterPasswordCheckerOK && self.enterUsernameOK {
            self.enterOk = true
        }
        else {
            self.enterOk = false
        }

        if self.usernameOK && self.emailOK && self.passwordOK && self.enterOk {
            self.allConditionOK = true
        }
        else {
            self.allConditionOK = false
        }
        
        print("emailOK: \(self.emailOK)")
        print("passwordOK: \(self.passwordOK)")
        print("All Condition: \(self.allConditionOK)")
        print("")
    }
}

struct SignUpButton : View {
    var body: some View {
        return Text("가입")
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

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
