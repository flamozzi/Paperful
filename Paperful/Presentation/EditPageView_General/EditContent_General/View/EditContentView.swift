import SwiftUI

struct EditContentView_General: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var globalData: GlobalData
    
    @State var enter_content: String = ""
    @State var placeholder_content: String = "당신의 소중한 생각을 기록해주세요."
    
    var btnBack : some View { Button(action: {
        self.presentationMode.wrappedValue.dismiss()
        }) {
            Text("뒤로")
        }
    }
    
    init() {
        UITextView.appearance().backgroundColor = .clear
    }
    
    var body: some View {  // 화면 하단 부에 글자 byte나 맞춤법 검사? 미리보기? 등 기타 기능들 추가
        ZStack {
            Color.backgroundColor.edgesIgnoringSafeArea(.all)
            
            VStack {
                Divider()
                
                // Content Text Editor
                ZStack {
                    // placeholder
                    if enter_content.isEmpty && globalData.editContent.content.isEmpty {
                        TextEditor(text: $placeholder_content)
                            .font(.body)
                            .foregroundColor(.gray)
                            .disabled(true)
                            .padding()
                    }
                    TextEditor(text: $enter_content)
                        .onAppear {
                            enter_content = globalData.editContent.content
                        }
                        .onDisappear {
                            globalData.editContent.content = enter_content
                        }
                        .padding()
                        .font(.body)
                        .opacity(self.enter_content.isEmpty ? 0.25 : 1)
                        .disableAutocorrection(true)
                    Text(enter_content).opacity(0).padding(.all, 8)
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                btnBack
            }
            ToolbarItem(placement: .principal) {
                Text(globalData.editContent.title)
                    .lineLimit(1)
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                if globalData.editContent.title != "" {
                    NavigationLink(
                        destination: PrewviewView_General()
                    ) {
                        Text("다음")
                    }
                }
            }
        }
    }
}

//
//struct EditContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        EditContentView()
//    }
//}
