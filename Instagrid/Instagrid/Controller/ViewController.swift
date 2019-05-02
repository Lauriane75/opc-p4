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
    
    private var lastImageViewTapped: UIImageView?

    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    // Button to add photos
    fileprivate func  PhotoPickerController() {
        let myPickerController = UIImagePickerController()
        myPickerController.delegate = self
        myPickerController.sourceType = .photoLibrary
        self.present(myPickerController, animated: true)
        myPickerController.allowsEditing = true
       
    }
    //topLeftImageView.image = myButton.imageView!.image
    
    @IBAction func addPhotoTopLeft(_ sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            PHPhotoLibrary.requestAuthorization { (status) in
                switch status {
                case .authorized:
                     self.PhotoPickerController()
                    self.lastImageViewTapped = self.topLeftImageView
                case .notDetermined:
                    if status == PHAuthorizationStatus.authorized{
                         self.PhotoPickerController()
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
                    self.PhotoPickerController()
                    self.lastImageViewTapped = self.topRightImageView
                case .notDetermined:
                    if status == PHAuthorizationStatus.authorized{
                        self.PhotoPickerController()
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
    

    @IBAction func addPhotoBottomLeft(_ sender: AnyObject) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            PHPhotoLibrary.requestAuthorization { (status) in
                switch status {
                case .authorized:
                    self.PhotoPickerController()
                    self.lastImageViewTapped = self.bottomLeftImageView
                case .notDetermined:
                    if status == PHAuthorizationStatus.authorized{
                        self.PhotoPickerController()
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
    @IBAction func addPhotoBottomRight(_ sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            PHPhotoLibrary.requestAuthorization { (status) in
                switch status {
                case .authorized:
                    self.PhotoPickerController()
                    self.lastImageViewTapped = self.bottomRightImageView
                case .notDetermined:
                    if status == PHAuthorizationStatus.authorized{
                        self.PhotoPickerController()
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
    // Top and bottom adding photo in the middle
    @IBAction func addPhotoTop(_ sender: UIButton) {
    }
    @IBAction func addPhotoBottom(_ sender: UIButton) {
    }
    
    //Selected Layout (1, 2 or 3)
    
    @IBAction func selectedLayout1(_ sender: UIButton) {
    }
    
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    internal func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.editedImage] as? UIImage {
            self.lastImageViewTapped?.image = image
        } else if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.lastImageViewTapped?.image = image
        }
        dismiss(animated: true)
    }
    
  
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }
   
}









