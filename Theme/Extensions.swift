//
//  Extensions.swift
//  Theme
//
//  Created by Dan Ionescu on 26/05/16.
//  Copyright © 2016 Alt Tab. All rights reserved.
//

import UIKit

extension UIColor {
    /**
     @see http://stackoverflow.com/a/27203691/2765076

     - parameter hexString:

     - returns:
     */

    convenience init(hexString: String) {
        var hexStringProcessed = hexString
        if( hexStringProcessed.hasPrefix("#") ) {
            hexStringProcessed = hexStringProcessed.substringFromIndex(hexStringProcessed.startIndex.advancedBy(1))
        }

        var hex: UInt32 = 0;
        NSScanner(string: hexStringProcessed).scanHexInt(&hex)

        self.init(
            colorLiteralRed: Float((hex & 0xFF0000) >> 16) / 255.0,
            green: Float((hex & 0x00FF00) >> 8) / 255.0,
            blue: Float(hex & 0x0000FF) / 255.0,
            alpha: 1)
    }
}