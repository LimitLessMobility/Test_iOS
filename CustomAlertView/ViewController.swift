//
//  ViewController.swift
//  CustomAlertView
//
//  Created by Apple on 06/04/22.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var txtAlert: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        if let userDefaults = UserDefaults(suiteName: "group.id.101.notifservext") {
            userDefaults.set("1324", forKey: "SOUND_VALUE")
            userDefaults.synchronize()
        }
    }
    
    
    @IBAction func alertWithOneButton(_ sender: UIButton) {
        
        if let systemSoundID = UInt32(txtAlert.text ?? "") {
            AudioServicesPlaySystemSound(systemSoundID)
        }
        
        return

        /*CustomAlertView()
            .addTitle(title: "Title", message: "Vitamin A plays an important role in vision and bone growth and helps protect the body from infections. Vitamin A also promotes the health and growth of cells and tissues in the body, particularly those in the hair, nails, and skin")
            .addPrimaryButton(title: "Primary ButtonA", type: .warning) { [weak self] in
                
                guard let self = self else { return }
                print("Primary Button Pressed", self)
                
                CustomAlertView()
                    .addTitle(title: "Title", message: "Vitamin A plays an important role in vision and bone growth and helps protect the body from infections. Vitamin A also promotes the health and growth of cells and tissues in the body, particularly those in the hair, nails, and skin")
                    .addPrimaryButton(title: "Ok", type: .default) { [weak self] in
                        
                        guard let self = self else { return }
                        print("Primary Button Pressed", self)
                        
                    }.presentAlert(on: self)
                
            }.addSecondaryButton(title: "Secondary", type: .default) { [weak self] in
                
                guard let self = self else { return }
                print("Secondary Button Pressed", self)
                
            }.presentAlert(on: self)*/
    }
    
    @IBAction func alertWithTwoButton(_ sender: UIButton) {
        CustomAlertView()
            .addTitle(title: "Title", message: "Vitamin A plays an important role in vision and bone growth and helps protect the body from infections. Vitamin A also promotes the health and growth of cells and tissues in the body, particularly those in the hair, nails, and skin")
            .addPrimaryButton(title: "Ok", type: .default) { [weak self] in
                
                guard let self = self else { return }
                print("Primary Button Pressed", self)
                
            }.addSecondaryButton(title: "Cancel", type: .default) { [weak self] in
                
                guard let self = self else { return }
                print("Secondary Button Pressed", self)
                
            }.presentAlert(on: self)
    }
        
}

extension ViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
