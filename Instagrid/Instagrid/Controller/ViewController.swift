//
//  ViewController.swift
//  Instagrid
//
//  Created by Lauriane Haydari on 03/04/2019.
//  Copyright © 2019 Lauriane Haydari. All rights reserved.
//

import UIKit
import Photos

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    // Swipe label
    @IBOutlet weak var swipeLabel: UILabel!
    // Main Layout
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
    // Changes orientation screen display
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animate(alongsideTransition: { context in
            if UIApplication.shared.statusBarOrientation.isPortrait {
                self.swipeLabel.text = "Swipe up to share"
            } else {
                self.swipeLabel.text = "Swipe left to share"
            }
        })
    }

    
    // To save the grid with UIActivityViewController
    @objc func handleGesture() {
        print("swipe up")
       // check()
        // Vérifier que les x photos ont une image
        let finalImage = mergeImages(topLeftImage: topLeftImageView.image, topRightImage: topRightImageView.image, bottomLeftImage: bottomLeftImageView.image, bottomRightImage: bottomRightImageView.image)
        let items = [finalImage]
        let ac = UIActivityViewController(activityItems: items as [Any], applicationActivities: nil)
        present(ac, animated: true)
    }
    

    /// To merge the final image for save it then
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
    
    fileprivate func restrictedCase() {
        let alert = UIAlertController(title: "Photo library restricted", message: "Photo library acces is restriced and can't be accessed", preferredStyle: .alert)
        let okAction = UIAlertAction(title : "OK", style: .default)
        alert.addAction(okAction)
        self.present(alert, animated: true)
    }
    
    fileprivate func notDeterminedCase(_ status: PHAuthorizationStatus) {
        if status == PHAuthorizationStatus.authorized{
            self.PhotoPickerController()
        }
    }
    
    fileprivate func deniedCase(){
        let alert = UIAlertController(title: "Photo library denied", message: "Photo library acces was denied and can't be accessed. Please update your settings if you want to change it", preferredStyle: .alert)
        let goToSettings = UIAlertAction(title : "Go to your settings", style: .default) { (action) in
            DispatchQueue.main.async {
                let url = URL(string: UIApplication.openSettingsURLString)!
                UIApplication.shared.open(url, options:[:])
            }
        }
        let cancelAction = UIAlertAction(title:"Cancel", style: .cancel)
        alert.addAction(goToSettings)
        alert.addAction(cancelAction)
        self.present(alert, animated: true)
    }
    
    // To pick of media
    internal func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
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
    
    // func to add photos
    //=> PhotoLibrary acces and allow editing
    // Sources : https://www.youtube.com/watch?v=soj3gqW9r4Y
    // Sources : https://www.youtube.com/watch?v=q_mjLR0-5K8
    fileprivate func  PhotoPickerController() {
        let myPickerController = UIImagePickerController()
        myPickerController.delegate = self
        myPickerController.sourceType = .photoLibrary
        self.present(myPickerController, animated: true)
        myPickerController.allowsEditing = true
        
    }
    
    
    @IBAction func addPhotoTopLeft(_ sender: UIButton) {let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        let actionSheet = UIAlertController(title: "photo source", message: "choose a source", preferredStyle: .actionSheet)
        // Camera access
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action:UIAlertAction) in
            if UIImagePickerController.isSourceTypeAvailable(.camera){
                imagePickerController.sourceType = .camera
                self.present(imagePickerController, animated: true, completion: nil)
            }else{
                print ("Camera not available")
            }
        }))
        // Photo Library access
        actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (action:UIAlertAction) in
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
                PHPhotoLibrary.requestAuthorization { (status) in
                    switch status {
                    case .authorized:
                        self.PhotoPickerController()
                        self.lastImageViewTapped = self.topLeftImageView
                    case .notDetermined:
                        self.notDeterminedCase(status)
                    case .restricted:
                        self.restrictedCase()
                    case .denied:
                        self.deniedCase()
                    default:break
                        
                    }
                }
            }
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler:nil))
        self.present(actionSheet, animated: true, completion: nil)
    }

    @IBAction func addPhotoTopRight(_ sender: UIButton) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        let actionSheet = UIAlertController(title: "photo source", message: "choose a source", preferredStyle: .actionSheet)
        // Camera access
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action:UIAlertAction) in
            if UIImagePickerController.isSourceTypeAvailable(.camera){
                imagePickerController.sourceType = .camera
                self.present(imagePickerController, animated: true, completion: nil)
            }else{
                print ("Camera not available")
            }
        }))
        // Photo Library access
        actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (action:UIAlertAction) in
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
                PHPhotoLibrary.requestAuthorization { (status) in
                    switch status {
                    case .authorized:
                        self.PhotoPickerController()
                        self.lastImageViewTapped = self.topRightImageView
                    case .notDetermined:
                        self.notDeterminedCase(status)
                    case .restricted:
                        self.restrictedCase()
                    case .denied:
                        self.deniedCase()
                    default:break
                        
                    }
                }
            }
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler:nil))
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    @IBAction func addPhotoBottomLeft(_ sender: UIButton) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        let actionSheet = UIAlertController(title: "photo source", message: "choose a source", preferredStyle: .actionSheet)
        // Camera access
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action:UIAlertAction) in
            if UIImagePickerController.isSourceTypeAvailable(.camera){
                imagePickerController.sourceType = .camera
                self.present(imagePickerController, animated: true, completion: nil)
            }else{
                print ("Camera not available")
            }
        }))
        // Photo Library access
        actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (action:UIAlertAction) in
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
                PHPhotoLibrary.requestAuthorization { (status) in
                    switch status {
                    case .authorized:
                        self.PhotoPickerController()
                        self.lastImageViewTapped = self.bottomLeftImageView
                    case .notDetermined:
                        self.notDeterminedCase(status)
                    case .restricted:
                        self.restrictedCase()
                    case .denied:
                        self.deniedCase()
                    default:break
                        
                    }
                }
            }
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler:nil))
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    @IBAction func addPhotoBottomRight(_ sender: UIButton) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        let actionSheet = UIAlertController(title: "photo source", message: "choose a source", preferredStyle: .actionSheet)
        // Camera access
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action:UIAlertAction) in
            if UIImagePickerController.isSourceTypeAvailable(.camera){
                imagePickerController.sourceType = .camera
                self.present(imagePickerController, animated: true, completion: nil)
            }else{
                print ("Camera not available")
            }
        }))
        // Photo Library access
        actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (action:UIAlertAction) in
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
                PHPhotoLibrary.requestAuthorization { (status) in
                    switch status {
                    case .authorized:
                        self.PhotoPickerController()
                        self.lastImageViewTapped = self.bottomRightImageView
                    case .notDetermined:
                        self.notDeterminedCase(status)
                    case .restricted:
                        self.restrictedCase()
                    case .denied:
                        self.deniedCase()
                    default:break
                    
                    }
                }
            }
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler:nil))
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    

    
    //Layout
    @IBOutlet weak var Layout1: UIImageView!
    @IBOutlet weak var Layout2: UIImageView!
    @IBOutlet weak var Layout3: UIImageView!
    //Selected
    @IBOutlet weak var Selected1: UIImageView!
    @IBOutlet weak var Selected2: UIImageView!
    @IBOutlet weak var Selected3: UIImageView!
    
    
  
    enum SelectedCase{
        case selected1, selected2, selected3
    }
    
    var select : SelectedCase = .selected3 {
        didSet {
        }
    }
    
 
    //Buttons
    @IBAction func Button1(_ sender: UIButton) {
        select = .selected1
        Selected1.isHidden = false
        Selected2.isHidden = true
        Selected3.isHidden = true
        
        topLeftView.isHidden = true
        topRightView.isHidden = false
        bottomLeftView.isHidden = false
        bottomRightView.isHidden = false
        
    }
    @IBAction func Button2(_ sender: UIButton) {
        select = .selected2
        Selected1.isHidden = true
        Selected2.isHidden = false
        Selected3.isHidden = true
        
        topLeftView.isHidden = false
        topRightView.isHidden = false
        bottomLeftView.isHidden = true
        bottomRightView.isHidden = false
        
    }
    @IBAction func Button3(_ sender: UIButton) {
        select = .selected3
        Selected1.isHidden = true
        Selected2.isHidden = true
        Selected3.isHidden = false
        
        topLeftView.isHidden = false
        topRightView.isHidden = false
        bottomLeftView.isHidden = false
        bottomRightView.isHidden = false
    }

} // End of class









