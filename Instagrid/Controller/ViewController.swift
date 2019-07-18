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
    
    @IBAction func firstViewDisposition(_ sender: Any) {
        doFirstDisposition()
        
    }
    @IBAction func secondViewDisposition(_ sender: Any) {
        doSecondDisposition()
    }
    @IBAction func thirdViewDisposition(_ sender: Any) {
        doThirdDisposition()
    }
    
    //MARK: - IBOutlet
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var instructionLabel: UILabel!
    @IBOutlet var firstAndSecondImage: [UIImageView]!
    @IBOutlet var thirdAndFourthImage: [UIImageView]!
    
    
    let main = Main()

    override func viewDidLoad() {
        super.viewDidLoad()
        giveNameToLabel()
    }
    
    //MARK: - Func
    
    func giveNameToLabel() {
        titleLabel.text = "Instagrid"
        instructionLabel.text = """
                Swipe up to share ^
        """
    }
    
    //MARK: - Image Disposition
    
    enum State {
        case used, unused, neutral
    }
    
    private func doFirstDisposition() {
        firstAndSecondImage[0].isHidden = false
        firstAndSecondImage[1].isHidden = true
        
        for image in thirdAndFourthImage {
            image.isHidden = false
        }
    }
    
    private func doSecondDisposition() {
        for image in firstAndSecondImage {
            image.isHidden = false
        }
        thirdAndFourthImage[0].isHidden = false
        thirdAndFourthImage[1].isHidden = true
    }
    
    private func doThirdDisposition() {
        for image in firstAndSecondImage {
            image.isHidden = false
        }
        for image in thirdAndFourthImage {
            image.isHidden = false
        }
    }
    
}

