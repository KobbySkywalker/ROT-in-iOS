//
//  CustomTextView.swift
//  ROTProject
//
//  Created by Hackman Adu Gyamfi on 01/03/2022.
//

import Foundation
import UIKit

class CustomTextView:UITextView{
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
    }
    
    init(){
        super.init(frame: CGRect.zero, textContainer: nil)
        layer.cornerRadius = 5
        layer.borderWidth = 0.35
        backgroundColor = .white
        textColor = .black.withAlphaComponent(0.85)
        font = UIFont.preferredFont(forTextStyle: .headline)
        contentInset = UIEdgeInsets(top: 16, left: 11, bottom: 16, right: 11)
        layer.borderColor = UIColor.systemGray.withAlphaComponent(0.65).cgColor
        isScrollEnabled = false
    }
}



