//
//  ViewController.swift
//  Instagrid
//
//  Created by Lauriane Haydari on 03/04/2019.
//  Copyright © 2019 Lauriane Haydari. All rights reserved.
//

import UIKit
import Photos

class ViewController: UIViewController {
    //Main Layout
    @IBOutlet weak var topLeftImageView: UIImageView!
    @IBOutlet weak var topRightImageView: UIImageView!
    @IBOutlet weak var bottomLeftImageView: UIImageView!
    @IBOutlet weak var bottomRightImageView: UIView!
    @IBOutlet weak var topRightView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // Button to add photos
    @IBAction func addPhotoTopLeft(_ sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            PHPhotoLibrary.requestAuthorization { (status) in
                switch status {
                case .authorized:
                    let myPickerController = UIImagePickerController()
                    myPickerController.delegate = self
                    myPickerController.sourceType = .photoLibrary
                    self.present(myPickerController, animated: true)
                default:break
                }
            }
        }
    }
    
    @IBAction func addPhotoTopRight(_ sender: UIButton) {
    }
    @IBAction func addPhotoBottomLeft(_ sender: UIButton) {
    }
    @IBAction func addPhotoBottomRight(_ sender: UIButton) {
    }
    // Top and bottom adding photo in the middle
    @IBAction func addPhotoTop(_ sender: UIButton) {
    }
    @IBAction func addPhotoBottom(_ sender: Any) {
    }
    
    //Selected Layout (1, 2 or 3)
    
    @IBAction func selectedLayout1(_ sender: UIButton) {
    }
    
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    internal func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.topLeftImageView.image = image
        }
        dismiss(animated: true)
    }
}







