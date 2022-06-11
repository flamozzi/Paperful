import SwiftUI
import Foundation
import Mantis

struct UserProfileSelectView: View {
    // MARK: - global Data
    @EnvironmentObject var globalData: GlobalData
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    // MARK: - VM
    @ObservedObject var userProfileSelectViewModel: UserProfileSelectViewModel = .init()
    
    var btnBack : some View { Button(action: {
//        self.presentationMode.wrappedValue.dismiss()
        globalData.resetUserToken()
        
    }) {
        Text("뒤로")
    }
    }
    
    init(globalData: GlobalData) {
        self.userProfileSelectViewModel.loadUserProfileList(globalData: globalData)
        self.userProfileSelectViewModel.settingUserProfileListModel(globalData: globalData)
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.backgroundColor.edgesIgnoringSafeArea(.all)
                
                VStack (spacing: 32){
                    
                    Text("프로필 선택")
                        .font(.title)
                        .bold()
                        .padding(.horizontal, 16)
                    
                    ScrollView(.horizontal) {
                        HStack{
                            ForEach(0..<self.userProfileSelectViewModel.userProfileViewList.count, id: \.self) { iterator in
                                // ContentView로 이동
                                self.userProfileSelectViewModel.userProfileViewList[iterator]
                                    .onTapGesture {
                                        // 선택한 유저 프로필로 globalData의 current 유저 정보로 매핑
                                        globalData.currentUserProfile.id = self.userProfileSelectViewModel.userProfileViewList[iterator].userProfileViewModel.userProfileID
                                        
                                        globalData.currentUserProfile.image = self.userProfileSelectViewModel.userProfileViewList[iterator].userProfileViewModel.userProfileImage
                                        
                                        globalData.currentUserProfile.intro = self.userProfileSelectViewModel.userProfileViewList[iterator].userProfileViewModel.userProfileIntro
                                        
                                        globalData.currentUserProfile.nickname = self.userProfileSelectViewModel.userProfileViewList[iterator].userProfileViewModel.userProfileNickname
                                        
                                        globalData.currentUserProfile.numberOfSubscribers = self.userProfileSelectViewModel.userProfileViewList[iterator].userProfileViewModel.userProfileNumberOfSubscribers
                                        
                                        globalData.isMember = true
                                    }
                                    .onAppear() {
                                        if iterator % 10 == 9 {
                                            self.userProfileSelectViewModel.loadNextProfileList(globalData: globalData)
                                        }
                                    }
                            }
                            
                            // AddUserProfileView로 이동
                            NavigationLink(
                                destination: AddUserProfileView()
                            ) {
                                AddUserCircleButton()
                            }
                        }
                    }
                    
                    Text("클릭해서 접속할 프로필을 선택하거나\n새로운 프로필을 생성해 주세요.")
                        .font(.subheadline)
                        .foregroundColor(Color.gray)
                        .bold()
                        .padding(.horizontal, 16)
                    
                    Spacer()
                }
            }
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    btnBack
                        .foregroundColor(Color.black)
                }
            }
        }
    }
}

// 예쁘게 고쳐야함
struct AddUserCircleButton : View {
    var body: some View {
        VStack {
            Text("신규 프로필 생성")
                .font(.subheadline)
                .foregroundColor(Color.gray)
                .bold()
                .frame(minWidth: 0, idealWidth: 150, maxWidth: 158,
                       minHeight: 0, idealHeight: 150, maxHeight: 158,
                       alignment: .center)
                .border(Color.gray)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.black))
            
            // HStack 내의 위치 조정을 위한 공백
            Text(" ")
            Text(" ")
        }
        .padding(16)
    }
}
