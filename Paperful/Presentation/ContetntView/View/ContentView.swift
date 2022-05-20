//
//  ContentView.swift
//  Paperful
//
//  Created by Tony on 2022/04/14.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var editContentViewModel: EditContentViewModel
    
    var body: some View {
        
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "house")
                }
            EditTitleView() // 임시
                .tabItem {
                    Image(systemName: "magnifyingglass")
                }
            HomeView()
                .tabItem {
                    Image(systemName: "book")
                }
            HomeView()
                .tabItem {
                    Image(systemName: "books.vertical")
                }
            MyPaperView()
                .tabItem {
                    Image(systemName: "person")
                }
        }
        .onAppear() {
            UITabBar.appearance().barTintColor = .backgroundColor
        }
        .accentColor(.black)
    }
}

struct TabBarAccessor: UIViewControllerRepresentable {
    var callback: (UITabBar) -> Void
    private let proxyController = ViewController()

    func makeUIViewController(context: UIViewControllerRepresentableContext<TabBarAccessor>) ->
                              UIViewController {
        proxyController.callback = callback
        return proxyController
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<TabBarAccessor>) {
    }

    typealias UIViewControllerType = UIViewController

    private class ViewController: UIViewController {
        var callback: (UITabBar) -> Void = { _ in }

        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            if let tabBar = self.tabBarController {
                self.callback(tabBar.tabBar)
            }
        }
    }
}


//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
