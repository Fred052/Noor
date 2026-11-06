//
//  UIFont+App.swift
//  Noor
//
//  Created by Ferid Suleymanzade on 04.11.26.
//
import UIKit

extension UIFont {
    
    static func newsReader(_ size: CGFloat) -> UIFont {
        return UIFont(name: "Newsreader-Medium", size: size) ?? UIFont.systemFont(ofSize: size)
    }
}
