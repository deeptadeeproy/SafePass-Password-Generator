//
//  ViewController.swift
//  Safepass
//
//  Created by Deeptadeep Roy on 27/10/19.
//  Copyright © 2019 Deeptadeep Roy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: - IBOutlets in the app
    
    @IBOutlet var backgroundView: UIView!
    @IBOutlet weak var textBox: UITextField!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var genButton: UIButton!
    @IBOutlet weak var PinButton: UIButton!
    @IBOutlet weak var infoToPaste: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var copyButton: UIButton!
    
    //MARK: - Constants and Variables

    var characterNumber : Int = 0
    var password : String = ""
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    //MARK: - Custom Button Properties
    
    override func viewDidLoad() {
        super.viewDidLoad()
        genButton.layer.cornerRadius = 6.0
        PinButton.layer.cornerRadius = 6.0
        backgroundView.setGradientBackground(colorOne: Colors.mutedBlueGrey, colorTwo: Colors.lightMutedBlueGrey)
        copyButton.isEnabled = false
        saveButton.isEnabled = false
    }
    
    //MARK: - User Input
    
    func integer(from textBox: UITextField) -> Int {
        guard let text = textBox.text, let number = Int(text) else {
            return 0
        }
        return number
    }

    //MARK: - Input State Functions
    
    func buttonAction (WhichButtonMain : Int) {
        characterNumber = integer(from: textBox)
        if characterNumber < 4 || characterNumber > 80 {
            wrongInput()
        }
        
        else {
            correctInput(WhichButtonSub: WhichButtonMain)
        }
    }
    
    func wrongInput () {
        passwordLabel.text = "Length should be at least 4 and not more than 80 characters"
    }
    
    func correctInput (WhichButtonSub : Int) {
        if WhichButtonSub == 1 {
            password = randomString(length: characterNumber)
            updateUI()
        }
        else {
            password = randomPin(length: characterNumber)
            updateUI()
        }
    }
    
    func updateUI () {
        
        UIPasteboard.general.string = password
        passwordLabel.text = password
        saveButton.isEnabled = true
        copyButton.isEnabled = true
        saveButton.setTitle("Save", for: .normal)
        copyButton.setTitle("Copy", for: .normal)
        
    }
    
    //MARK: - Password Generation
    
    func randomString(length: Int) -> String {
      let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789~@#$%&*-_"
      return String((0..<length).map{ _ in letters.randomElement()! })
    }
    
    func randomPin(length: Int) -> String {
      let letters = "0123456789"
      return String((0..<length).map{ _ in letters.randomElement()! })
    }
    
    //MARK: - Generate Buttons Pressed
    
    @IBAction func passwordButtonPressed(_ sender: Any) {
        buttonAction(WhichButtonMain: 1)
    }
    
    @IBAction func pinButtonPressed(_ sender: Any) {
        buttonAction(WhichButtonMain: 2)
    }
    
    //MARK: - Save Button Pressed
    
    @IBAction func saveButtonPressd(_ sender: Any) {
        
       let fileName = "Safepass.txt"
       var filePath = ""
       
       // Find documents directory on device
       let dirs : [String] = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.allDomainsMask, true)
       
       if dirs.count > 0 {
           let dir = dirs[0] //documents directory
           filePath = dir.appending("/" + fileName)
           //print("Local path = \(filePath)")
       } else {
           //print("Could not find local directory to store file")
           return
       }
       
       // Set the contents
       let fileContentToWrite = password
       
       do {
           // Write contents to file
           try fileContentToWrite.write(toFile: filePath, atomically: false, encoding: String.Encoding.utf8)
       }
       catch let error as NSError {
           print("An error took place: \(error)")
       }
        saveButton.isEnabled = false
        saveButton.setTitle("Saved!", for: .normal)
        saveButton.pulsate()
        
    }
    
    //MARK: - Copy Button Pressed
    
    @IBAction func copyButtonPressed(_ sender: Any) {
        UIPasteboard.general.string = password
        copyButton.isEnabled = false
        copyButton.setTitle("Copied!", for: .normal)
        copyButton.pulsate()
    }
    
    
}
    


