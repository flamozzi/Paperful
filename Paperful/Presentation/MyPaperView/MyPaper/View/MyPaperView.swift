//
//  MyPaperView.swift
//  Paperful
//
//  Created by eunsol kim on 2022/05/19.
//

import SwiftUI

struct MyPaperView: View {
   
    @State private var tabBar: UITabBar! = nil
    let data = Array(1...1000).map{"제목\($0)"}
    
    var body: some View {
        
        NavigationView {
            ZStack {
                Color.backgroundColor
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    Divider()
                    // .opacity(0)
                    ListView1()
                }

            }
            .navigationBarTitle("", displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Text("Paperful")
                        .font(.title)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    HStack(spacing: -3) {
                        NavigationLink(
                            destination: ConfigurationView()
                                .onAppear { self.tabBar.isHidden = true }
                        ) {
                            Image(systemName: "slider.horizontal.3")
                                .font(.system(size: 20))
                                .foregroundColor(.black)
                        }
                        .onAppear { self.tabBar?.isHidden = false }
                    }
                }
            }
                
        }
        .background(TabBarAccessor { tabbar in   // << here !!
            self.tabBar = tabbar
        })
    }
}

struct MyPaperView_Previews: PreviewProvider {
    static var previews: some View {
        MyPaperView().previewDevice("iPhone 13")
    }
}
