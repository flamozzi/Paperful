import SwiftUI
import SwiftUIPullToRefresh
import Alamofire
import UIKit

struct ThumbnailViewListView: View {
    
    private var backgroundColor = Color(red: 254/255, green: 252/255, blue: 245/255)
    
    @ObservedObject var thumbnailViewListViewModel: ThumbnailViewListViewModel = .init()
    
    init() {
        self.thumbnailViewListViewModel.reload()
    }
    
    var body: some View {
        VStack {
            // "https://api.paperful.co.kr/posts"
            
            RefreshableScrollView(showsIndicators: false, loadingViewBackgroundColor: backgroundColor, onRefresh: { done in
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.thumbnailViewListViewModel.reload()
                    done()
                }
            }) {
                LazyVStack (spacing: -10) {
                    ForEach(0..<self.thumbnailViewListViewModel.thumbnailViewList.count, id: \.self) { iterator in
                        self.thumbnailViewListViewModel.thumbnailViewList[iterator]
                    }
                }
            }
        }
    }
}



//struct ThumbnailListView_Previews: PreviewProvider {
//    static var previews: some View {
//        ThumbnailListView()
//    }
//}
