import SwiftUI

struct EditThumbnailView_General: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var globalData: GlobalData
    
    @Binding var firstNaviLinkActive: Bool
    
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
                Text("완료")
                    .onTapGesture {
                        // 공개여부는 알파 버전에서는 무조건 공개 하는 것으로 일단 설정 (추후 비공개 및 공개 범위 설정 기능 추가)
                        self.editThumbnailViewModel.requestAddPost(object_type: "general", status: "O", userProfileID: globalData.currentUserProfile.id, title: globalData.editContent.title, content: globalData.editContent.content, image: globalData.editContent.thumbnailData, intro: globalData.editContent.intro, globalData: globalData)
                    }
            }
        }
        .onChange(of: globalData.postSuccessTogle, perform: { _ in
            self.firstNaviLinkActive = false
        })
    }
}

//struct EditThumbnail_General_Previews: PreviewProvider {
//    static var previews: some View {
//        EditThumbnailView_General()
//    }
//}
