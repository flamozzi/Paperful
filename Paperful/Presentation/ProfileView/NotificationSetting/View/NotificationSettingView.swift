//
//  NotificationSettingView.swift
//  Paperful
//
//  Created by Tony on 2022/06/06.
//

import SwiftUI

struct NotificationSettingView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var globalData: GlobalData
    
//    @ObservedObject var selectFormViewModel: SelectFormViewModel = .init()
    
    var btnBack : some View { Button(action: {
        self.presentationMode.wrappedValue.dismiss()
    }) {
        Text("닫기")
    }
    }
    
    var body: some View {
        ZStack {
            Color.backgroundColor.edgesIgnoringSafeArea(.all)
            
            VStack {
                HStack {
                    Text("알림 설정")
                        .font(.title)
                        .bold()
                    .padding(.horizontal, 16)
                    Spacer()
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                btnBack
            }
        }
    }
}

struct NotificationSettingView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationSettingView()
    }
}
