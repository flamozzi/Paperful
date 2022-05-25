//
//  ConfigurationView.swift
//  Paperful
//
//  Created by eunsol kim on 2022/05/19.
//

import SwiftUI
import PhotosUI

struct ConfigurationView: View {
  
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @State private var selectedImage: UIImage?
    @State private var isImagePickerDisplay = false
    
    var nickName:String = "nickName"
    
    @State var showActionView = false
    
    var actionSheet: ActionSheet {
        ActionSheet(title: Text("Select an action"), message: Text("선택"),  buttons: [
            .default(Text("카메라"), action: {
                //TODO: struct -> UIPickerController
                self.sourceType = .camera
                self.isImagePickerDisplay.toggle()
            }),
            .default(Text("앨범"), action: {
                //TODO
                self.sourceType = .photoLibrary
                self.isImagePickerDisplay.toggle()
            }),
            .cancel()
        ])
        
    }
        
    
    //var message:String = "introduce"
    @State private var newComment = true
    @State private var subscription = true
    @State private var text:String = "introduce"

    @State private var currentTab: Int = 0
    @Namespace var namespace
        
    var body: some View {
        ZStack {
            Color(red: 254/255, green: 255/255, blue: 250/255) //background color
                    .edgesIgnoringSafeArea(.all)
            VStack{
                VStack {
                    if selectedImage != nil {
                        Image(uiImage: selectedImage!)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .clipShape(Circle())
                            .frame(width: 200, height: 200)
                    } else {
                        Image(systemName: "person")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .clipShape(Circle())
                            .frame(width: 200, height: 200)
                    }
                }
                .padding(.top, 16)
                .onTapGesture(perform: { self.showActionView.toggle()}).actionSheet(isPresented: $showActionView, content: {
                        self.actionSheet
                    })
                .sheet(isPresented: self.$isImagePickerDisplay) {
                    SUImagePicker(selectedImage: self.$selectedImage, sourceType: self.sourceType)
                    }
            
                UserInfo.padding(10)
                AlertInfo
                
                Spacer()
                Text("회원탈퇴").padding(15).foregroundColor(Color.red)
            }
                    
        }
    }

    var AlertInfo: some View {
        ZStack {
            //color
            //Color.blue.opacity(0.2).edgesIgnoringSafeArea(.all)
            VStack {
                HStack(alignment: .center) {
                    Text("댓글 알림").font(.subheadline).padding()
                    Spacer()
                    Toggle(isOn: $newComment) {
                            
                    }
                    .padding()
                    .toggleStyle(SwitchToggleStyle(tint: Color.black))
                }
                HStack(alignment: .center) {
                    Text("구독한 글 알림").font(.subheadline).padding()
                    Spacer()
                    Toggle(isOn: $subscription) {
                            
                    }
                    .padding()
                    .toggleStyle(SwitchToggleStyle(tint: Color.black))
                }
            }
        }
    }
}
        
private extension ConfigurationView {
    
    
        
    var UserInfo: some View {
        VStack(alignment: .center) {
            Text(nickName).font(.title).offset(y: 10)
                    
            HStack(alignment: .center) {
//                TextField("", text: $text)
//                    .onReceive(Just(text), perform: {
//                        _ in
//                        if maxCharacterLength < text.count
//                    })
                TextEditor(text: $text)
                    .onChange(of: text){ value in
                        if(text.count >= 30) {
                            text = "introduce"
                        }
                    }.frame(height: 50)
                    .multilineTextAlignment(.center)
                    
                //Text(message).font(.subheadline).offset(y: 20)
            }
        }
        .padding()
    }
}

struct CircleImage: View {
    var image: Image
    var imgHW: CGFloat = 130
        
    var body: some View {
        image.resizable().frame(width: imgHW, height: imgHW).clipShape(Circle()).overlay(Circle().stroke(Color.white, lineWidth: 3)).shadow( radius: 5)
    }
}
struct ConfigurationView_Previews: PreviewProvider {
    static var previews: some View {
        ConfigurationView().previewDevice("iPhone 13")
    }
}
