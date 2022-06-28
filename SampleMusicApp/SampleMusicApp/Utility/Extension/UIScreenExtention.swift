//
//  UIScreen.swift
//  
//
//  Created by Mayank Jain on 03/01/22.
//

import Foundation
import UIKit

extension UIScreen {
    
    /// Retrieve width
    static var width : CGFloat {
        if self.Orientation.isPortrait {
            return min(UIScreen.main.bounds.height,UIScreen.main.bounds.width)
        }
        else {
            return max(UIScreen.main.bounds.height,UIScreen.main.bounds.width)
        }
    }
    
    static var height : CGFloat {
        if self.Orientation.isPortrait {
            return max(UIScreen.main.bounds.height,UIScreen.main.bounds.width)
        }
        else {
            return min(UIScreen.main.bounds.height,UIScreen.main.bounds.width)
        }
    }
    

    /// Retrieve heigh
   // static var height : CGFloat { return UIScreen.main.bounds.width }
    
    struct Orientation {
        // indicate current device is in the LandScape orientation
        
        static var isLandscape: Bool {
            get {
                return UIDevice.current.orientation.isValidInterfaceOrientation
                    ? UIDevice.current.orientation.isLandscape
                    : UIApplication.shared.statusBarOrientation.isLandscape
            }
        }
        // indicate current device is in the Portrait orientation
        static var isPortrait: Bool {
            get {
                return UIDevice.current.orientation.isValidInterfaceOrientation
                    ? UIDevice.current.orientation.isPortrait
                    : UIApplication.shared.statusBarOrientation.isPortrait
            }
        }
    }

}
