//
//  LoginViewController.swift
//  CatFacts
//
//  Created by Serhii PERKHUN on 1/7/19.
//  Copyright © 2019 Serhii PERKHUN. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var loginButton: UIButton! {
        willSet {
            newValue.layer.borderWidth = 2
            newValue.layer.borderColor = UIColor(red:0.74, green:0.82, blue:0.81, alpha:1.0).cgColor
            newValue.layer.cornerRadius = newValue.frame.size.height * 0.45
            newValue.clipsToBounds = true
        }
    }

    @IBOutlet weak var registrationButton: UIButton! {
        willSet {
            newValue.layer.cornerRadius = newValue.frame.size.height * 0.45
            newValue.clipsToBounds = true
            newValue.titleLabel?.adjustsFontSizeToFitWidth = true;
            newValue.titleLabel?.lineBreakMode = NSLineBreakMode.byClipping;
        }
    }

    @IBAction func hideKeyboard(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }

    @IBAction func loginButton(_ sender: UIButton) {
        if isValid(email: email.text!) && password.text!.count > 5 {
            if UserManager.instance.findUser(with: email.text!, and: password.text!) {
                UserDefaults.standard.set(true, forKey: "auth")
                performSegue(withIdentifier: "segueFromLoginToCatFacts", sender: nil)
            } else {
                showAlert(message: "Incorrect username or password.")
            }
        } else {
            showAlert(message: "Incorrect username or password.")
        }
        email.text! = ""
        password.text! = ""
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let status = UserDefaults.standard.bool(forKey: "auth")
        if status == true {
            performSegue(withIdentifier: "segueFromLoginToCatFacts", sender: nil)
        }
    }
    
    func isValid(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        self.present(alert, animated: true)
        let when = DispatchTime.now() + 3
        DispatchQueue.main.asyncAfter(deadline: when){
            alert.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func unWind(segue: UIStoryboardSegue) {
        UserDefaults.standard.set(false, forKey: "auth")
    }
}

