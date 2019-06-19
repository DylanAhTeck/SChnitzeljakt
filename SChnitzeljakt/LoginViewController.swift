//
//  LoginViewController.swift
//  SChnitzeljakt
//
//  Created by Harrison Weinerman on 10/19/18.
//  Copyright © 2018 SChnitzeljakt. All rights reserved.
//

import UIKit
import Nuke

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameTextfield: UITextField!
    
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var sparkleView: UIView!
    
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var img: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.stopAnimating()
        signInButton.layer.cornerRadius = 5
        signInButton.layer.borderColor = UIColor.white.cgColor
        signInButton.layer.borderWidth = 1.5

        // Do any additional setup after loading the view.
    }
    @IBAction func login(_ sender: Any) {
        guard let username = usernameTextfield.text,
            let password = passwordTextfield.text else {
                return
        }
        if !DataManager.shared.login(username: username, password: password) {
            errorLoggingIn()
        } else {
            open()
        }
  
        signInButton.setTitle("", for: .normal)
        loadingIndicator.startAnimating()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        sparkleView.twinkle()
    }

    @IBAction func skipLogin(_ sender: Any) {
            self.performSegue(withIdentifier: "launch", sender: self)
    }
    
    func open() {
         DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.2) {
            self.performSegue(withIdentifier: "launch", sender: self)
        }
        allowSignInAgain()
    }
    
    func errorLoggingIn() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.2) {
            self.signInButton.setTitle("Sign In", for: .normal)
            self.loadingIndicator.stopAnimating()
            self.usernameTextfield.text=""
            self.passwordTextfield.text=""
           let alert = UIAlertController(title: "Oops", message: "Check your username and password and try again.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
                
            }))
            self.present(alert, animated: true)
        }
    }
    
    func allowSignInAgain() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
            self.usernameTextfield.text=""
            self.passwordTextfield.text=""
            self.signInButton.setTitle("Sign In", for: .normal)
            self.loadingIndicator.stopAnimating()
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
