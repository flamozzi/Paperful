import SwiftUI

struct PrewviewView_General: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var globalData: GlobalData
    
    @StateObject var previewViewModel: PreviewViewModel_General = .init()
    
    var btnBack : some View { Button(action: {
        self.presentationMode.wrappedValue.dismiss()
    }) {
        Text("뒤로")
    }
    }
    
    init() {
        UITextView.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        ZStack {
            Color.backgroundColor.edgesIgnoringSafeArea(.all)
            
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    
                    Divider()
                    
                    HStack {
                        Text("여러분이 작성한 글은 다른 유저에게 다음과 같이 보여집니다.")
                            .font(.subheadline)
                            .foregroundColor(Color.gray)
                            .padding(.horizontal, 16)
                    }
                    
                    Divider()
                    
                    HStack {
                        Text(globalData.editContent.title.trimmingCharacters(in: .whitespaces))
                            .font(.title)
                            .padding(.horizontal, 16)
                        Spacer()
                    }
                    
                    HStack {
                        Text("임시닉네임") // 동적으로 유저 이름에 따라 받게 바꿔야함
                            .font(.subheadline)
                            .bold()
                        
                        Text("|")
                        
                        Text(previewViewModel.getDate())
                            .font(.subheadline)
                            .foregroundColor(Color.gray)
                        
                        Spacer()
                    }
                    .padding(.horizontal, 16)
                    
                    HStack {
                        Text(globalData.editContent.content)
                            .font(.body)
                            .padding(.horizontal, 16)
                        Spacer()
                    }
                    
                    Spacer()
                }
                
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                btnBack
            }
            ToolbarItem(placement: .principal) {
                Text("미리보기")
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink(
                    destination: EditThumbnailView_General()
                ) {
                    Text("다음")
                }
            }
        }
    }
}


//struct PreviewView_Previews: PreviewProvider {
//    static var previews: some View {
//        PrewviewView_General()
//    }
//}
