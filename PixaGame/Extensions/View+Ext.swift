//
//  View+Ext.swift
//  PixaGame
//
//  Created by Didik on 12/07/20.
//  Copyright © 2020 Codingtive. All rights reserved.
//

import SwiftUI
import UIKit

extension View {
    func cornerRadius(radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
    
    public func tab(title: String, image: String? = nil, selectedImage: String? = nil, badgeValue: String? = nil) -> TabBarView.Tab {
        
        func imageOrSystemImage(named: String?) -> UIImage? {
            guard let name = named else { return nil }
            return UIImage(named: name) ?? UIImage(systemName: name)
        }
        
        let image = imageOrSystemImage(named: image)
        let selectedImage = imageOrSystemImage(named: selectedImage)
        let barItem = UITabBarItem(title: title, image: image, selectedImage: selectedImage)
        
        barItem.badgeValue = badgeValue
        
        return TabBarView.Tab(view: AnyView(self), barItem: barItem)
    }
}
