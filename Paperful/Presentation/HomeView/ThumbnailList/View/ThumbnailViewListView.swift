import SwiftUI
import SwiftUIPullToRefresh
import Alamofire
import UIKit

struct ThumbnailViewListView: View {
    
    @ObservedObject var thumbnailViewListViewModel: ThumbnailViewListViewModel = .init()
    
    init() {
        self.thumbnailViewListViewModel.reload()
    }
    
    var body: some View {
        VStack {
            RefreshableScrollView(showsIndicators: true, loadingViewBackgroundColor: .backgroundColor, onRefresh: { done in
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.thumbnailViewListViewModel.reload()
                    print(self.thumbnailViewListViewModel.page)
                    done()
                }
            }) {
                LazyVStack (spacing: -10) {
                    ForEach(0..<self.thumbnailViewListViewModel.thumbnailViewList.count, id: \.self) { iterator in
                        self.thumbnailViewListViewModel.thumbnailViewList[iterator]
                            .onAppear() {
                                if iterator % 10 == 9 {
                                    self.thumbnailViewListViewModel.loadNextPage(page: self.thumbnailViewListViewModel.page)
                                }
                            }
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
