import Foundation
import SwiftUI
import Alamofire


class ProfileViewModel: ObservableObject {
    @Published var postList: PostListModel = .init()
    @Published var thumbnailViewList: [ThumbnailView] = []
    
    func requestPostList(UserID: Int) {
        self.getPostListModel(UserID: UserID, url: nil) { (isSuccess, result) in
            if isSuccess {
                self.thumbnailViewList.removeAll()
                for post in result.results {
                    let thumbnailView: ThumbnailView = .init()
                    thumbnailView.thumbnailViewModel.changeHomeModel(post: post)
                    self.thumbnailViewList.append(thumbnailView)
                }
            }
        }
    }
    
    func requestNextPostList(UserID: Int) {
        self.getPostListModel(UserID: UserID, url: self.postList.next) { (isSuccess, result) in
            if isSuccess && self.postList.next != nil {
                for post in result.results {
                    let thumbnailView: ThumbnailView = .init()
                    thumbnailView.thumbnailViewModel.changeHomeModel(post: post)
                    self.thumbnailViewList.append(thumbnailView)
                }
                self.postList.next = result.next
            }
        }
    }
    
    func requestPostListModel(UserID: Int) {
        self.getPostListModel(UserID: UserID, url: nil) { (isSuccess, result) in
            if isSuccess {
                self.postList = result
            }
        }
    }
    
    private func getPostListModel(UserID: Int, url: String?, completion: @escaping (Bool, PostListModel) -> Void) {
        
        let url = url ?? "https://api.paperful.co.kr/userprofiles/\(UserID)/posts"
        
        AF.request(url)
            .responseDecodable(of: PostListModel.self) { response in
            guard let result = response.value else { return }
            DispatchQueue.main.async {
                completion(true, result)
            }
        }
    }
}
