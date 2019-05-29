//
//  Animate.swift
//  Instagrid
//
//  Created by Lauriane Haydari on 28/05/2019.
//  Copyright © 2019 Lauriane Haydari. All rights reserved.
//

import UIKit

class Title {
    
    func animateAppName(label: UILabel) {
        label.text = ""
        let appName = "Instagrid"
        for character in appName {
            if let labelText = label.text {
                label.text = labelText + "\(character )"
            }
            RunLoop.current.run(until : Date()+0.1)
        }
    }
    
} // end
