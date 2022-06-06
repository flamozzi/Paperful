import SwiftUI

struct EditTitleView_General: View {
    
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
                ZStack {
                    // placeholder
                    if self.enter_title.isEmpty{
                        TextEditor(text: $placeholder_title)
                            .font(.title2)
                            .foregroundColor(.gray)
                            .disabled(true)
                            .padding()
                    }
                    TextEditor(text: $enter_title)
                        .padding()
                        .font(.title2)
                        .opacity(self.enter_title.isEmpty ? 0.25 : 1)
                        .disableAutocorrection(true)
                        .onChange(of: enter_title, perform: { _ in
                            globalData.editContent.title = self.enter_title
                        })
                    Text(enter_title).opacity(0).padding(.all, 8)
                }
            }
            .alert(isPresented: $showingAlert) {
                Alert(title: Text("정말 뒤로 가시겠습니까?"),
                      message: Text("글쓰기를 취소하시면 작성중이던 내용을 잃게 됩니다."),
                      primaryButton: .destructive(Text("뒤로"), action: {
                    self.presentationMode.wrappedValue.dismiss()
                }), secondaryButton: .cancel(Text("취소")))
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                btnBack // 정말 뒤로 갈 건지 물어봄 (작업중인 정보 다 잃어버린다고 경고 주기)
                
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                if globalData.editContent.title != "" && globalData.editContent.title.trimmingCharacters(in: .whitespaces) != "" {
                    NavigationLink(
                        destination: EditContentView_General()
                    ) {
                        Text("다음")
                    }
                }
            }
        }
    }
}
