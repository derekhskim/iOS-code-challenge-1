//
//  AppConstants.swift
//  iOS-code-challenge-1
//
//  Created by Derek Kim on 2023-03-24.
//

import UIKit

struct CheckImages {
    static let unchecked = UIImage(systemName: "square")
    static let checked = UIImage(systemName: "checkmark.square.fill")?.withTintColor(.systemGreen, renderingMode: .alwaysOriginal)
}
