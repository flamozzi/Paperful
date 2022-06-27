import SwiftUI
import SwiftUIPullToRefresh
import Alamofire
import UIKit

struct ThumbnailViewListView: View {
    
    @EnvironmentObject var globalData: GlobalData
    @ObservedObject var thumbnailViewListViewModel: ThumbnailViewListViewModel = .init()
    @State private var tabBar: UITabBar! = nil
    
    init() {
        UITableView.appearance().showsVerticalScrollIndicator = false
    }
    
    var body: some View {
        VStack {
            List {
                ForEach(0..<self.thumbnailViewListViewModel.thumbnailViewList.count, id: \.self) { iterator in
                    //MARK: - general form
                    if self.thumbnailViewListViewModel.thumbnailViewList[iterator].thumbnailViewModel.object_type == "general" {
                        ZStack {
                            self.thumbnailViewListViewModel.thumbnailViewList[iterator]
                                .onAppear() {
                                    if iterator % 10 == 9 {
                                        self.thumbnailViewListViewModel.loadNextPage()
                                    }
                                }
                            
                            NavigationLink(
                                destination: DetailView_General(postID: self.thumbnailViewListViewModel.thumbnailViewList[iterator].thumbnailViewModel.id)
                                    .onAppear { self.tabBar.isHidden = true }
                            ) {
                                EmptyView()
                            }
                            .buttonStyle(PlainButtonStyle())
                            .opacity(0)
                        }
                        .listRowSeparator(.hidden)
                    }
                    
                    //MARK: - 일기? 추가해야함
                    
                    //MARK: - 시? 추가해야함
                    
                }
                .listRowBackground(Color.backgroundColor)
            }
            .listStyle(PlainListStyle())
            .refreshable {
                self.thumbnailViewListViewModel.reload()
            }
        }
        .onAppear {
            self.thumbnailViewListViewModel.settingHomeModels()
            self.thumbnailViewListViewModel.reload()
        }
        .background(TabBarAccessor { tabbar in
            self.tabBar = tabbar
        })
    }
}

//struct ThumbnailListView_Previews: PreviewProvider {
//    static var previews: some View {
//        ThumbnailListView()
//    }
//}
