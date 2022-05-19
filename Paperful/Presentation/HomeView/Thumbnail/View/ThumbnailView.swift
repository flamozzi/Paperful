import SwiftUI
import Foundation

struct ThumbnailView: View {

    @ObservedObject var thumbnailViewModel: ThumbnailViewModel = .init()

    var body: some View {
        ZStack {
            Color.backgroundColor
                .edgesIgnoringSafeArea(.all)

            ZStack {
                VStack {
                    if self.thumbnailViewModel.thumbnail == nil {
                        Rectangle()
                            .fill(Color.backgroundColor)
                            .frame(minWidth: 0, idealWidth: 350, maxWidth: .infinity, minHeight: 0, idealHeight: 200, maxHeight: .infinity, alignment: .center)
                            .border(Color.borderColor)
                            .padding(10)
                    }
                    else {
                        Rectangle()
                            .fill(Color.backgroundColor)
                            .frame(minWidth: 0, idealWidth: 350, maxWidth: .infinity, minHeight: 0, idealHeight: 350, maxHeight: .infinity, alignment: .center)
                            .border(Color.borderColor)
                            .padding(10)
                    }
                }
                VStack (spacing: 16){
                    VStack (spacing: 16){
                        //title
                        Text(self.thumbnailViewModel.title)
                            .font(.title2)
                            .lineLimit(1)
                            .padding(.bottom, -8)
                        
                        // image가 nil이 아니면
                        if self.thumbnailViewModel.thumbnail != nil {
                            VStack {
                                Text("────────────────────")
                                    .bold()

                                // image
                                AsyncImage(url: URL(string: self.thumbnailViewModel.thumbnail!)) { image in
                                    image
                                        .resizable()
                                        .scaledToFit()
                                } placeholder: {
                                    Image(self.thumbnailViewModel.thumbnail!)
                                }
                                .frame(minWidth: 0, idealWidth: 200, maxWidth: .infinity, minHeight: 0, idealHeight: 200, maxHeight: .infinity, alignment: .center)
                                .padding(.horizontal, 48)


                                HStack {
                                    Spacer()
                                    //writer nickname
                                    Text(self.thumbnailViewModel.writerNickname)
                                        .font(.subheadline)
                                        .bold()
                                        .lineLimit(1)
                                }
                                .padding(.horizontal, 16)
                                .padding(.bottom, -24)

                                Text("────────────────────")
                                    .bold()
                            }
                        }
                        // image가 nill 이면
                        else {
                            Text(self.thumbnailViewModel.writerNickname)
                                .font(.subheadline)
                                .bold()
                                .lineLimit(1)
                        }
                    }

                    VStack (spacing: 8){

                        Text(self.thumbnailViewModel.intro)
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
