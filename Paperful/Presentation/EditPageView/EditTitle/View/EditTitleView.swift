import SwiftUI

struct EditTitleView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var editContentViewModel: EditContentViewModel
    
    @State var enter_title: String = ""
    @State var title: String = ""
    @State var placeholder_title: String = "제목을 입력해주세요."
    
    var btnBack : some View { Button(action: {
        self.presentationMode.wrappedValue.dismiss()
        }) {
            Text("닫기")
        }
    }
    
    init() {
        UITextView.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        ZStack {
            Color(red: 254/255, green: 252/255, blue: 245/255)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
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
                            self.title = self.enter_title
                        })
                    Text(enter_title).opacity(0).padding(.all, 8)
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                btnBack // 정말 뒤로 갈 건지 확인 모달? (작업중인 정보 다 잃어버린다고 경고 주기)
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink(
                    destination: EditContentView(editTitleView: self, content: self.editContentViewModel.content)
                ) {
                    Text("다음")
                }
            }
        }
        
    }
}
