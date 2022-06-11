import SwiftUI

struct test: View {

    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var globalData: GlobalData

    @State private var enter_title: String = ""
    @State private var placeholder_title: String = "제목을 입력해주세요."

    @State private var showingAlert = false

    var btnBack : some View { Button(action: {
        showingAlert = true // 경고창 띄움
    }) {
        Text("뒤로")
    }
    }

    init() {
        UITextView.appearance().backgroundColor = .clear
    }

    var body: some View {
        ZStack {
            Color.backgroundColor
                .edgesIgnoringSafeArea(.all)

            VStack {
                Divider()

                // Title Text Editor
//                ZStack {
//                    // placeholder
//                    if self.enter_title.isEmpty{
//                        TextEditor(text: $placeholder_title)
//                            .font(.title2)
//                            .foregroundColor(.gray)
//                            .disabled(true)
//                            .padding()
//                    }
//                    TextEditor(text: $enter_title)
//                        .padding()
//                        .font(.title2)
//                        .opacity(self.enter_title.isEmpty ? 0.25 : 1)
//                        .disableAutocorrection(true)
//                        .onChange(of: enter_title, perform: { _ in
//                            globalData.editContent.title = self.enter_title
//                        })
//                    Text(enter_title).opacity(0).padding(.all, 8)
//                }
                
                TextField("이메일을 입력해주세요.", text: $enter_title)
                    .disableAutocorrection(true)
                    .textInputAutocapitalization(.never)
                    .padding()
                    .background(Color.lightGreyColor)
                    .cornerRadius(5.0)
                    .padding(.bottom, 16)
                    .padding(.horizontal, 16)
                    .onChange(of: enter_title, perform: { _ in
                        globalData.editContent.title = enter_title
                    })
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                btnBack // 정말 뒤로 갈 건지 물어봄 (작업중인 정보 다 잃어버린다고 경고 주기)

            }
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink(
                    destination: EditContentView_General()
                ) {
                    Text("다음")
                }
            }
        }
    }
}

