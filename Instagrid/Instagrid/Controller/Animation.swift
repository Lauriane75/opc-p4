//
//  Animation.swift
//  Instagrid
//
//  Created by Lauriane Haydari on 29/05/2019.
//  Copyright © 2019 Lauriane Haydari. All rights reserved.
//

import UIKit
// Animation swipe back
class Animation {
    func AnimationDone(vc : ViewController) {
        print ("animation done")
        UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options:[] , animations: {
            vc.swipeView.transform = .identity
        } , completion: nil )
    }
}

