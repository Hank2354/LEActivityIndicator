//
//  LEEntities.swift
//  LEActivityIndicator
//
//  Created by Vladislav Mashkov on 06.02.2022.
//

import UIKit

/**
 This enum contains all activity indicators styles
 
 The "LEActivityIndicators" library contains 8 styles for displaying the indicator, you can see the styles in the [official github](https://github.com/Hank2354/EAActivityIndicator) of the library
 
 **Vatiants:**
 
 - **walking**: Three lines that expand in turn, creating a transition effect between them
 
 - **spinner**: A round indicator, inside of which there is a line occupying a quarter of a circle, which rotates along the edge of the indicator
 
 - **gradient**: A circular indicator that contains a gradient that spreads around the circle of the indicator
 
 - **cube**: Indicator in the form of a cube that bounces and spins around itself
 
 - **wave**: A circular indicator containing a sinusoidal line that scrolls to the right indefinitely
 
 - **bouble**: Round indicator that contracts and expands
 
 - **line**: a linear indicator, inside which a small line moves to the right and to the left
 
 - **???**: Some description

 */
enum LEActivityStyle {
    case walking
    case spinner
    case cube
    case wave
    case bouble
    case line
}

/**
 This enum contains size options for indicators.
 
 All activity indicators in this library can take one of three size settings
 
 **Vatiants:**
 
 - `small`: Size 30x30
 - `medium`: Size 50x50
 - `large`: Size 70x70
 
  - Note: Indicator sizes are set using this setting and are immutable, setting new sizes using constraints will break the display on the screen, and will not help change the size of the indicator
 */
enum LEActivitySize {
    case small
    case medium
    case large
    
    func getCurrentSize() -> CGSize {
        switch self {
        case .small:
            return CGSize(width: 30, height: 30)
        case .medium:
            return CGSize(width: 50, height: 50)
        case .large:
            return CGSize(width: 70, height: 70)
        }
    }
}

/**
 This is your LEActivityColorSet quick documentation.
 
 All activity indicators in this library uses 2 or 3 colors
 
 Sometimes you want numbered lists:

 1. mainColor                  - `Main color for indicator`
 2. secondMainColor      - `Second color for indicator`
 3. complementaryColor - `Complementary color for indicator (optional)`

 **Notes:**
 1. If `complementaryColor` parameter equal nil, for indicator where use three colors in palete will be set main color instead complementary
*/
struct LEActivityColorSet {
    let mainColor:          UIColor
    let secondMainColor:    UIColor
    let complementaryColor: UIColor?
}

