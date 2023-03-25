//
//  UIColor+.swift
//  iOS-code-challenge-1
//
//  Created by Derek Kim on 2023-03-24.
//

import UIKit

enum LPColor: String {
    case LPYellow
    case LPTextGray
    case LPVoidWhite
}

extension UIColor {
    static func appColor(_ name: LPColor) -> UIColor! {
        return UIColor(named: name.rawValue)
    }
}
