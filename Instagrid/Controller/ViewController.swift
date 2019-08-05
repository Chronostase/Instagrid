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
    
    //MARK: - IBAction
    
    @IBAction func swipToShare(_ sender: UISwipeGestureRecognizer) {
        shareImage()
    }
    
    @IBAction func didTapImagesButtons(_ sender: UIButton) {
        tag = sender.tag
        pickAnImage()
    }
    
    @IBAction func firstViewDisposition(_ sender: UIButton) {
        doFirstDisposition()
    }
    @IBAction func secondViewDisposition(_ sender: UIButton) {
        doSecondDisposition()
    }
    @IBAction func thirdViewDisposition(_ sender: UIButton) {
        doThirdDisposition()
    }
    
    //MARK: - IBOutlet
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var instructionLabel: UILabel!
    @IBOutlet var imagesButtons: [UIButton]!
    
    @IBOutlet var buttonDisposition: [UIButton]!

    let main = Main()

    override func viewDidLoad() {
        super.viewDidLoad()
        giveNameToLabel()
        setupImageAspect()
    }
    
    
    //MARK: - Image Disposition

    private func setupImageAspect() {
        for imageButton in imagesButtons {
            imageButton.imageView?.contentMode = .scaleAspectFill
        }
    }
    
    private func pickAnImage() {
        let pickerImageController = UIImagePickerController()
        
        pickerImageController.delegate = self
//        pickerImageController.allowsEditing = false
        pickerImageController.modalPresentationStyle = .overCurrentContext
        pickerImageController.sourceType = .photoLibrary
        
        present(pickerImageController, animated: true)
    }
    
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
    
    private func giveNameToLabel() {
        instructionLabel.text = """
        ^
        Swipe up to share
        """
    }
    
    private func shareImage() {
        UIGraphicsBeginImageContext(mainView.frame.size)
        
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        mainView.layer.render(in: context)
        
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else {
            return
        }
        let activityVC = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        activityVC.popoverPresentationController?.sourceView = view
        
        present(activityVC, animated: true)
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
