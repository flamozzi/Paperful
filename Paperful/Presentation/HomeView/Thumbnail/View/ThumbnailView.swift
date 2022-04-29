import SwiftUI
import Foundation

struct ThumbnailView: View {
    
    var thumbnailViewModel: ThumbnailViewModel
    
    init(homeModel: HomeModel){
        self.thumbnailViewModel = ThumbnailViewModel(homeModel: homeModel)
    }
    
    var body: some View {
        
        ZStack {
//            Color(red: 254/255, green: 255/255, blue: 250/255).edgesIgnoringSafeArea(.all)
            Color(red: 254/255, green: 252/255, blue: 245/255)
                .edgesIgnoringSafeArea(.all)
            
            ZStack {
                VStack {
                    Rectangle()
                        .fill(Color(red: 254/255, green: 252/255, blue: 245/255))
                    // background color = 254, 255, 250
                        .frame(minWidth: 0, idealWidth: 350, maxWidth: .infinity, minHeight: 0, idealHeight: 350, maxHeight: .infinity, alignment: .center)
                        .border(Color(red: 231/255, green: 228/255, blue: 222/255))
                        .padding(10)
                }
                VStack (spacing: 16){
                    //image
                    //ImageView(withURL: homeContent.thumbnail)
                    VStack (spacing: 16){
                        //title
                        Text(thumbnailViewModel.getTitle())
                            .font(.title2)
                            .lineLimit(1)
                            .padding(.bottom, -8)
                        
                        Text("────────────────────")
                            .bold()
                        
                        
                        Image(thumbnailViewModel.getImage())
                            .resizable()
                            .frame(minWidth: 0, idealWidth: 200, maxWidth: .infinity, minHeight: 0, idealHeight: 200, maxHeight: .infinity, alignment: .center)
                            .aspectRatio(contentMode: .fit)
                            .padding(.horizontal, 48)
                        
                        HStack {
                            Spacer()
                            //writer nickname
                            Text(thumbnailViewModel.getWriterNickname())
                                .font(.subheadline)
                                .bold()
                                .lineLimit(1)
                        }
                        .padding(.horizontal, 16)
                        .padding(.bottom, -24)
                        
                        Text("────────────────────")
                            .bold()
                    }
                        
                    
                    
                    VStack (spacing: 8){
                        
                        Text(thumbnailViewModel.getIntro())
                            .font(.subheadline)
                            .multilineTextAlignment(.center)
                            .lineLimit(2)
                    }
                }
                .padding(32)
            }
            
        }
    }
}

//
//struct Home_Previews: PreviewProvider {
//
////    @StateObject
//
//    static var previews: some View {
//        let viewModel = ThumbnailViewModel()
//        ThumbnailView(viewModel: viewModel)
//            .previewDevice("iPhone 13")
//    }
//}
