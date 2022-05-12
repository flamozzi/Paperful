//import Foundation
//import Alamofire
//import SwiftUI
//
//class Server {
//  static var homeModels: [HomeModel] = []
//
//  static func getHomeModels(completion: @escaping (Bool, [HomeModel]) -> Void) {
//      let url = "https://api.paperful.co.kr/posts"
//      AF.request(url).responseDecodable(of: Results.self) { response in
//          Server.homeModels.append(response.value!.results)
//          print(type(of: Server.homeModels))
//          print(type(of: response.value!.results))
//
//          DispatchQueue.main.async {
//
//              completion(true, homeModels)
//          }
//
//      }
//  }
//}
