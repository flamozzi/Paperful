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
    
    
    //MARK: - User Profile Model load
    
    func requestCurrentUserProfileModel(UserID: Int, globalData: GlobalData) {
        self.getCurrentUserProfileModel(UserID: UserID) { (isSuccess, result) in
            if isSuccess {
                globalData.currentUserProfile.id = result.id
                globalData.currentUserProfile.nickname = result.nickname
                globalData.currentUserProfile.image = result.image
                globalData.currentUserProfile.intro = result.intro
                globalData.currentUserProfile.num_subscribers = result.num_subscribers
            }
        }
    }
    
    private func getCurrentUserProfileModel(UserID: Int, completion: @escaping (Bool, CurrentUserProfileModel) -> Void) {
        
        let url = "https://api.paperful.co.kr/userprofiles/\(UserID)"
        
        AF.request(url)
            .responseDecodable(of: CurrentUserProfileModel.self) { response in
            guard let result = response.value else { return }
            DispatchQueue.main.async {
                completion(true, result)
            }
        }
    }
}
