//
//  UIFont+Extention.swift
//  SampleMusicApp
//
//  Created by Mayank Jain on 27/06/22.
//

import UIKit

extension UIFont {

    public enum SFProTextType: String {
        
        case semibold   = "SFProText-Semibold"
        case regular    = "SFProText-Regular"
        case bold       = "SFProText-Bold"
        case medium     = "SFProText-Medium"
    }

    static func SFProText(_ type: SFProTextType = .regular, size: CGFloat = UIFont.systemFontSize) -> UIFont {
        
        return UIFont(name: "\(type.rawValue)", size: size) ?? UIFont.systemFont(ofSize: size)
    }
}

