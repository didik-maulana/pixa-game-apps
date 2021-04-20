//
//  TabBarView.swift
//  PixaGame
//
//  Created by Didik on 12/07/20.
//  Copyright © 2020 Codingtive. All rights reserved.
//

import SwiftUI

public struct TabBarView: View {
    private var viewControllers: [UIHostingController<AnyView>]
    private var selectedIndex: Binding<Int>?
    @State private var fallbackSelectedIndex: Int = 0
    
    public init(selectedIndex: Binding<Int>? = nil, @TabBuilder _ views: () -> [Tab]) {
        self.viewControllers = views().map {
            let host = UIHostingController(rootView: $0.view)
            host.tabBarItem = $0.barItem
            return host
        }
        self.selectedIndex = selectedIndex
    }
    
    public var body: some View {
        TabBarController(controllers: viewControllers, selectedIndex: selectedIndex ?? $fallbackSelectedIndex)
            .edgesIgnoringSafeArea(.all)
    }
    
    public struct Tab {
        var view: AnyView
        var barItem: UITabBarItem
    }
}

@_functionBuilder
public struct TabBuilder {
    public static func buildBlock(_ items: TabBarView.Tab...) -> [TabBarView.Tab] {
        items
    }
}

fileprivate struct TabBarController: UIViewControllerRepresentable {
    var controllers: [UIViewController]
    @Binding var selectedIndex: Int

    func makeUIViewController(context: Context) -> UITabBarController {
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = controllers
        tabBarController.delegate = context.coordinator
        tabBarController.selectedIndex = 0
        return tabBarController
    }

    func updateUIViewController(_ tabBarController: UITabBarController, context: Context) {
        tabBarController.selectedIndex = selectedIndex
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UITabBarControllerDelegate {
        var parent: TabBarController

        init(_ tabBarController: TabBarController) {
            self.parent = tabBarController
        }
        
        func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
            if parent.selectedIndex == tabBarController.selectedIndex {
                popToRootOrScrollUp(on: viewController)
            }

            parent.selectedIndex = tabBarController.selectedIndex
        }
        
        private func popToRootOrScrollUp(on viewController: UIViewController) {
            let navController = navigationController(for: viewController)
            let popped = navController?.popToRootViewController(animated: true)
            
            if (popped ?? []).isEmpty {
                let rootViewController = navController?.viewControllers.first ?? viewController
                if let scrollView = firstScrollView(in: rootViewController.view ?? UIView()) {
                    let preservedX = scrollView.contentOffset.x
                    let y = -scrollView.adjustedContentInset.top
                    scrollView.setContentOffset(CGPoint(x: preservedX, y: y), animated: true)
                }
            }
        }
        
        private func navigationController(for viewController: UIViewController) -> UINavigationController? {
            for child in viewController.children {
                if let navController = viewController as? UINavigationController {
                    return navController
                } else if let navController = navigationController(for: child) {
                    return navController
                }
            }
            return nil
        }
        
        public func firstScrollView(in view: UIView) -> UIScrollView? {
            for subview in view.subviews {
                if let scrollView = view as? UIScrollView {
                    return scrollView
                } else if let scrollView = firstScrollView(in: subview) {
                    return scrollView
                }
            }
            return nil
        }
    }
}
