//
//  ProfileModelView.swift
//  Paperful
//
//  Created by Tony on 2022/06/06.
//

import SwiftUI

struct ProfileModelView: View {
    @Environment(\.presentationMode) var presentation
    
    var body: some View {
        VStack(spacing: 16){
            
//            NavigationLink(
//                destination: SelectFormView()
//                    .onAppear { self.tabBar.isHidden = true }
//            ) {
//                Image(systemName: "pencil")
//                    .font(.system(size: 23))
//                    .foregroundColor(.black)
//            }
//            .onAppear { self.tabBar.isHidden = false }
            
            VStack {
                HStack {
                    Image(systemName: "person.crop.circle.badge")
                        .imageScale(.large)
                    Text("계정 변경")
                    Spacer()
                }
                Divider()
            }
            
            VStack {
                HStack {
                    Image(systemName: "person.crop.circle.badge.plus")
                        .imageScale(.large)
                    Text("계정 추가")
                    Spacer()
                }
                Divider()
            }
            
            VStack {
                HStack {
                    Image(systemName: "bell")
                        .imageScale(.large)
                    Text("알림 설정")
                    Spacer()
                }
                Divider()
            }
            
            VStack {
                HStack {
                    Image(systemName: "person.fill.xmark")
                        .imageScale(.large)
                    Text("숨김유저 관리")
                    Spacer()
                }
                Divider()
            }
            
            VStack {
                Text("로그아웃")
                    .foregroundColor(Color.blue)
                Divider()
            }
            VStack {
                Text("회원탈퇴")
                    .foregroundColor(Color.blue)
                Divider()
            }
            
            Text("")
        }
        .padding(.horizontal, 32)
    }
}

//struct ProfileModelView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileModelView()
//    }
//}
