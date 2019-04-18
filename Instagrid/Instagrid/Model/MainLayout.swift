//
//  main-grid.swift
//  Instagrid
//
//  Created by Lauriane Haydari on 06/04/2019.
//  Copyright © 2019 Lauriane Haydari. All rights reserved.
//

import Foundation
import UIKit
import Photos
// On écrit la logique ici
class MainLayout {
    let id: UUID
    var title: String
    var image: UIImage?
    
    init(title: String, image: UIImage? = nil){
        id = UUID()
        self.title = title
        self.image = image
    }
    
    enum SelectedStyle {
        case selected1, selected2, selected3
    }
    
  /*
    var selected : SelectedStyle = .selected1 {
        didSet {
            setSelected(style)
        }
    }
    
  private func setSelected(_ style: SelectedStyle){
        switch style {
        case .selected1:
            icon.image = UIImage(named: "selected-1")
            icon.isHidden = false
            icon.image = UIImage(named: "selected-2")
            icon.isHidden = true
            icon.image = UIImage(named: "selected-2")
            icon.isHidden = false
            
            icon.image = UIImage(named: "TopLeftView")
            icon.isHidden = true
            icon.image = UIImage(named: "TopRightView")
            icon.isHidden = false
            icon.image = UIImage(named: "BottomLeftView")
            icon.isHidden = true
            icon.image = UIImage(named: "BottomRightView")
            icon.isHidden = false
        case .selected2:
        case .selected3:
        }
    }
*/
    
}



