//
//  ViewController.swift
//  Theme
//
//  Created by Dan Ionescu on 25/05/16.
//  Copyright © 2016 Alt Tab. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var linkButton: UIButton!

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!

    @IBOutlet weak var switchThemeLabel: UILabel!

    @IBOutlet weak var demoSwitch: UISwitch!
    @IBOutlet weak var themeStepper: UIStepper!
    
    var themes: [Theme]!

    override func viewDidLoad() {
        super.viewDidLoad()

        themes = [DarkTheme(), DefaultTheme(), PlistTheme(plistName: "ThemeA"), PlistTheme(plistName: "ThemeB")]
        themeStepper.maximumValue = Double(themes.count - 1)

        themeViews()
    }

    func themeViews() {
        let theme = ThemeManager.theme

        view.backgroundColor = theme.colors.BackgroundPrimary

        theme.themeButton(submitButton, style: .Submit)
        theme.themeButton(cancelButton, style: .Cancel)
        theme.themeButton(linkButton, style: .Link)

        theme.themeLabel(titleLabel, textStyle: .Title)
        theme.themeLabel(subtitleLabel, textStyle: .Subtitle)
        theme.themeLabel(bodyLabel, textStyle: .Body)
        theme.themeLabel(switchThemeLabel, textStyle: .Body)
    }

    @IBAction func didTouchStepper(sender: UIStepper) {
        ThemeManager.theme = themes[Int(sender.value) % themes.count]

        UIView.transitionWithView(view,
                                  duration: 0.2,
                                  options: [
                                    .CurveEaseInOut,
                                    .BeginFromCurrentState,
                                    .AllowUserInteraction
            ],
                                  animations: {
                                    let theme = ThemeManager.theme
                                    theme.themeApplication()
                                    self.themeViews()
                                    // this is just a demo, some other mechanism should be used for this
                                    theme.themeSwitch(self.demoSwitch)
                                    theme.themeStepper(self.themeStepper)
            },
                                  completion: nil)

    }
}
