//
//  ViewController.swift
//  Instagrid
//
//  Created by Thomas on 03/07/2019.
//  Copyright © 2019 Thomas. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var tag = Int()
    var activityVC: UIActivityViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupImageAspect()
        setSwipegesture()
    }
    
    
    //MARK: - IBAction
    
    @IBAction func swipToShare(_ sender: UISwipeGestureRecognizer) {
        mainViewAnimation()
    }
    
    @IBAction func didTapImagesButtons(_ sender: UIButton) {
        tag = sender.tag
        pickAnImage()
    }
    
    @IBAction func firstViewDisposition(_ sender: UIButton) {
        resetSelectedDisposition(sender)
        doFirstDisposition()
    }
    @IBAction func secondViewDisposition(_ sender: UIButton) {
        resetSelectedDisposition(sender)
        doSecondDisposition()
    }
    @IBAction func thirdViewDisposition(_ sender: UIButton) {
        resetSelectedDisposition(sender)
        doThirdDisposition()
        buttonDisposition[sender.tag].imageView?.image = UIImage(named: "Selected")
    }
    
    //MARK: - IBOutlet
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var instructionLabel: UILabel!
    @IBOutlet var imagesButtons: [UIButton]!
    @IBOutlet var buttonDisposition: [UIButton]!
    @IBOutlet var swipeGestureRecognizer: UISwipeGestureRecognizer!
    
    //MARK: - Setup
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(alongsideTransition: nil) { _ in
            self.checkDeviceOrientation()
        }
    }
    
    private func checkDeviceOrientation() {
        if UIDevice.current.orientation == UIDeviceOrientation.portrait {
            self.swipeGestureRecognizer.direction = .up
            self.instructionLabel.text = "Swipe up to share ^"
        } else {
            self.swipeGestureRecognizer.direction = .left
            self.instructionLabel.text = "Swipe left to share <"
        }
    }
    
    private func displayAlert(title: String) {
        let alert = UIAlertController(title: title, message: "Please try again.", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        
        self.present(alert, animated: true)
    }
    
    private func resetSelectedDisposition(_ sender: UIButton) {
        for button in buttonDisposition {
            button.setImage(nil, for: .normal)
        }
        buttonDisposition[sender.tag].setImage(#imageLiteral(resourceName: "Selected.png"), for: .normal)
    }
    
    private func setSwipegesture() {
        swipeGestureRecognizer.direction = .up
    }
    
    private func setupImageAspect() {
        for imageButton in imagesButtons {
            imageButton.imageView?.contentMode = .scaleAspectFill
        }
    }
    
    //MARK: - Image Disposition
    
    private func doFirstDisposition() {
        imagesButtons[0].isHidden = false
        imagesButtons[1].isHidden = true
        imagesButtons[2].isHidden = false
        imagesButtons[3].isHidden = false
    }
    
    private func doSecondDisposition() {
        for image in imagesButtons {
            image.isHidden = false
        }
        imagesButtons[0].isHidden = false
        imagesButtons[3].isHidden = true
    }
    
    private func doThirdDisposition() {
        for image in imagesButtons {
            image.isHidden = false
        }
    }
    
    //MARK: - Animation
    
    private func doAnimation(x: CGFloat, y screenSize: CGFloat, isShareImageNeeded: Bool) {
        let translationTransform = CGAffineTransform(translationX: x, y: screenSize)
        
        UIView.animate(withDuration: 0.3, animations: {
            self.mainView.transform = translationTransform
        }) { (finished) in
            if isShareImageNeeded {
                self.shareImage()
            }
        }
    }
    
    private func mainViewAnimation() {
        let screenHeight = UIScreen.main.bounds.height
        let screenWidth = UIScreen.main.bounds.width
        if UIDevice.current.orientation == UIDeviceOrientation.portrait {
            doAnimation(x: 0, y: -screenHeight, isShareImageNeeded: true)
        } else {
            doAnimation(x: -screenWidth, y: 0, isShareImageNeeded: true)
        }
    }
    
    //MARK: - Image functionality
    
    private func shareImage() {
        UIGraphicsBeginImageContext(mainView.frame.size)
        
        guard let context = UIGraphicsGetCurrentContext() else {
            return displayAlert(title: "Can't get the current context")
        }
        mainView.layer.render(in: context)
        
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else {
            return displayAlert(title: "Can't get image from current context")
        }
        
        presentActivityVC(withItem: image)
    }
    
    private func presentActivityVC(withItem image: UIImage) {
        setupActivityVC(withItems: image)
        
        guard let activityVC = activityVC else {
            return displayAlert(title: "Activity controller cannot be open")
        }
        
        present(activityVC, animated: true)
    }
    
    private func setupActivityVC(withItems items: UIImage) {
        activityVC = UIActivityViewController(activityItems: [items], applicationActivities: nil)
        activityVC?.popoverPresentationController?.sourceView = self.view
        activityVC?.completionWithItemsHandler = { (activityType, completed, items, error) in
            if error != nil {
                self.displayAlert(title: "Something Wrong happend.")
            }
            
            self.doAnimation(x: 0, y: 0, isShareImageNeeded: false)
        }
    }
    
    private func pickAnImage() {
        let pickerImageController = UIImagePickerController()
        
        pickerImageController.delegate = self
        pickerImageController.modalPresentationStyle = .overCurrentContext
        pickerImageController.sourceType = .photoLibrary
        
        present(pickerImageController, animated: true)
    }
}

//MARK: - ImagePickerControllerDelegate

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            let selectedButton = imagesButtons[tag]
            selectedButton.setImage(image, for: .normal)
        }
        picker.dismiss(animated: true)
    }
}
