import Foundation
import SwiftUI
import Alamofire


class ThumbnailViewListViewModel: ObservableObject {
    @Published var thumbnailViewList: [ThumbnailView] = []
    
    @Published var page = 0
    
    //MARK: - 전체 글 목록 조회
    
    // 뷰 최상단에서 당겨서 새로고침 (새로운 10개의 썸네일만 받아서 render)
    func reload() {
        self.page = 0
        self.getHomeModels(start: 0) { (isSuccess, homeModels) in
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
    
    // 뷰 최하단에서 올려서 새로고침 (새로운 10개의 썸네일을 추가해서 render)
    // page가 계속해서 증가하지만, 어차피 데이터의 마지막까지 간 후에는 page의 값이 상관없기 때문에, page의 덧셈을 제한할 필요 없음 (데이터가 있다면 로드 할 테니까)
    func loadNextPage(page: Int) {
        moveToNextPage()
        self.getHomeModels(start: page) { (isSuccess, homeModels) in
            if isSuccess {
                for homeModel in homeModels {
                    let thumbnailView: ThumbnailView = .init()
                    thumbnailView.thumbnailViewModel.changeHomeModel(homeModel: homeModel)
                    self.thumbnailViewList.append(thumbnailView)
                }
            }
        }
    }
    
    func moveToNextPage() {
        self.page += 10
    }

    
    private func getHomeModels(start: Int, completion: @escaping (Bool, [HomeModel]) -> Void) {
        
        let url = "https://api.paperful.co.kr/posts?limit=10&start=\(start)"
        
        AF.request(url)
            .responseDecodable(of: Results.self) { response in
            guard let result = response.value else { return }
            DispatchQueue.main.async {
                completion(true, result.results)
            }
        }
    }
}
