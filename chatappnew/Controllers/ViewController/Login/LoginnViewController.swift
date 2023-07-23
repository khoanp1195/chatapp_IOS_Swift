//
//  LoginnViewController.swift
//  chatappnew
//
//  Created by NguyenPhuongkhoa on 09/07/2023.
//

import UIKit
import FirebaseAuth
import FBSDKLoginKit
import JGProgressHUD


class LoginnViewController: UIViewController {

    private let spinner = JGProgressHUD(style: .dark)
    
    var  isPasswordVisible = false
    
    private let scrollView: UIScrollView = {
       let scrollView = UIScrollView()
        scrollView.clipsToBounds = true
        return scrollView
    }()
    
    private let imageView: UIImageView = {
        let imageview = UIImageView()
        imageview.image = UIImage(named: "logo")
        imageview.contentMode = .scaleAspectFit
        return imageview
    }()
    
    private let emailField: UITextField = {
        let field = UITextField()
        field.autocorrectionType = .no
        field.autocapitalizationType = .none
        field.returnKeyType = .continue
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.white.cgColor
        field.placeholder = "Email Address..."
        field.textColor = UIColor.black
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        field.layer.shadowColor =  UIColor.white.cgColor
        field.layer.shadowOpacity = 0.5
        field.layer.shadowOffset = CGSize(width: 2, height: 2)
        field.layer.shadowRadius = 15
        field.attributedPlaceholder =  NSAttributedString(string: "Enter your email", attributes: [NSAttributedString.Key.foregroundColor:  UIColor(red: 212/255, green: 211/255, blue: 216/255, alpha: 1.0)])
        field.backgroundColor = .white
        return field
    }()
    
    private let forgotPassText: UITextView = {
        let field = UITextView()
        field.textColor = .black
        field.text = "Forgot Password"
        field.backgroundColor = .clear
        field.font = UIFont(name: "Helvetica", size: 12.0)
        return field
    }()
    
    private let typeLogin: UITextView = {
        let field = UITextView()
        field.textColor = .black
        field.backgroundColor = .clear
        field.text = "Or Continue With"
        field.font = UIFont(name: "Helvetica", size: 15.0)
        return field
    }()
    
    private let passwordField: UITextField = {
        let field = UITextField()
        field.autocorrectionType = .no
        field.autocapitalizationType = .none
        field.returnKeyType = .continue
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.white.cgColor
        field.placeholder = "Password..."
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        field.textColor = UIColor.black
        field.layer.shadowColor =  UIColor.white.cgColor
        field.layer.shadowOpacity = 0.5
        field.layer.shadowOffset = CGSize(width: 2, height: 2)
        field.layer.shadowRadius = 15
        field.backgroundColor = .white
        field.attributedPlaceholder =  NSAttributedString(string: "Enter your password", attributes: [NSAttributedString.Key.foregroundColor:  UIColor(red: 212/255, green: 211/255, blue: 216/255, alpha: 1.0)])
        field.isSecureTextEntry = true
        return field
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Log in", for: .normal)
        button.backgroundColor = UIColor(red: 253/255, green: 107/255, blue: 104/255, alpha: 1.0)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        button.layer.masksToBounds = true
        button.titleLabel?.font = .systemFont(ofSize: 20,weight:.bold)
        return button
    }()
    
    private let hideshowPass: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.layer.cornerRadius = 20
        button.layer.masksToBounds = true
        let image = UIImage(named: "icon_hidePass")
        button.setBackgroundImage(image, for: .normal)
        return button
    }()
    
    private let facebookButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 228/255, green: 241/255, blue: 248/255, alpha: 1)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        button.layer.masksToBounds = true
        button.layer.borderWidth = 2.5
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.shadowColor =  UIColor.white.cgColor
        button.layer.shadowOpacity = 0.5
        button.layer.shadowOffset = CGSize(width: 2, height: 2)
        button.layer.shadowRadius = 15
        let image = UIImage(named: "icon_facebook")
        button.setBackgroundImage(image, for: .normal)
        button.contentMode = .scaleAspectFit
        return button
    }()
    
    private let googleButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 228/255, green: 241/255, blue: 248/255, alpha: 1)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        button.layer.masksToBounds = true
        button.layer.borderWidth = 2.5
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.shadowColor =  UIColor.white.cgColor
        button.layer.shadowOpacity = 0.5
        button.layer.shadowOffset = CGSize(width: 2, height: 2)
        button.layer.shadowRadius = 15
        let image = UIImage(named: "icon_google")
        button.setBackgroundImage(image, for: .normal)
        button.contentMode = .scaleAspectFit
        return button
    }()
    
    private let appleButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 228/255, green: 241/255, blue: 248/255, alpha: 1)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        button.layer.masksToBounds = true
        button.layer.borderWidth = 2.5
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.shadowColor =  UIColor.white.cgColor
        button.layer.shadowOpacity = 0.5
        button.layer.shadowOffset = CGSize(width: 2, height: 2)
        button.layer.shadowRadius = 15
        let image = UIImage(named: "icon_appstore")
        button.setBackgroundImage(image, for: .normal)
        button.contentMode = .scaleAspectFit
        return button
    }()
    
    
    private let tittle1: UITextView = {
        let field = UITextView()
        field.textColor = .black
        field.backgroundColor = .clear
        field.text = "Not a member ?"
        field.font = UIFont(name: "Helvetica", size: 15.0)
        return field
    }()
    
    private let registerButton: UIButton = {
        let button = UIButton()
        button.setTitle("Register now", for: .normal)
        button.backgroundColor = .clear
        button.setTitleColor(UIColor(red: 142/255, green: 184/255, blue: 242/255, alpha: 1), for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15,weight:.bold)
        return button
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(red: 228/255, green: 241/255, blue: 248/255, alpha: 1)
        title = "Login"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Register", style: .done, target: self, action: #selector(didTapRegister))

        //target action
        registerButton.addTarget(self, action: #selector(RegisterbuttonClicked), for: .touchUpInside)
        hideshowPass.addTarget(self, action: #selector(HideShowbuttonClicked), for: .touchUpInside)
        loginButton.addTarget(self, action: #selector(loginbuttonClicked), for: .touchUpInside)
        facebookButton.addTarget(self, action: #selector(LoginWithFacebook), for: .touchUpInside)
       
       
//        let facebookButtonn =  FBLoginButton()
//        facebookButtonn.center = view.center
            
        emailField.delegate = self
        passwordField.delegate = self
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing(_:))))
        
        //Add Subviews
        view.addSubview(scrollView)
        scrollView.addSubview(imageView)
        scrollView.addSubview(emailField)
        scrollView.addSubview(passwordField)
        scrollView.addSubview(loginButton)
        scrollView.addSubview(forgotPassText)
        scrollView.addSubview(hideshowPass)
        scrollView.addSubview(typeLogin)
        scrollView.addSubview(facebookButton)
        scrollView.addSubview(appleButton)
        scrollView.addSubview(googleButton)
        scrollView.addSubview(tittle1)
        scrollView.addSubview(registerButton)
      //  scrollView.addSubview(facebookButtonn)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        scrollView.frame = view.bounds
        let size = scrollView.width/3
        imageView.frame = CGRect(x: (scrollView.width - size)/2, y: 20, width: size, height: size)
        
        emailField.frame = CGRect(x: 30, y: imageView.bottom + 25, width: scrollView.width - 60, height: 56)
        passwordField.frame = CGRect(x: 30, y: emailField.bottom + 15, width: scrollView.width - 60 , height: 56)
        
        forgotPassText.frame = CGRect(x: scrollView.right - 125, y: passwordField.bottom + 10, width: 110, height: 30)
        loginButton.frame = CGRect(x: 30, y: forgotPassText.bottom + 30, width: scrollView.width - 60 , height: 52)

        hideshowPass.frame = CGRect(x: scrollView.right - 65, y: passwordField.bottom - 40, width: 27, height: 27)
        
        typeLogin.frame = CGRect(x: (scrollView.frame.width - 150)/2 + 10, y: loginButton.bottom + 45, width: 150, height: 52)
        
        facebookButton.frame = CGRect(x: 82, y: typeLogin.bottom + 30, width: 60 , height: 60)
        appleButton.frame = CGRect(x: facebookButton.left + facebookButton.frame.width + 35, y: typeLogin.bottom + 30, width: 60 , height: 60)
        
        googleButton.frame = CGRect(x: appleButton.left + appleButton.frame.width + 35, y: typeLogin.bottom + 30, width: 60 , height: 60)
        
  
        tittle1.frame = CGRect(x: (scrollView.frame.width - 150)/2 - 30, y: googleButton.bottom + 35, width: 130, height: 52)
        registerButton.frame = CGRect(x: appleButton.left + appleButton.frame.width - 40, y: googleButton.bottom + 27, width: 140, height: 52)
    }
    
    //Move to RegisterViewController
    @objc private func didTapRegister()
    {
        let vc = RegisterrViewController()
        vc.title = "Create Account"
        navigationController?.pushViewController(vc, animated: true)
    }
    // Handler function
    @objc func RegisterbuttonClicked() {
        let vc = RegisterrViewController()
        navigationController?.pushViewController(vc, animated: true)
    }

    @objc func HideShowbuttonClicked() {
        isPasswordVisible = !isPasswordVisible
           passwordField.isSecureTextEntry = !isPasswordVisible
           
           let buttonImage = !isPasswordVisible ? UIImage(named: "icon_hidePass") : UIImage(named: "icon_showPass")
        hideshowPass.setImage(buttonImage, for: .normal)
    }

    @objc func LoginWithFacebook()
    {
    

  
    }
    
    
    @objc private func loginbuttonClicked() {
        emailField.resignFirstResponder()
        passwordField.resignFirstResponder()
        
        guard let email = emailField.text, let password = passwordField.text,
              !email.isEmpty, !password.isEmpty, password.count >= 6
        else{
            loginUserError()
            return
        }
        
        spinner.show(in: view)

        //Firebase login
        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password, completion: { [weak self] authResult, error in
            guard let result = authResult, error == nil else {
               
                print("Failed to login user with email: \(email)")
                self?.loginErrorInfo(error: "Failed to login user with email: \(email)")
                self?.spinner.dismiss()
                return
            }
            guard let strongSelf = self else
            {
                return
            }
            
            DispatchQueue.main.async {
                strongSelf.spinner.dismiss()
            }
            let user = result.user
            
            UserDefaults.standard.set(email, forKey: "email")
            
            
            print("Logged in Successfully: \(user)")
            strongSelf.navigationController?.dismiss(animated: true,completion: nil)
      
            })
    }
    
    func loginUserError()
    {
        let alert = UIAlertController(title: "woops", message: "Vui long nhap du thong tin", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
        present(alert,animated: true)
    }
    
    func loginErrorInfo(error: String)
    {
        let alert = UIAlertController(title: "woops", message:error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
        present(alert,animated: true)
    }
    

}

extension LoginnViewController: UITextFieldDelegate{
    func textFiledShouldReturn(_ textField: UITextField) -> Bool{
        if textField == emailField
        {
            passwordField.becomeFirstResponder()
        }
        else if textField == passwordField
        {
            loginbuttonClicked()
        }
        return true
    }
}
