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

    @IBOutlet weak var topLeftView: UIView!
    
    @IBOutlet weak var topRightView: UIView!
    @IBOutlet weak var bottomLeftView: UIView!
    @IBOutlet weak var bottomRightView: UIView!
    
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

// To merge the final image for save it then
    func mergeImages(topLeftImage: UIImage?, topRightImage: UIImage?,
                     bottomLeftImage: UIImage?, bottomRightImage: UIImage?) -> UIImage? {
        let width = CGFloat(topLeftImage?.size.width ?? 0) + CGFloat(topRightImage?.size.width ?? 0)
        let height = CGFloat(topLeftImage?.size.height ?? 0) + CGFloat(bottomLeftImage?.size.height ?? 0)
        let size = CGSize(width: width, height: height)
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
 // To declare which image has to be drawing
        // Case Selected1
        var topWidthImage = CGFloat(0)
        var topImage = CGFloat(width/2)
        if topLeftView.isHidden {
            topWidthImage = width
            topImage = 0
        } else {
            topWidthImage = width/2
            topLeftImage?.draw(in: CGRect(x: 0, y: 0, width: topWidthImage, height: topLeftImage?.size.height ?? 0))
        }
        topRightImage?.draw(in: CGRect(x: topImage, y:0, width: topWidthImage, height: topRightImage?.size.height ?? 0))
        // Case Selected2
        var bottomWidthImage = CGFloat(0)
        var bottomImage = CGFloat(width/2)
        if bottomLeftView.isHidden {
            bottomWidthImage = width
            bottomImage = 0
        } else {
            bottomWidthImage = width/2
            bottomLeftImage?.draw(in: CGRect(x: 0, y: bottomLeftImage?.size.height ?? 0, width: bottomWidthImage, height: bottomLeftImage?.size.height ?? 0))
        }
        bottomRightImage?.draw(in: CGRect(x: bottomImage, y:bottomRightImage?.size.height ?? 0, width: bottomWidthImage, height: bottomRightImage?.size.height ?? 0))
        
        let newImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
    func checkImage() {
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
    
    //Layout
    @IBOutlet weak var Layout1: UIImageView!
    @IBOutlet weak var Layout2: UIImageView!
    @IBOutlet weak var Layout3: UIImageView!
    //Selected
    @IBOutlet weak var Selected1: UIImageView!
    @IBOutlet weak var Selected2: UIImageView!
    @IBOutlet weak var Selected3: UIImageView!
    //Buttons
    @IBAction func Button1(_ sender: UIButton) {
        Selected1.isHidden = false
        Selected2.isHidden = true
        Selected3.isHidden = true
        
        topLeftView.isHidden = true
        topRightView.isHidden = false
        bottomLeftView.isHidden = false
        bottomRightView.isHidden = false
        
    }
    @IBAction func Button2(_ sender: UIButton) {
        Selected1.isHidden = true
        Selected2.isHidden = false
        Selected3.isHidden = true
        
        topLeftView.isHidden = false
        topRightView.isHidden = false
        bottomLeftView.isHidden = true
        bottomRightView.isHidden = false
        
    }
    @IBAction func Button3(_ sender: UIButton) {
        Selected1.isHidden = true
        Selected2.isHidden = true
        Selected3.isHidden = false
        
        topLeftView.isHidden = false
        topRightView.isHidden = false
        bottomLeftView.isHidden = false
        bottomRightView.isHidden = false
    
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









