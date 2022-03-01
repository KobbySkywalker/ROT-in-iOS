//
//  ScrollViewContentSize.swift
//  ROTProject
//
//  Created by Hackman Adu Gyamfi on 01/03/2022.
//

import Foundation
import UIKit
extension UIScrollView {
    func scrollViewSizeFit() {
        var contentRect = CGRect.zero
        for view in self.subviews {
            contentRect = contentRect.union(view.frame)
        }
        self.contentSize = contentRect.size
        
    }
    
}
