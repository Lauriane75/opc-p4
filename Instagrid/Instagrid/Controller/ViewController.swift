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
    // Swipe view
    @IBOutlet weak var swipeView: UIStackView!
    // Swipe label
    @IBOutlet weak var swipeLabel: UILabel!
    // UIImageView topLeft / topRight / bottomLeft / bottomRight
    @IBOutlet weak var topLeftImageView: UIImageView!
    @IBOutlet weak var topRightImageView: UIImageView!
    @IBOutlet weak var bottomLeftImageView: UIImageView!
    @IBOutlet weak var bottomRightImageView: UIImageView!
    // Top & Bottom large UIImageView
    @IBOutlet weak var topImageView: UIImageView!
    @IBOutlet weak var bottomImageView: UIImageView!
    // UIView topLeft / topRight / bottomLeft / bottomRight
    @IBOutlet weak var topLeftView: UIView!
    @IBOutlet weak var topRightView: UIView!
    @IBOutlet weak var bottomLeftView: UIView!
    @IBOutlet weak var bottomRightView: UIView!
    //Layout 1 / 2 / 3
    @IBOutlet weak var layout1: UIImageView!
    @IBOutlet weak var layout2: UIImageView!
    @IBOutlet weak var layout3: UIImageView!
    //Selected 1 / 2 / 3
    @IBOutlet weak var selected1: UIImageView!
    @IBOutlet weak var selected2: UIImageView!
    @IBOutlet weak var selected3: UIImageView!
    // vertical stack view
    @IBOutlet weak var verticalStackView: UIStackView!
    @IBOutlet weak var instagridLabel: UILabel!

    private var lastImageViewTapped: UIImageView?

    

    override func viewDidLoad() {
        super.viewDidLoad()
        let animate = Title()
        animate.animateAppName(label: self.instagridLabel)
        if UIApplication.shared.statusBarOrientation.isPortrait {
            self.swipeLabel.text = "Swipe up to share"
            let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(self.handleGesture))
            swipeUp.direction = .up
            self.view.addGestureRecognizer(swipeUp)
        } else {
            self.swipeLabel.text = "Swipe left to share"
            let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.handleGesture))
            swipeLeft.direction = .left
            self.view.addGestureRecognizer(swipeLeft)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let animate = Title()
        super.viewDidAppear(animated)
        animate.animateAppName(label: self.instagridLabel)
    }
    

    // Changes orientation screen display
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animate(alongsideTransition: {
            context in
let animate = Title()
            if UIApplication.shared.statusBarOrientation.isPortrait {
                animate.animateAppName(label: self.instagridLabel)
                self.swipeLabel.text = "Swipe up to share"
                let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(self.handleGesture))
                swipeUp.direction = .up
                self.view.addGestureRecognizer(swipeUp)
            } else {
                animate.animateAppName(label: self.instagridLabel)
                self.swipeLabel.text = "Swipe left to share"
                let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.handleGesture))
                swipeLeft.direction = .left
                self.view.addGestureRecognizer(swipeLeft)
            }
        })
    }
    
    func AnimationDone() {
        print ("animation done")
        UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options:[] , animations: {
        self.swipeView.transform = .identity
        } , completion: nil )
    }
    
    // To swipe the verticalStackView
    fileprivate func swipeAnimation() {
        // swipe up portrait mode animation
        if UIApplication.shared.statusBarOrientation.isPortrait {
            print("swipe up")
            let swipePortrait: CGAffineTransform
            swipePortrait = CGAffineTransform(translationX: 0, y: -400)
            UIView.animate(withDuration: 0.4, animations: {
                self.swipeView.transform = swipePortrait
            }) { (success) in
                if (success) {
                    self.AnimationDone()
                }
            }
        } else {
            // swipe left landscape mode
            let swipeLandscape: CGAffineTransform
            swipeLandscape = CGAffineTransform(translationX: -300, y: 0)
            UIView.animate(withDuration: 0.4, animations: {
                self.swipeView.transform = swipeLandscape
            })
            { (success) in
                if (success) {
                    self.AnimationDone()
                }
            }
        }
    }
 
    // Func to check each image view
    func checkSelected1() -> Bool {
        return topRightImageView.image != nil &&
            bottomLeftImageView.image != nil &&
        bottomRightImageView.image != nil
    }
    func checkSelected2() -> Bool {
        return topLeftImageView.image != nil && topRightImageView.image != nil &&
        bottomRightImageView.image != nil
    }
    func checkSelected3() -> Bool {
        return topLeftImageView.image != nil && topRightImageView.image != nil &&
            bottomLeftImageView.image != nil &&
            bottomRightImageView.image != nil
    }
    /*
   // Alert if an image is missing in the grid before saving
    fileprivate func missingImageAlert() {
        let imageAlert = UIAlertController(title: "⚠️ You must complete the grid with missing images to share it!", message: "", preferredStyle: .alert)
        imageAlert.addAction(UIAlertAction(title: "Got it 👍", style: .default))
        present(imageAlert, animated: true)
    }
 */
    
    @objc func handleGesture() {
        let alert = AlertMessage()
        swipeAnimation()
        var finalImage: UIImage? = nil
        
        switch self.select {
        case .selected1:
            if checkSelected1() {
                finalImage = mergeImages(topLeftImage:topImageView.image, topRightImage: topRightImageView.image, bottomLeftImage: bottomLeftImageView.image, bottomRightImage: bottomRightImageView.image)
            } else {
                alert.missingImageAlert(vc: self)
                return
            }
            break
        case .selected2:
            if checkSelected2() {
                finalImage = mergeImages(topLeftImage: topLeftImageView.image, topRightImage: topRightImageView.image, bottomLeftImage: bottomImageView.image, bottomRightImage: bottomRightImageView.image)
            } else {
                alert.missingImageAlert(vc: self)
                return
            }
            break
        case .selected3:
            if checkSelected3() {
                finalImage = mergeImages(topLeftImage: topLeftImageView.image, topRightImage: topRightImageView.image, bottomLeftImage: bottomLeftImageView.image, bottomRightImage: bottomRightImageView.image)
            } else {
                alert.missingImageAlert(vc: self)
                return
            }
            break
        }
        let items = [finalImage]
        let ac = UIActivityViewController(activityItems: items as [Any], applicationActivities: nil)
        present(ac, animated: true)
    }
    
    /// To merge the final image for save it then
    func mergeImages(topLeftImage: UIImage?, topRightImage: UIImage?,
                     bottomLeftImage: UIImage?, bottomRightImage: UIImage?) -> UIImage? {
        let widthImage = CGFloat(topLeftImage?.size.width ?? 0) + CGFloat(topRightImage?.size.width ?? 0)
        let heightImage = CGFloat(topLeftImage?.size.height ?? 0) + CGFloat(bottomLeftImage?.size.height ?? 0)
        let size = CGSize(width: widthImage, height: heightImage)
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        // To declare which image has to be drawing
        var largeImage = CGFloat(0)
        // To draw images
        if select == .selected1 {
            largeImage = widthImage
            topRightImage?.draw(in: CGRect(x: 0, y: 0, width: largeImage, height: topRightImage?.size.height ?? 0))
            bottomLeftImage?.draw(in: CGRect(x: 0, y:topRightImage?.size.height ?? 0, width: bottomLeftImage?.size.width ?? 0, height: bottomLeftImage?.size.height ?? 0))
            bottomRightImage?.draw(in: CGRect(x:bottomLeftImage?.size.width ?? 0, y:topRightImage?.size.height ?? 0, width: bottomRightImage?.size.width ?? 0, height: bottomRightImage?.size.height ?? 0))
        } else if select == .selected2 {
            largeImage = widthImage
            topLeftImage?.draw(in: CGRect(x:0, y: 0, width: topLeftImage?.size.width ?? 0, height: topLeftImage?.size.height ?? 0))
            topRightImage?.draw(in: CGRect(x:topLeftImage?.size.width ?? 0, y: 0, width:topRightImage?.size.width ?? 0, height: topRightImage?.size.height ?? 0))
            bottomRightImage?.draw(in: CGRect(x: 0, y:topLeftImage?.size.height ?? 0, width: largeImage, height: bottomRightImage?.size.height ?? 0))
        } else if select == .selected3 {
            largeImage = widthImage
            topLeftImage?.draw(in: CGRect(x:0, y: 0, width: topLeftImage?.size.width ?? 0, height: topLeftImage?.size.height ?? 0))
            topRightImage?.draw(in: CGRect(x:topLeftImage?.size.width ?? 0, y: 0, width:topRightImage?.size.width ?? 0, height: topRightImage?.size.height ?? 0))
            bottomLeftImage?.draw(in: CGRect(x: 0, y:topRightImage?.size.height ?? 0, width: bottomLeftImage?.size.width ?? 0, height: bottomLeftImage?.size.height ?? 0))
            bottomRightImage?.draw(in: CGRect(x:bottomLeftImage?.size.width ?? 0, y:topRightImage?.size.height ?? 0, width: bottomRightImage?.size.width ?? 0, height: bottomRightImage?.size.height ?? 0))
        }
        
        let newImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }
    
    // func in case resticted
    fileprivate func restrictedCase() {
        let alert = UIAlertController(title: "Photo library restricted", message: "Photo library acces is restriced and can't be accessed", preferredStyle: .alert)
        let okAction = UIAlertAction(title : "OK", style: .default)
        alert.addAction(okAction)
        self.present(alert, animated: true)
    }
    // func in case not determined
    fileprivate func notDeterminedCase(_ status: PHAuthorizationStatus) {
        if status == PHAuthorizationStatus.authorized{
            self.PhotoPickerController()
        }
    }
    //func in case denied
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
    
    enum SelectedCase {
        case selected1, selected2, selected3
    }
    var select: SelectedCase = .selected3 {
        didSet {
        }
    }
    
    //Buttons for each layout 1 / 2 / 3
    @IBAction func Button1(_ sender: UIButton) {
        select = .selected1 // Layout1
        selected1.isHidden = false
        selected2.isHidden = true
        selected3.isHidden = true
        
        topLeftView.isHidden = true
        topRightView.isHidden = false
        bottomLeftView.isHidden = false
        bottomRightView.isHidden = false
        
    }
    @IBAction func Button2(_ sender: UIButton) {
        select = .selected2 // Layout2
        selected1.isHidden = true
        selected2.isHidden = false
        selected3.isHidden = true
        
        topLeftView.isHidden = false
        topRightView.isHidden = false
        bottomLeftView.isHidden = true
        bottomRightView.isHidden = false
    }
    @IBAction func Button3(_ sender: UIButton) {
        select = .selected3 // Layout3
        selected1.isHidden = true
        selected2.isHidden = true
        selected3.isHidden = false
        
        topLeftView.isHidden = false
        topRightView.isHidden = false
        bottomLeftView.isHidden = false
        bottomRightView.isHidden = false
    }
    
} // End of class
