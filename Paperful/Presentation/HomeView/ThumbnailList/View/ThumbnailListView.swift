//
//  ThumbnailListView.swift
//  Paperful
//
//  Created by Tony on 2022/04/21.
//

import SwiftUI

struct ThumbnailListView: View {
    
    var homeModels: [HomeModel]
    
    var ThumbnailList: [ThumbnailView]
    
    init() {
        self.homeModels = load("homeData.json") // homeModels init
        self.ThumbnailList = [ThumbnailView]() // array init
        for homeModel in self.homeModels {
            self.ThumbnailList
                .append(ThumbnailView(homeModel: homeModel)) // 각 Thumbnail View 들에 해당하는 json 파일 struct인 homemodel을 전달해줌
        }
    }
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack (spacing: -10) {
                ForEach(0..<ThumbnailList.count) {
                    ThumbnailList[($0)]
                }
            }
        }
    }
}

//struct ThumbnailListView_Previews: PreviewProvider {
//    static var previews: some View {
//        ThumbnailListView()
//    }
//}
