//
//  NotificationView.swift
//  Paperful
//
//  Created by Tony on 2022/04/22.
//

import SwiftUI

struct NotificationView: View {
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    var body: some View {
        Text("Notification View!")
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: Button(action : {
                            self.mode.wrappedValue.dismiss()
                        }){
                            Image(systemName: "arrow.left")
                        })
    }
}

struct NotificationView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationView()
    }
}
