import SwiftUI
import SwiftUIPullToRefresh
import Alamofire

struct HomeView: View {
    
    @EnvironmentObject var globalData: GlobalData
    @State private var tabBar: UITabBar! = nil
    
    var body: some View {
        
        NavigationView {
            ZStack {
                Color.backgroundColor.edgesIgnoringSafeArea(.all)
                
                VStack {
                    Divider()
                    
                    if globalData.isGuest == true {
                        Text("로그인하여 모든 서비스를 이용하세요.")
                            .foregroundColor(Color.gray)
                            .padding(.horizontal, 16)
                        
                        Divider()
                    }
                    
                    ThumbnailViewListView()
                }
            }
            .navigationBarTitle("", displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Text("Paperful")
                        .font(.title)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    HStack(spacing: -3) {
                        NavigationLink(
                            destination: NotificationView()
                                .onAppear { self.tabBar.isHidden = true }
                        ) {
                            Image(systemName: "bell")
                                .font(.system(size: 20))
                                .foregroundColor(.black)
                        }
                        .onAppear { self.tabBar.isHidden = false }
                        
                        NavigationLink(
                            destination: SelectFormView()
                                .onAppear { self.tabBar.isHidden = true }
                        ) {
                            Image(systemName: "pencil")
                                .font(.system(size: 23))
                                .foregroundColor(.black)
                        }
                        .onAppear { self.tabBar.isHidden = false }
                    }
                }
            }
        }
        .background(TabBarAccessor { tabbar in
            self.tabBar = tabbar
        })
    }
}

//
//struct HomeScrollView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeView()
//            .previewDevice("iPhone 13")
//    }
//}
