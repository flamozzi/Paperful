import SwiftUI
import Foundation
import Combine

class ThumbnailViewModel: ObservableObject, Identifiable{
    
    var homeModel: HomeModel
    
    init(homeModel: HomeModel) {
        self.homeModel = homeModel
    }
    
    func getImage() -> String {
        return "paperfulTestImage"
    }
    
    func getTitle() -> String {
        //        if homeModel != nil {
        //            return homeModel.title
        //        }
        //        return ""
        return homeModel.title
    }
    
    func getWriterNickname() -> String {
        //        if homeModel != nil {
        //            return homeModel.writer.nickname
        //        }
        //        return ""
        return homeModel.writer.nickname
    }
    
    func getIntro() -> String {
        //        if homeModel != nil {
        //            return homeModel.intro
        //        }
        //        return ""
        return homeModel.intro
    }
    
}

//
//}
//
//
////import SwiftUI
////import Combine
////
////struct TestView: View {
////    @ObservedObject var vm: ViewModel = .init(usecase: <#T##UseCase#>)
////
////    var body: some View {
////        Text("\(vm.textFromServer)")
////    }
////}
////
////extension TestView {
////    class ViewModel: ObservableObject {
////        var usecase: UseCase
////        @Published private(set) var textFromServer: String = ""
////
////        init(usecase: UseCase) {
////            self.usecase = usecase
////        }
////
////        func fetch() {
////
////        }
////    }
////}
////
////
////// dependency inversion
////protocol UseCase {
////    func fetchText() -> String
////}
////
////struct RealUseCase: UseCase {
////    func fetchText() -> String {
////        URLSession~~~
////    }
////}
////
////struct MockUseCase: UseCase {
////    func fetchText() -> String {
////        "hello it's test"
////    }
////}
