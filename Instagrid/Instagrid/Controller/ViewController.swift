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
    @IBOutlet weak var bottomRightImageView: UIImageView!
// Top & Bottom
    @IBOutlet weak var topImageView: UIImageView!
    @IBOutlet weak var bottomImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // Button to add photos
    fileprivate func  presentPhotoPickerController() {
        let myPickerController = UIImagePickerController()
        myPickerController.delegate = self
        myPickerController.sourceType = .photoLibrary
        self.present(myPickerController, animated: true)
    }
    
    @IBAction func addPhotoTopLeft(_ sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            PHPhotoLibrary.requestAuthorization { (status) in
                switch status {
                case .authorized:
                     self.presentPhotoPickerController()
                case .notDetermined:
                    if status == PHAuthorizationStatus.authorized{
                         self.presentPhotoPickerController()
                    }
                case .restricted:
                    let alert = UIAlertController(title: "Photo library restricted", message: "Photo library acces is restriced and can't be accessed", preferredStyle: .alert)
                    let okAction = UIAlertAction(title : "OK", style: .default)
                    alert.addAction(okAction)
                    self.present(alert, animated: true)
                case .denied:
                    let alert = UIAlertController(title: "Photo library denied", message: "Photo library acces was denied and can't be accessed. Please update your settings  if You want to change it", preferredStyle: .alert)
                    let goToSettings = UIAlertAction(title : "Go to your settings", style: .default) { (action) in
                        DispatchQueue.main.async {
                            let url = URL(string: UIApplication.openSettingsURLString)!
                            UIApplication.shared.open(url, options:[:])
                        }
                    }
                let cancelAction = UIAlertAction(title:"Cancel", style: .cancel )
                alert.addAction(goToSettings)
                alert.addAction(cancelAction)
                self.present(alert, animated: true)
                default:break
                    
                }
            }
        }
    }
    
    @IBAction func addPhotoTopRight(_ sender: UIButton) {
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
    @IBAction func addPhotoBottomLeft(_ sender: UIButton) {
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
    @IBAction func addPhotoBottomRight(_ sender: UIButton) {
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
            self.topRightImageView.image = image
            self.bottomLeftImageView.image = image
            self.bottomRightImageView.image = image
        }
        dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }
   
}









