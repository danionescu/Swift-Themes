//
//  Theme.swift
//  Theme
//
//  Created by Dan Ionescu on 25/05/16.
//  Copyright © 2016 Alt Tab. All rights reserved.
//

import UIKit

struct ThemeColors {
    let Primary: UIColor
    let Secondary: UIColor

    let TextDark: UIColor
    let TextLight: UIColor
    let TextDefault: UIColor

    let BackgroundPrimary: UIColor
    let BackgroundSecondary: UIColor

    let CallToAction: UIColor
}

enum FontStyle : String {
    case PrimaryLight, PrimaryRegular, PrimarySemibold, PrimaryBold
    case SecondaryLight, SecondaryRegular, SecondarySemibold, SecondaryBold
}

enum ButtonStyle : String {
    case Submit, Cancel
    case Link
}

enum TextStyle : String {
    case Title, Subtitle
    case Body
}

protocol Theme {
    var colors: ThemeColors {get}

    func themeApplication()

    func font(style: FontStyle, size: CGFloat) -> UIFont
    func styleForTextStyle(textStyle: TextStyle) -> (font: UIFont, color: UIColor)

    func themeButton(button: UIButton, style: ButtonStyle)
    func themeLabel(label: UILabel, textStyle: TextStyle)
    func themeSwitch(switchView: UISwitch)
    func themeStepper(stepper: UIStepper)
}

extension Theme {
    func themeLabel(label: UILabel, textStyle: TextStyle) {
        let style = styleForTextStyle(textStyle)
        label.font = style.font
        label.textColor = style.color
    }

    func themeApplication() {
        UIApplication.sharedApplication().keyWindow?.tintColor = colors.Primary
        themeSwitch(UISwitch.appearance())
        themeStepper(UIStepper.appearance())
    }

    func themeSwitch(switchView: UISwitch) {
        switchView.onTintColor = colors.Primary
    }

    func themeStepper(stepper: UIStepper) {
        stepper.tintColor = colors.Primary
    }
}

class ThemeManager {
    static var theme: Theme = DarkTheme()
}

class DefaultTheme : Theme {

    let colors: ThemeColors

    init() {
        colors = ThemeColors(
            Primary: UIColor(colorLiteralRed: 0, green: 149.0/255.0, blue: 179.0/255.0, alpha: 1),
            Secondary: UIColor.blueColor(),

            TextDark: UIColor(white: 0.4, alpha: 1),
            TextLight: UIColor.lightTextColor(),
            TextDefault: UIColor(white: 0.5, alpha: 1),

            BackgroundPrimary: UIColor(white: 0.99, alpha: 1),
            BackgroundSecondary: UIColor.darkGrayColor(),

            CallToAction: UIColor(colorLiteralRed: 0, green: 149.0/255.0, blue: 179.0/255.0, alpha: 1)
        )
    }

    func font(style: FontStyle, size: CGFloat) -> UIFont {
        var font: UIFont?

        switch style {
        case .PrimaryLight:
            font = UIFont.systemFontOfSize(size, weight: UIFontWeightLight)
        case .PrimaryRegular:
            font = UIFont.systemFontOfSize(size, weight: UIFontWeightRegular)
        case .PrimarySemibold:
            font = UIFont.systemFontOfSize(size, weight: UIFontWeightSemibold)
        case .PrimaryBold:
            font = UIFont.systemFontOfSize(size, weight: UIFontWeightBold)
        case .SecondaryLight:
            font = UIFont(name: "HelveticaNeue-Light", size: size)
        case .SecondaryRegular:
            font = UIFont(name: "HelveticaNeue", size: size)
        case .SecondarySemibold:
            font = UIFont(name: "HelveticaNeue-Medium", size: size)
        case .SecondaryBold:
            font = UIFont(name: "HelveticaNeue-Bold", size: size)
        }

        guard let finalFont = font else {
            return UIFont.systemFontOfSize(size, weight: UIFontWeightRegular)
        }

        return finalFont
    }

    func styleForTextStyle(textStyle: TextStyle) -> (font: UIFont, color: UIColor) {
        var result: (font: UIFont, color: UIColor)
        switch textStyle {
        case .Title:
            result.font = font(.PrimarySemibold, size: 24)
            result.color = colors.Primary
        case .Subtitle:
            result.font = font(.PrimaryRegular, size: 18)
            result.color = colors.TextDark
        case .Body:
            result.font = font(.PrimaryRegular, size: 14)
            result.color = colors.TextDefault
        }

        return result
    }

    func themeButton(button: UIButton, style: ButtonStyle) {
        switch style {
        case .Submit:
            button.setTitleColor(colors.TextLight,
                                 forState: .Normal)
            button.titleLabel?.font = font(.PrimarySemibold, size: 18)
            button.setBackgroundImage(UIImage(named: "blue-button-background"),
                                      forState: .Normal)

        case .Cancel:
            button.setTitleColor(colors.TextDefault,
                                 forState: .Normal)
            button.setTitleColor(colors.TextLight,
                                 forState: .Highlighted)
            button.titleLabel?.font = font(.SecondaryRegular, size: 18)
            button.setBackgroundImage(UIImage(named: "gray-button-background"),
                                      forState: .Normal)


        case .Link:
            button.setTitleColor(colors.CallToAction,
                                 forState: .Normal)
            button.setTitleColor(colors.CallToAction.colorWithAlphaComponent(0.6),
                                 forState: .Highlighted)
            button.titleLabel?.font = font(.PrimaryRegular, size: 18)

        }
    }
}

class DarkTheme : Theme {
    let colors: ThemeColors

    init() {
        colors = ThemeColors(
            Primary: UIColor(colorLiteralRed: 20.0/255.0, green: 169.0/255.0, blue: 199.0/255.0, alpha: 1),
            Secondary: UIColor.blueColor(),

            TextDark: UIColor(white: 0.6, alpha: 1),
            TextLight: UIColor(white: 0.9, alpha: 1),
            TextDefault: UIColor(white: 0.8, alpha: 1),

            BackgroundPrimary: UIColor(white: 0.2, alpha: 1),
            BackgroundSecondary: UIColor.lightGrayColor(),

            CallToAction: UIColor(colorLiteralRed: 0, green: 149.0/255.0, blue: 179.0/255.0, alpha: 1)
        )
    }

    func font(style: FontStyle, size: CGFloat) -> UIFont {
        var font: UIFont?

        switch style {
        case .PrimaryLight:
            font = UIFont.systemFontOfSize(size, weight: UIFontWeightLight)
        case .PrimaryRegular:
            font = UIFont.systemFontOfSize(size, weight: UIFontWeightRegular)
        case .PrimarySemibold:
            font = UIFont.systemFontOfSize(size, weight: UIFontWeightSemibold)
        case .PrimaryBold:
            font = UIFont.systemFontOfSize(size, weight: UIFontWeightBold)
        case .SecondaryLight:
            font = UIFont(name: "HelveticaNeue-Light", size: size)
        case .SecondaryRegular:
            font = UIFont(name: "HelveticaNeue", size: size)
        case .SecondarySemibold:
            font = UIFont(name: "HelveticaNeue-Medium", size: size)
        case .SecondaryBold:
            font = UIFont(name: "HelveticaNeue-Bold", size: size)
        }

        guard let finalFont = font else {
            return UIFont.systemFontOfSize(size, weight: UIFontWeightRegular)
        }

        return finalFont
    }

    func styleForTextStyle(textStyle: TextStyle) -> (font: UIFont, color: UIColor) {
        var result: (font: UIFont, color: UIColor)
        switch textStyle {
        case .Title:
            result.font = font(.PrimarySemibold, size: 24)
            result.color = colors.TextLight
        case .Subtitle:
            result.font = font(.PrimaryRegular, size: 18)
            result.color = colors.TextDark
        case .Body:
            result.font = font(.PrimaryRegular, size: 14)
            result.color = colors.TextDefault
        }

        return result
    }

    func themeButton(button: UIButton, style: ButtonStyle) {
        switch style {
        case .Submit:
            button.setTitleColor(colors.TextLight,
                                 forState: .Normal)
            button.titleLabel?.font = font(.PrimarySemibold, size: 18)
            button.setBackgroundImage(UIImage(named: "blue-button-background"),
                                      forState: .Normal)

        case .Cancel:
            button.setTitleColor(colors.TextDark,
                                 forState: .Normal)
            button.setTitleColor(colors.TextLight,
                                 forState: .Highlighted)
            button.titleLabel?.font = font(.SecondaryRegular, size: 18)
            button.setBackgroundImage(UIImage(named: "gray-button-background"),
                                      forState: .Normal)


        case .Link:
            button.setTitleColor(colors.CallToAction,
                                 forState: .Normal)
            button.setTitleColor(colors.CallToAction.colorWithAlphaComponent(0.6),
                                 forState: .Highlighted)
            button.titleLabel?.font = font(.PrimaryRegular, size: 18)
            
        }
    }
}

class PlistTheme : Theme {

    let colors: ThemeColors
    
    let themeConfiguration: [String : AnyObject]
    let fontsConfigurations: [String : String]

    init(plistName: String) {
        themeConfiguration = NSDictionary(contentsOfFile: NSBundle.mainBundle().pathForResource(plistName, ofType: "plist")!) as! [String: AnyObject]

        let colorsConfigurations = themeConfiguration["Colors"] as! [String: String]

        colors = ThemeColors(
            Primary: UIColor(hexString: colorsConfigurations["Primary"]!),
            Secondary: UIColor(hexString: colorsConfigurations["Secondary"]!),

            TextDark: UIColor(hexString: colorsConfigurations["TextDark"]!),
            TextLight: UIColor(hexString: colorsConfigurations["TextLight"]!),
            TextDefault: UIColor(hexString: colorsConfigurations["TextDefault"]!),

            BackgroundPrimary: UIColor(hexString: colorsConfigurations["BackgroundPrimary"]!),
            BackgroundSecondary: UIColor(hexString: colorsConfigurations["BackgroundSecondary"]!),

            CallToAction: UIColor(hexString: colorsConfigurations["CallToAction"]!)
        )

        fontsConfigurations = themeConfiguration["Fonts"] as! [String: String]

    }

    func font(style: FontStyle, size: CGFloat) -> UIFont {
        guard let fontName = fontsConfigurations[style.rawValue] else {
            return UIFont.systemFontOfSize(size)
        }

        let font: UIFont = UIFont(name: fontName, size: size)!

        return font
    }

    func styleForTextStyle(textStyle: TextStyle) -> (font: UIFont, color: UIColor) {
        var result: (font: UIFont, color: UIColor)
        switch textStyle {
        case .Title:
            result.font = font(.PrimarySemibold, size: 24)
            result.color = colors.Primary
        case .Subtitle:
            result.font = font(.PrimaryRegular, size: 18)
            result.color = colors.TextDark
        case .Body:
            result.font = font(.PrimaryRegular, size: 14)
            result.color = colors.TextDefault
        }

        return result
    }

    func themeButton(button: UIButton, style: ButtonStyle) {
        switch style {
        case .Submit:
            button.setTitleColor(colors.TextLight,
                                 forState: .Normal)
            button.titleLabel?.font = font(.PrimarySemibold, size: 18)
            button.setBackgroundImage(UIImage(named: "blue-button-background"),
                                      forState: .Normal)

        case .Cancel:
            button.setTitleColor(colors.TextDefault,
                                 forState: .Normal)
            button.setTitleColor(colors.TextLight,
                                 forState: .Highlighted)
            button.titleLabel?.font = font(.SecondaryRegular, size: 18)
            button.setBackgroundImage(UIImage(named: "gray-button-background"),
                                      forState: .Normal)


        case .Link:
            button.setTitleColor(colors.CallToAction,
                                 forState: .Normal)
            button.setTitleColor(colors.CallToAction.colorWithAlphaComponent(0.6),
                                 forState: .Highlighted)
            button.titleLabel?.font = font(.PrimaryRegular, size: 18)
            
        }
    }
    
}