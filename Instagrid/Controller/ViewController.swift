//
//  ViewController.swift
//  Instagrid
//
//  Created by Thomas on 03/07/2019.
//  Copyright © 2019 Thomas. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: - IBAction
    
    //FIX: add Image control func
    @IBAction func firstImageButton(_ sender: UIButton) {
    }
    @IBAction func secondImageButton(_ sender: UIButton) {
    }
    @IBAction func thirdImageButton(_ sender: UIButton) {
    }
    @IBAction func fourthImageButton(_ sender: UIButton) {
    }
    
    @IBAction func firstViewDisposition(_ sender: UIButton) {
        style = .used
        doFirstDisposition()
    }
    @IBAction func secondViewDisposition(_ sender: UIButton) {
        style = .used
        doSecondDisposition()
    }
    @IBAction func thirdViewDisposition(_ sender: UIButton) {
        style = .used
        doThirdDisposition()
    }
    
    //MARK: - IBOutlet
    
    @IBOutlet weak var instructionLabel: UILabel!
    @IBOutlet var firstAndSecondButton: [UIButton]!
    @IBOutlet var thirdAndFourthButton: [UIButton]!
    @IBOutlet var buttonDisposition: [UIButton]!

    let main = Main()

    override func viewDidLoad() {
        super.viewDidLoad()
        giveNameToLabel()
    }
    
    //MARK: - Func
    
    func giveNameToLabel() {
        instructionLabel.text = """
                Swipe up to share ^
        """
    }
    
    //MARK: - Image Disposition
    
    enum Style {
        case used, unused
    }
    
    var style: Style = .unused
    
//    func setStyle(_ style: Style) {
//        switch style {
//
//        case .used:
//        case .unused:
//
//        }
//    }
    
    private func doFirstDisposition() {
        firstAndSecondButton[0].isHidden = false
        firstAndSecondButton[1].isHidden = true
        
        for image in thirdAndFourthButton {
            image.isHidden = false
        }
    }
    
    private func doSecondDisposition() {
        for image in firstAndSecondButton {
            image.isHidden = false
        }
        thirdAndFourthButton[0].isHidden = false
        thirdAndFourthButton[1].isHidden = true
    }
    
    private func doThirdDisposition() {
        for image in firstAndSecondButton {
            image.isHidden = false
        }
        for image in thirdAndFourthButton {
            image.isHidden = false
        }
    }
    
}

