//
//  UIImage+Ext.swift
//  Noor
//
//  Created by Ferid Suleymanzade on 19.11.26.
//

import UIKit

extension UIImage {
    func resized(to size: CGSize) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: size)
        let image = renderer.image { _ in
            let scale = min(size.width / self.size.width,
                            size.height / self.size.height)
            let width = self.size.width * scale
            let height = self.size.height * scale
            let rect = CGRect(x: (size.width - width) / 2,
                              y: (size.height - height) / 2,
                              width: width,
                              height: height)
            draw(in: rect)
        }
        return image.withRenderingMode(.alwaysTemplate)
    }
}
