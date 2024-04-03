//
//  ViewController.swift
//  IntroToiOS
//
//  Created by telkanishvili on 03.04.24.
//

//iphone15PRO ზეა გაშვებული, iOS 17 ით

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var controllerView: UIView!
    @IBOutlet weak var labelOfUsgUsj: UILabel!
    @IBOutlet weak var toggleOfUsgUsj: UISwitch!
    @IBOutlet weak var firstTextField: UITextField!
    @IBOutlet weak var secondTextField: UITextField!
    @IBOutlet weak var calculateButton: UIButton!
    @IBOutlet weak var resultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        calculateButton.tintColor = UIColor.purple
    }
    func resetLabels(){
        firstTextField.text = ""
        secondTextField.text = ""
        resultLabel.text = ""
    }
    func getRedCornerOn(field: UITextField){
        field.layer.borderColor = UIColor.red.cgColor
        field.layer.borderWidth = 1.0
        field.layer.cornerRadius = 5.0
    }
    //უმცირესი საერთო ჯერადი
    func getUsj(firstInt: Int, secondInt: Int) -> Int{
        let maxInt = max(firstInt,secondInt)
        let minInt = min(firstInt,secondInt)
        var usj = minInt
    
        for _ in 0...maxInt{
            if usj % maxInt != 0 {
                usj += minInt
            }
        }
        return usj
    }
    //უდიდესი საერთო გამყოფი
    func getUsg(firstInt: Int, secondInt: Int) -> Int{
        (firstInt * secondInt) / getUsj(firstInt: firstInt, secondInt: secondInt)
    }
    
    @IBAction func switchClicked(_ sender: UISwitch) {
        if sender.isOn {
            labelOfUsgUsj.text = "უდიდესი საერთო გამყოფი"
            calculateButton.tintColor = UIColor.red
            resetLabels()
        } else {
            labelOfUsgUsj.text = "უმცირესი საერთო ჯერადი"
            calculateButton.tintColor = UIColor.purple
            resetLabels()
        }
    }
    
    @IBAction func calculateButton(_ sender: UIButton) {
        self.resultLabel.isHidden = false //ერორი რომ დაიმალება და იუზერი დააკლიკებს ბათონს რესალთი ისევ ხელმისაწვდომი რომ იყოს
        let firstInt = Int(firstTextField.text!) ?? 0
        let secondInt = Int(secondTextField.text!) ?? 0
        
        if firstInt > 0 && secondInt > 0{
            resultLabel.textColor = UIColor(named: "ResultColor")
            if toggleOfUsgUsj.isOn {
                resultLabel.text = "პასუხი: \(getUsg(firstInt: firstInt, secondInt: secondInt))"
            } else {
                resultLabel.text = "პასუხი: \(getUsj(firstInt: firstInt, secondInt: secondInt))"
            }
        } else if self.resultLabel.isHidden == false {
            resultLabel.textColor = .red
            resultLabel.text = "დაფიქსირდა არასწორად შეყვანილი მნიშვნელობა"
            calculateButton.isEnabled = false
            
            if firstInt == 0 && secondInt == 0{
                getRedCornerOn(field: firstTextField)
                getRedCornerOn(field: secondTextField)
                
            } else if firstInt == 0 {
                getRedCornerOn(field: firstTextField)
                
                
            } else if secondInt == 0 {
                getRedCornerOn(field: secondTextField)
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.resultLabel.isHidden = true
                self.firstTextField.layer.borderWidth = 0.0
                self.secondTextField.layer.borderWidth = 0.0
                self.calculateButton.isEnabled = true
            }
        }
    }
}
