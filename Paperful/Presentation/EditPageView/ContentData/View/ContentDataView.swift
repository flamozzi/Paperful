//
//  EditContentView.swift
//  Paperful
//
//  Created by Tony on 2022/04/27.
//

import SwiftUI

struct ContentDataView: View {
    
    var editPageView: EditTitleView
    var content = ""
    
    init(editPageView: EditTitleView) {
        self.editPageView = editPageView
        self.content = editPageView.content
    }
    
    var body: some View {
        Text(content)
            .font(.body)
            .padding(.horizontal, 16)
    }
}

//struct EditContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        EditContentView()
//    }
//}
