import SwiftUI

struct EditThumbnailView_General: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var globalData: GlobalData
    
    @ObservedObject private var editThumbnailViewModel: EditThumbnailViewModel_General = .init()
    
    var btnBack : some View { Button(action: {
        self.presentationMode.wrappedValue.dismiss()
    }) {
        Text("뒤로")
    }
    }
    
    var body: some View {
        ZStack {
            Color.backgroundColor.edgesIgnoringSafeArea(.all)
            
            VStack {
                Divider()
                
                HStack {
                    Text("여러분이 작성한 글의 커버 이미지와 소개글을 등록해보세요. 등록하지 않고도 작성을 완료할 수 있습니다. (선택)")
                        .font(.subheadline)
                        .foregroundColor(Color.gray)
                        .padding(.horizontal, 16)
                }
                
                Divider()
                // 폼에 맞게 수정
                
                EditThumbnailView().environmentObject(globalData)
                
                Spacer()
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                btnBack
            }
            ToolbarItem(placement: .principal) {
                Text("썸네일 등록")
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink(
                    destination: PrewviewView_General()
                ) {
                    Text("완료")
                }
            }
        }
    }
}

//struct EditThumbnail_General_Previews: PreviewProvider {
//    static var previews: some View {
//        EditThumbnailView_General()
//    }
//}
