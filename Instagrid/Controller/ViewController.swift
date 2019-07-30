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
    
    //FIX: add Image control func
    @IBAction func swipToShare(_ sender: UISwipeGestureRecognizer) {
        UIGraphicsBeginImageContext(mainView.frame.size)
        mainView.layer.render(in: UIGraphicsGetCurrentContext()!)
        if let image = UIGraphicsGetImageFromCurrentImageContext() {
            let activityVC = UIActivityViewController(activityItems: [image], applicationActivities: nil)
            activityVC.popoverPresentationController?.sourceView = self.view
            
            self.present(activityVC, animated: true, completion: nil)
        }
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
    
    //MARK: - Func
    
    func giveNameToLabel() {
        instructionLabel.text = """
            ^
        Swipe up to share
        """
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
        pickerImageController.allowsEditing = false
        pickerImageController.modalPresentationStyle = .overCurrentContext
        pickerImageController.sourceType = .photoLibrary
        
        self.present(pickerImageController, animated: true)
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

}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            let selectedButton = imagesButtons[tag]
            selectedButton.setImage(image, for: .normal)
        }
        picker.dismiss(animated: true)
    }
}
