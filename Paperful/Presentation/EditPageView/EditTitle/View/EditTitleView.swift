//
//  EditPageView.swift
//  Paperful
//
//  Created by Tony on 2022/04/22.
//

import SwiftUI

struct EditTitleView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State var enter_title = ""
    @State var title = ""
    @State var placeholder_title: String = "제목"
    
    @State var enter_content = ""
    @State var content = ""
    @State var placeholder_content: String = "당신의 소중한 생각을 기록해주세요."
    
    var btnBack : some View { Button(action: {
        self.presentationMode.wrappedValue.dismiss()
        }) {
            Text("닫기")
        }
    }
    
    init() {
        UITextView.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        ZStack {
            Color(red: 254/255, green: 252/255, blue: 245/255)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                // Title Text Editor
                ZStack {
                    // placeholder
                    if self.enter_title.isEmpty{
                        TextEditor(text: $placeholder_title)
                            .font(.title2)
                            .foregroundColor(.gray)
                            .disabled(true)
                            .padding()
                    }
                    TextEditor(text: $enter_title)
                        .padding()
                        .font(.title2)
                        .opacity(self.enter_title.isEmpty ? 0.25 : 1)
                        .disableAutocorrection(true)
                        .onChange(of: enter_title, perform: { _ in
                            self.title = self.enter_title
                        })
                        .border(Color.red, width: 1)
                    Text(enter_title).opacity(0).padding(.all, 8)
                }
                Spacer()
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                btnBack
            }
            ToolbarItem(placement: .principal) {
                Text(title)
                    .onChange(of: title, perform: { _ in
                        title = self.title
                    })
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Text("기록")
            }
        }
        
    }
}



//
//struct EditPageView_Previews: PreviewProvider {
//    static var previews: some View {
//        EditPageView()
//    }
//}
