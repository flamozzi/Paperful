//
//  FormListView.swift
//  Paperful
//
//  Created by Tony on 2022/05/16.
//

import SwiftUI

struct FormView: View {
    
    @ObservedObject var formViewModel: FormViewModel = .init()
    
    var body: some View {
        ZStack {
            Color.backgroundColor.edgesIgnoringSafeArea(.all)
            
            VStack {
                ZStack {
                    VStack {
                        Rectangle()
                            .fill(Color.backgroundColor)
                            .frame(minWidth: 0, idealWidth: 350, maxWidth: .infinity, minHeight: 0, idealHeight: 200, maxHeight: .infinity, alignment: .center)
                            .border(Color.borderColor)
                            .padding(8)
                    }
                    VStack {
                        // 폼 이미지와 설명 나눔
                        HStack (spacing: 16){
                            // 폼 이미지
                            Image(self.formViewModel.image)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(minWidth: 0, idealWidth: 350, maxWidth: .infinity, minHeight: 0, idealHeight: 200, maxHeight: .infinity, alignment: .center)
            
                            
                            VStack (alignment: .leading, spacing: 4){
                                Text(self.formViewModel.title)
                                    .font(.title2)
                                Text(self.formViewModel.intro)
                                    .font(.subheadline)
                            }
                            .frame(minWidth: 0, idealWidth: 350, maxWidth: .infinity, minHeight: 0, idealHeight: 200, maxHeight: .infinity, alignment: .leading)
                        }
                        .padding(.horizontal, 16)
                    }
                }
            }
        }
    }
}

//struct FormListView_Previews: PreviewProvider {
//    static var previews: some View {
//        FormView()
//    }
//}
