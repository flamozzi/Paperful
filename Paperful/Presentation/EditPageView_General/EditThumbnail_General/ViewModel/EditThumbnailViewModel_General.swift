//
//  EditThumbnailViewModel_General.swift
//  Paperful

import Foundation
import SwiftUI


class EditThumbnailViewModel_General: ObservableObject {
    @Published var thumbnailView: ThumbnailView = .init()
    var homeModel: HomeModel = .init()
    
    func setThumbnail(title: String, thumbnail: String) {
        self.setHomeModel(title: title, thumbnail: thumbnail)
        self.thumbnailView.thumbnailViewModel.changeHomeModel(homeModel: self.homeModel)
    }
    
    func setHomeModel(title: String, thumbnail: String) {
        self.homeModel.title = title
        self.homeModel.thumbnail = thumbnail
    }
}
