import SwiftUI
import Foundation

struct ThumbnailView: View {

    @ObservedObject var thumbnailViewModel: ThumbnailViewModel = .init()

    var body: some View {

        ZStack {
            VStack {
                if self.thumbnailViewModel.thumbnail == nil {
                    Rectangle()
                        .fill(Color.backgroundColor)
                        .frame(minWidth: 0, idealWidth: 350, maxWidth: .infinity, minHeight: 0, idealHeight: 200, maxHeight: .infinity, alignment: .center)
                        .border(Color.borderColor)
                        .padding(.horizontal, -8)
                }
                else {
                    Rectangle()
                        .fill(Color.backgroundColor)
                        .frame(minWidth: 0, idealWidth: 350, maxWidth: .infinity, minHeight: 0, idealHeight: 350, maxHeight: .infinity, alignment: .center)
                        .border(Color.borderColor)
                        .padding(.horizontal, -8)
                }
            }
            VStack (spacing: 8){
                VStack (spacing: 8){
                    //title
                    Text(self.thumbnailViewModel.title)
                        .font(.title2)
                        .lineLimit(1)

                    // image가 nil이 아니면 사진과 작가 이름
                    if self.thumbnailViewModel.thumbnail != nil {
                        VStack {
                            Rectangle()
                                .frame(height: 1, alignment: .center)

                            // image
                            AsyncImage(url: URL(string: self.thumbnailViewModel.thumbnail!)) { image in
                                image
                                    .resizable()
                                    .scaledToFit()
                            } placeholder: {
                                Image(self.thumbnailViewModel.thumbnail!)
                            }
                            .frame(minWidth: 0, idealWidth: 320, maxWidth: .infinity, minHeight: 0, idealHeight: 180, maxHeight: .infinity, alignment: .center)
                            .padding(.vertical, 8)


                            HStack {
                                Spacer()
                                //writer nickname
                                Text(self.thumbnailViewModel.writerNickname)
                                    .font(.subheadline)
                                    .bold()
                                    .lineLimit(1)
                            }

                            Rectangle()
                                .frame(height: 1, alignment: .center)
                        }
                    }
                    
                    // image가 nill 이면 작가이름만
                    else {
                        Text(self.thumbnailViewModel.writerNickname)
                            .font(.subheadline)
                            .bold()
                            .lineLimit(1)
                    }
                }
                Text(self.thumbnailViewModel.intro)
                    .font(.subheadline)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
            }
            .padding(32)
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
