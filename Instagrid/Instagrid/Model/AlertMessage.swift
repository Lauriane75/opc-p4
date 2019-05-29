//
//  CheckSelected.swift
//  Instagrid
//
//  Created by Lauriane Haydari on 29/05/2019.
//  Copyright © 2019 Lauriane Haydari. All rights reserved.
//

import UIKit
// Alert if an image is missing in the grid before saving
class AlertMessage {
    func missingImageAlert(vc : ViewController) {
        let imageAlert = UIAlertController(title: "⚠️ You must complete the grid with missing images to share it!", message: "", preferredStyle: .alert)
        imageAlert.addAction(UIAlertAction(title: "Got it 👍", style: .default))
        vc.present(imageAlert, animated: true)
    }
    
 
    
}
