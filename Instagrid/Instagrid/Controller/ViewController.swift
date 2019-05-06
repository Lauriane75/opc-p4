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
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeUp.direction = .up
        self.view.addGestureRecognizer(swipeUp)
    }
    
    @objc func handleGesture() {
        print("swipe up")
        // Vérifier que les x photos ont une image
        let finalImage = mergeImages(topLeftImage: topLeftImageView.image, topRightImage: topRightImageView.image, bottomLeftImage: bottomLeftImageView.image, bottomRightImage: bottomRightImageView.image)
        let items = [finalImage]
        let ac = UIActivityViewController(activityItems: items as [Any], applicationActivities: nil)
        present(ac, animated: true)
    }
    
    
    // Button to add photos
    fileprivate func  PhotoPickerController() {
        let myPickerController = UIImagePickerController()
        myPickerController.delegate = self
        myPickerController.sourceType = .photoLibrary
        self.present(myPickerController, animated: true)
        myPickerController.allowsEditing = true
       
    }

    func mergeImages(topLeftImage: UIImage?, topRightImage: UIImage?,
                     bottomLeftImage: UIImage?, bottomRightImage: UIImage?) -> UIImage? {
        let width = CGFloat(topLeftImage?.size.width ?? 0) + CGFloat(topRightImage?.size.width ?? 0)
        let height = CGFloat(topLeftImage?.size.height ?? 0) + CGFloat(bottomLeftImage?.size.height ?? 0)
        let size = CGSize(width: width, height: height)
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        
        topLeftImage?.draw(in: CGRect(x: 0, y: 0, width: size.width, height: topLeftImage?.size.height ?? 0))
        
        topRightImage?.draw(in: CGRect(x: width/2, y:0 , width: width/2, height: topRightImage?.size.height ?? 0))
        
        bottomLeftImage?.draw(in: CGRect(x: 0, y: topLeftImage?.size.height ?? 0, width: width/2, height: bottomLeftImage?.size.height ?? 0))
        
        bottomRightImage?.draw(in: CGRect(x: width/2, y: topLeftImage?.size.height ?? 0, width: width/2, height: bottomRightImage?.size.height ?? 0))
        
        let newImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
    
    
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









