import Foundation
import SwiftUI
import Alamofire


class DetailViewModel_General: ObservableObject {
    @Published var postModel: PostModel = .init()

    var object_type: String {
        return postModel.object_type
    }

    var id: Int {
        return postModel.id
    }

    var title: String {
        return postModel.title
    }

    var writerNickname: String {
        return postModel.writer.nickname
    }

    var content: String {
        return postModel.content
    }

    var status: String {
        return postModel.status
    }

    var create_at: String {
        return postModel.create_at
    }

    var update_at: String {
        return postModel.update_at
    }

    // MARK: - request api를 통해 새로운 값을 받아서 기존의 property 들의 값을 바꿈
    func changePostModel(postModel: PostModel) {
        self.postModel.object_type = postModel.object_type
        self.postModel.id = postModel.id
        self.postModel.title = postModel.title
        self.postModel.writer.nickname = postModel.writer.nickname
        self.postModel.content = postModel.content
        self.postModel.status = postModel.status
        self.postModel.create_at = postModel.create_at
        self.postModel.update_at = postModel.update_at
    }
    
    //MARK: - Detail View 관련
    
    func loadPost(postID: Int) {
        self.getPostModel(postID: postID) { (isSuccess, response) in
            if isSuccess {
                self.changePostModel(postModel: response)
            }
        }
    }
    
    private func getPostModel(postID: Int, completion: @escaping (Bool, PostModel) -> Void) {
        
        let url = "https://api.paperful.co.kr/posts/\(postID)"
        
        AF.request(url)
            .responseDecodable(of: PostModel.self) { response in
                guard let result = response.value else { return }
                DispatchQueue.main.async {
                    completion(true, result)
                }
            }
    }
}
