//
//  UILabel+Ext.swift
//  Noor
//
//  Created by Ferid Suleymanzade on 17.11.26.
//

import UIKit

extension UILabel {
    func setSpacedText(_ text: String, size: CGFloat, kern: CGFloat) {
        attributedText = NSAttributedString(string: text.uppercased(), attributes: [
            .font: UIFont.systemFont(ofSize: size, weight: .semibold),
            .foregroundColor: UIColor.muted,
            .kern: kern
        ])
    }
}
