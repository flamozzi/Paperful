import SwiftUI
import Foundation
import Mantis

struct UserProfileView: View {
    // MARK: - global Data
    @EnvironmentObject var globalData: GlobalData
    
    // MARK: - VM
    @ObservedObject var userProfileViewModel: UserProfileViewModel = .init()
    
    var body: some View {
        
        VStack {
            // image
            AsyncImage(url: URL(string: self.userProfileViewModel.userProfileImage!)) { image in
                image
                    .resizable()
                    .scaledToFit()
                
            } placeholder: {
                Image(self.userProfileViewModel.userProfileImage!)
            }
            .clipShape(Circle())
            .frame(minWidth: 0, idealWidth: 150, maxWidth: 150,
                   minHeight: 0, idealHeight: 150, maxHeight: 150,
                   alignment: .center)
            //        .shadow(radius: 10)
            
            // nickname
            Text(self.userProfileViewModel.userProfileNickname)
                .font(.subheadline)
                .foregroundColor(Color.black)
            
            // number of subscribers
            Text("구독자수: \(self.userProfileViewModel.userProfileNumberOfSubscribers)")
                .font(.subheadline)
                .foregroundColor(Color.black)
        }
        .padding(16)
    }
}
