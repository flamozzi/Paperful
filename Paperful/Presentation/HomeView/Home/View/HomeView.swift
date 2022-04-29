import SwiftUI

struct HomeView: View {
    
    @State private var tabBar: UITabBar! = nil
    @EnvironmentObject var editContentViewModel: EditContentViewModel
    
    var body: some View {
        
        NavigationView {
            ZStack {
//                Color(red: 254/255, green: 255/255, blue: 250/255) //background color
//                    .edgesIgnoringSafeArea(.all)
                Color(red: 254/255, green: 252/255, blue: 245/255)
                    .edgesIgnoringSafeArea(.all)
                // border color == Color(red: 231/255, green: 228/255, blue: 222/255)
                
                VStack {
                    Divider()
                    // .opacity(0)
                    ThumbnailListView()
                }
                .onAppear {
                    editContentViewModel.content = ""
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
                            destination: EditTitleView()
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
        .background(TabBarAccessor { tabbar in   // << here !!
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
