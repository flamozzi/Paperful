import SwiftUI
import SwiftUIPullToRefresh
import PartialSheet

struct ProfileView: View {
    @State private var tabBar: UITabBar! = nil
    @State private var showModal = false
    @EnvironmentObject var globalData: GlobalData
    
    @StateObject var profileViewModel: ProfileViewModel = .init()
    
    var body: some View {
        
        NavigationView {
            
            ZStack {
                Color.backgroundColor.edgesIgnoringSafeArea(.all)
                
                VStack {
                    Rectangle()
                        .frame(height: 0)
                    
                    List {
                        HStack {
                            Spacer()
                            VStack(spacing: 8) {
                                // image
                                AsyncImage(url: URL(string: globalData.currentUserProfile.image!)) { image in
                                    image
                                        .resizable()
                                        .scaledToFit()
                                    
                                } placeholder: {
                                    Image(globalData.currentUserProfile.image!)
                                }
                                .clipShape(Circle())
                                .frame(minWidth: 0, idealWidth: 150, maxWidth: 150,
                                       minHeight: 0, idealHeight: 150, maxHeight: 150,
                                       alignment: .center)
                                
                                // 게시물 및 구독자 수
                                HStack {
                                    VStack {
                                        Text("\(self.profileViewModel.postList.total)")
                                            .font(.subheadline)
                                        Text("게시물")
                                            .font(.subheadline)
                                    }
                                    
                                    Text("|")
                                        .font(.title2)
                                    
                                    VStack {
                                        Text("\(globalData.currentUserProfile.numberOfSubscribers)")
                                            .font(.subheadline)
                                        Text("구독자")
                                            .font(.subheadline)
                                    }
                                }
                                
                                // intro
                                Text(globalData.currentUserProfile.intro)
                                    .font(.subheadline)
                                    .bold()
                                
                                if self.profileViewModel.postList.total == 0 {
                                    Text("아직 작성한 글이 없습니다.")
                                        .font(.subheadline)
                                        .foregroundColor(Color.gray)
                                        .padding(.vertical, 40)
                                }
                            }
                            Spacer()
                        }
                        .listRowSeparator(.hidden)
                        .listRowBackground(Color.backgroundColor)
                        
                        if self.profileViewModel.postList.total != 0 {
                            ForEach(0..<self.profileViewModel.thumbnailViewList.count, id: \.self) { iterator in
                                //MARK: - general form
                                if self.profileViewModel.thumbnailViewList[iterator].thumbnailViewModel.object_type == "general" {
                                    ZStack {
                                        self.profileViewModel.thumbnailViewList[iterator]
                                            .onAppear() {
                                                if iterator % 10 == 9 {
                                                    self.profileViewModel.requestNextPostList(UserID: globalData.currentUserProfile.id)
                                                }
                                            }
                                        
                                        NavigationLink(
                                            destination: DetailView_General(postID: self.profileViewModel.thumbnailViewList[iterator].thumbnailViewModel.id)
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
                        
                    }
                    .listStyle(PlainListStyle())
                    .refreshable {
                        self.profileViewModel.requestPostListModel(UserID: globalData.currentUserProfile.id)
                        self.profileViewModel.requestPostList(UserID: globalData.currentUserProfile.id)
                    }
                    
                    
                }
            }
            .navigationBarTitle("", displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Text(globalData.currentUserProfile.nickname)
                        .font(.title)
                        .onAppear { self.tabBar.isHidden = false }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    HStack {
                        // 다른 사람 프로필 뷰
                        //                        Text("구독")
                        //                        Text("후원")
                        
                        Button(action: {
                            self.showModal = true
                        }) {
                            Image(systemName: "line.3.horizontal")
                                .imageScale(.large)
                        }
                        .partialSheet(isPresented: self.$showModal) {
                            ProfileModalView()
                        }
                    }
                }
            }
            .onAppear {
                self.profileViewModel.requestPostListModel(UserID: globalData.currentUserProfile.id)
                self.profileViewModel.requestPostList(UserID: globalData.currentUserProfile.id)
            }
        }
        .background(TabBarAccessor { tabbar in
            self.tabBar = tabbar
        })
    }
}

//struct ProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileView()
//    }
//}



