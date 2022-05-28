import SwiftUI
import SwiftUIPullToRefresh
import Alamofire
import UIKit

struct ThumbnailViewListView: View {
    
    @EnvironmentObject var globalData: GlobalData
    @ObservedObject var thumbnailViewListViewModel: ThumbnailViewListViewModel = .init()
    
    init() {
        self.thumbnailViewListViewModel.reload()
    }
    
    var body: some View {
        VStack {
            RefreshableScrollView(showsIndicators: false, loadingViewBackgroundColor: .backgroundColor, onRefresh: { done in
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.thumbnailViewListViewModel.reload()
                    done()
                }
            }) {
                LazyVStack (spacing: -10) {
                    ForEach(0..<self.thumbnailViewListViewModel.thumbnailViewList.count, id: \.self) { iterator in
                        if self.thumbnailViewListViewModel.thumbnailViewList[iterator].thumbnailViewModel.object_type == "general" {
                            NavigationLink(
                                destination: DetailView_General(postID: self.thumbnailViewListViewModel.thumbnailViewList[iterator].thumbnailViewModel.id)
                            ) {
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
    }
}

//struct ThumbnailListView_Previews: PreviewProvider {
//    static var previews: some View {
//        ThumbnailListView()
//    }
//}
