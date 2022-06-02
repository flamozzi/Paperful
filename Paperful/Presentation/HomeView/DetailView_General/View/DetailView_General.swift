import SwiftUI

struct DetailView_General: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
//    @EnvironmentObject var globalData: GlobalData
    
    @ObservedObject var detailViewModel: DetailViewModel_General = .init()
    
    var btnBack : some View { Button(action: {
        self.presentationMode.wrappedValue.dismiss()
    }) {
        Text("뒤로")
    }
    }
    
    init(postID: Int) {
        detailViewModel.loadPost(postID: postID)
    }
    
    var body: some View {
        ZStack {
            Color.backgroundColor.edgesIgnoringSafeArea(.all)
            
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    
                    Divider()
                    
                    HStack {
                        Text(self.detailViewModel.postModel.title.trimmingCharacters(in: .whitespaces))
                            .font(.title)
                            .padding(.horizontal, 16)
                        Spacer()
                    }
                    
                    HStack {
                        Text(self.detailViewModel.postModel.writer.nickname)
                            .font(.subheadline)
                            .bold()
                        
                        Text("|")
                        
                        Text(self.detailViewModel.postModel.create_at)
                            .font(.subheadline)
                            .foregroundColor(Color.gray)
                        
                        Spacer()
                    }
                    .padding(.horizontal, 16)
                    
                    HStack {
                        Text(self.detailViewModel.postModel.content)
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
            ToolbarItem(placement: .navigationBarTrailing) {
                Image(systemName: "person")
                    .font(.system(size: 23))
                    .foregroundColor(.black)
            }
        }
    }
}

//struct DetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailView_General()
//    }
//}
