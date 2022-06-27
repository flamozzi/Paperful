//
//  ContentView.swift
//  Paperful
//
//  Created by Tony on 2022/04/14.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var globalData: GlobalData
    
    @State private var tabSelection = 1
    @State private var tappedTwice: Bool = false
    
    var body: some View {
        
        var handler: Binding<Int> { Binding(
                get: { self.tabSelection },
                set: {
                    if $0 == self.tabSelection {
                        // Lands here if user tapped more than once
                        tappedTwice = true
                    }
                    self.tabSelection = $0
                }
        )}
        
        return ScrollViewReader { proxy in
            TabView(selection: handler) {
                HomeView()
                    .onChange(of: tappedTwice, perform: { tapped in
                        if tapped {
                            withAnimation {
                                proxy.scrollTo(1)
                            }
                            tappedTwice = false
                        }
                    })
                    .tabItem {
                        Image(systemName: "house")
                    }
                    .tag(1)
                
//                HomeView() // 임시
//                    .tabItem {
//                        Image(systemName: "magnifyingglass")
//                    }
//                    .tag(2)
//
//                HomeView()
//                    .tabItem {
//                        Image(systemName: "book")
//                    }
//                    .tag(3)
//
//                HomeView()
//                    .tabItem {
//                        Image(systemName: "books.vertical")
//                    }
//                    .tag(4)
                
                ProfileView()
                    .onChange(of: tappedTwice, perform: { tapped in
                        if tapped {
                            withAnimation {
                                proxy.scrollTo(1)
                            }
                            tappedTwice = false
                        }
                    })
                    .tabItem {
                        Image(systemName: "person")
                    }
                    .tag(5)
            }
            .onAppear() {
                UITabBar.appearance().barTintColor = .backgroundColor
            }
            .accentColor(.black)
        .onAppear(perform: UIApplication.shared.hideKeyboard)
        }
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
