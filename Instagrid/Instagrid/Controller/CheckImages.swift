//
//  CheckImages.swift
//  Instagrid
//
//  Created by Lauriane Haydari on 16/05/2019.
//  Copyright © 2019 Lauriane Haydari. All rights reserved.
//

import Foundation

class CheckImages{
    
    var viewC = ViewController()
    enum SelectedCase{
        case selected1, selected2, selected3
    }
    
    var select : SelectedCase = .selected3 {
        didSet {
            selectedStyle(select)
        }
    }
    
    func selectedStyle(_ select: SelectedCase) {
        if viewC.topRightImageView.image != nil && viewC.bottomLeftImageView.image != nil && viewC.bottomRightImageView.image != nil {
            //
            self.select = .selected1
        } else if viewC.topLeftImageView.image != nil && viewC.topRightImageView.image != nil && viewC.bottomRightImageView.image != nil {
            self.select = .selected2
        } else if viewC.topLeftImageView.image != nil && viewC.topRightImageView.image != nil && viewC.bottomLeftImageView.image != nil && viewC.bottomRightImageView.image != nil {
            self.select = .selected3
        }
    }
    
    func checkImageSelected(_ select: SelectedCase){
        if select == .selected1 {
            print ("Selected1 OK")
        } else {
            print ("Selected1 not OK")
        }
    }
    
}

