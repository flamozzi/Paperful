import SwiftUI
import SwiftUIPullToRefresh

struct NotificationView: View {
    
    @ObservedObject var notificationViewModel: NotificationViewModel = .init()
    
    var body: some View {
        ZStack {
            Color.backgroundColor
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                HStack {
                    Text("알림")
                        .font(.title)
                        .bold()
                        .padding(.horizontal, 16)
                    Spacer()
                }
                ScrollView {
                    LazyVStack (alignment: .leading, spacing: 16){
                        ForEach(0..<self.notificationViewModel.notificationList.count, id: \.self) { iterator in
//                            Text("\(self.notificationViewModel.notificationList[iterator])")
                            Text("\(self.notificationViewModel.notificationList[iterator])")
                                .padding(.horizontal, 16)
                        }
                    }
                }
            }
        }
    }
}

//struct NotificationView_Previews: PreviewProvider {
//    static var previews: some View {
//        NotificationView()
//    }
//}
