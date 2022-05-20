//
//  ListView1.swift
//  Paperful
//
//  Created by eunsol kim on 2022/05/19.
//

import SwiftUI

struct ListView1: View {
    let data = Array(1...1000).map{"제목\($0)"}
    
    init() {
        UITableView.appearance().backgroundColor = .clear
    }
    var body: some View {
        List {
            
            Section(header: HStack {
                Text("글목록")
                    .font(.headline)
                    .foregroundColor(.black)
                    .padding()
                
                Spacer()
            }
            .background(Color.backgroundColor)
            .listRowInsets(EdgeInsets(
                top: 0,
                leading: 0,
                bottom: 0,
                trailing: 0))
            ) {
                ForEach(data, id:\.self) {i in
                    HStack {
                        Rectangle()
                            .fill(Color.white)
                            .frame(width: 100, height: 160)
                        .shadow(radius: 5)
                        
                        VStack{
                            Text(i).font(.title2)
                            Text("조회수").foregroundColor(.secondary)
                            Text("좋아요수").foregroundColor(.secondary)
                            Text("댓글수").foregroundColor(.secondary)
                            Text("스크랩수").foregroundColor(.secondary)
                        
                        }.frame(width: 200,height: 160, alignment: .center)
                            
                    }
                    .listRowBackground(Color.backgroundColor)
            
//                PaperPreviewView($0.Title)
                }
                .frame(height: 180)
    
            }
        }
        .background(Color.backgroundColor)
    }
       
}
//struct PaperPreviewView: View {
//    let widthText:CGFloat = 300
//    let ImageWH: CGFloat = 100
//
//    var Title:String
//    var Thumbnail:String
//
//    init( _ title:String = "")
//    {
//        self.Title = title
//        self.Thumbnail = "none"
////        setThumbnail(UserName: self.Title)
////
////        print("Thumbnail: \(Thumbnail)")
//    }
//
//    var body: some View {
//        HStack {
//            Image(self.Thumbnail)
//                .resizable()
//                .frame(width: ImageWH, height: ImageWH)
//                .clipShape(Rectangle())
//            Info
//
//            .frame(width: 200, height: 40)
//        }
//    }
//}
//
//private extension PaperPreviewView {
//
//    var Info: some View {
//        Text(Title)
//            .font(.headline)
//    }
//    mutating func setThumbnail( UserName:String) {
//        Circle().foregroundColor(Color.blue)
//        for paper in data {
//            if paper.Title == UserName {
//                self.Thumbnail = paper.Thumbnail
//                break
//            }
//        }
//    }
//}

struct ListView1_Previews: PreviewProvider {
    static var previews: some View {
        ListView1().previewDevice("iPhone 13")
    }
}
