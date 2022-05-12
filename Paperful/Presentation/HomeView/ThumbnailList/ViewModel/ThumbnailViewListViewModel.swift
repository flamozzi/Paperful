import Foundation
import SwiftUI
import Alamofire


class ThumbnailViewListViewModel: ObservableObject {
    @Published var thumbnailViewList: [ThumbnailView] = []
    
    // 뷰 최상단에서 당겨서 새로고침 (새로운 10개의 썸네일만 받음)
    func reload() {
        self.getHomeModels { (isSuccess, homeModels) in
            if isSuccess {
                self.thumbnailViewList.removeAll()
                for homeModel in homeModels {
                    let thumbnailView: ThumbnailView = .init()
                    thumbnailView.thumbnailViewModel.changeHomeModel(homeModel: homeModel)
                    self.thumbnailViewList.append(thumbnailView)
                }
            }
        }
    }
    
    private func getHomeModels(completion: @escaping (Bool, [HomeModel]) -> Void) {
        
        let url = "https://api.paperful.co.kr/posts"
        
        AF.request(url).responseDecodable(of: Results.self) { response in
            guard let result = response.value else { return }
            DispatchQueue.main.async {
                completion(true, result.results)
            }
            
        }
    }
}
