//
//  RegisterrViewController.swift
//  chatappnew
//
//  Created by NguyenPhuongkhoa on 09/07/2023.
//

import UIKit
import FirebaseAuth

class RegisterrViewController: UIViewController {

    var  isPasswordVisible = false
    
    private let scrollView: UIScrollView = {
       let scrollView = UIScrollView()
        scrollView.clipsToBounds = true
        return scrollView
    }()
    
    private let imageView: UIImageView = {
        let imageview = UIImageView()
        imageview.image = UIImage(systemName: "person.circle")
        imageview.tintColor = .gray
        imageview.layer.masksToBounds = true
        imageview.contentMode = .scaleAspectFit
        imageview.layer.borderColor = UIColor.lightGray.cgColor
        imageview.layer.borderWidth = 2
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
                field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
                field.leftViewMode = .always
                field.layer.shadowColor =  UIColor.white.cgColor
                field.layer.shadowOpacity = 0.5
                field.layer.shadowOffset = CGSize(width: 2, height: 2)
                field.layer.shadowRadius = 15
                field.textColor = UIColor.black
                field.backgroundColor = .white
                field.attributedPlaceholder =  NSAttributedString(string: "Enter your email", attributes: [NSAttributedString.Key.foregroundColor:  UIColor(red: 212/255, green: 211/255, blue: 216/255, alpha: 1.0)])
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
        field.layer.shadowColor =  UIColor.white.cgColor
        field.layer.shadowOpacity = 0.5
        field.layer.shadowOffset = CGSize(width: 2, height: 2)
        field.layer.shadowRadius = 15
        field.backgroundColor = .white
        field.textColor = UIColor.black
        field.attributedPlaceholder =  NSAttributedString(string: "Enter your password", attributes: [NSAttributedString.Key.foregroundColor:  UIColor(red: 212/255, green: 211/255, blue: 216/255, alpha: 1.0)])
        field.isSecureTextEntry = true
        return field
    }()
    
    private let fullnameField: UITextField = {
        let field = UITextField()
        field.autocorrectionType = .no
        field.autocapitalizationType = .none
        field.returnKeyType = .continue
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.white.cgColor
        field.placeholder = "FullName..."
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        field.layer.shadowColor =  UIColor.white.cgColor
        field.layer.shadowOpacity = 0.5
        field.layer.shadowOffset = CGSize(width: 2, height: 2)
        field.layer.shadowRadius = 15
        field.textColor =  UIColor.black
        field.attributedPlaceholder =  NSAttributedString(string: "Enter your fullname", attributes: [NSAttributedString.Key.foregroundColor:  UIColor(red: 212/255, green: 211/255, blue: 216/255, alpha: 1.0)])
        field.backgroundColor = .white
        return field
    }()
    
    private let phoneNumberField: UITextField = {
        let field = UITextField()
        field.autocorrectionType = .no
        field.autocapitalizationType = .none
        field.returnKeyType = .continue
        field.layer.cornerRadius = 12
        field.keyboardType = .namePhonePad
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.white.cgColor
        field.placeholder = "Phone number..."
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        field.layer.shadowColor =  UIColor.white.cgColor
        field.layer.shadowOpacity = 0.5
        field.layer.shadowOffset = CGSize(width: 2, height: 2)
        field.layer.shadowRadius = 15
        field.textColor = UIColor.black
        field.attributedPlaceholder =  NSAttributedString(string: "Enter your phonenmuber", attributes: [NSAttributedString.Key.foregroundColor:  UIColor(red: 212/255, green: 211/255, blue: 216/255, alpha: 1.0)])
        field.backgroundColor = .white
        return field
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Register", for: .normal)
        button.backgroundColor = UIColor(red: 253/255, green: 107/255, blue: 104/255, alpha: 1.0)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 15
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
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
        button.setTitle("Sign Up", for: .normal)
        button.backgroundColor = .clear
        button.setTitleColor(UIColor(red: 142/255, green: 184/255, blue: 242/255, alpha: 1), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false

        button.titleLabel?.font = .systemFont(ofSize: 15,weight:.bold)
        return button
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(red: 228/255, green: 241/255, blue: 248/255, alpha: 1)
        title = "Reegister"
    
        // Add target action
        registerButton.addTarget(self, action: #selector(RegisterbuttonClicked), for: .touchUpInside)
        
        hideshowPass.addTarget(self, action: #selector(HideShowbuttonClicked), for: .touchUpInside)
        loginButton.addTarget(self, action: #selector(loginbuttonClicked), for: .touchUpInside)
        
        emailField.delegate = self
        passwordField.delegate = self
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing(_:))))
      
        applyConstraint()
        
        //Add Subviews
        view.addSubview(scrollView)
        scrollView.addSubview(imageView)
        scrollView.addSubview(emailField)
        scrollView.addSubview(passwordField)
        scrollView.addSubview(loginButton)
        scrollView.addSubview(hideshowPass)
        scrollView.addSubview(typeLogin)
        scrollView.addSubview(fullnameField)
        scrollView.addSubview(phoneNumberField)
        scrollView.addSubview(tittle1)
        scrollView.addSubview(registerButton)
        
        imageView.isUserInteractionEnabled = true
        scrollView.isUserInteractionEnabled = true
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didtapChangeProfilePic))
        
        imageView.addGestureRecognizer(gesture)
    }
    
    @objc private func didtapChangeProfilePic()
    {
       presentPhotoActionSheet()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        scrollView.frame = view.bounds
        let size = scrollView.width/3
        imageView.frame = CGRect(x: (scrollView.width - size)/2, y: 20, width: size, height: size)
        
        imageView.layer.cornerRadius = imageView.width / 2.0
        emailField.frame = CGRect(x: 30, y: imageView.bottom + 25, width: scrollView.width - 60, height: 56)
        passwordField.frame = CGRect(x: 30, y: emailField.bottom + 15, width: scrollView.width - 60 , height: 56)

        fullnameField.frame = CGRect(x: 30, y: passwordField.bottom + 15, width: scrollView.width - 60 , height: 56)
        
        registerButton.isHidden = true
        
        phoneNumberField.frame = CGRect(x: 30, y: fullnameField.bottom + 15, width: scrollView.width - 60 , height: 56)
        hideshowPass.frame = CGRect(x: scrollView.right - 65, y: passwordField.bottom - 40, width: 27, height: 27)
        
        let registerbuttonConstraint = [
            loginButton.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 40),
            loginButton.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: 40),
            loginButton.widthAnchor.constraint(equalToConstant: 60),
            loginButton.heightAnchor.constraint(equalToConstant: 60),
            loginButton.topAnchor.constraint(equalTo: phoneNumberField.topAnchor,constant:  100),
            loginButton.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor)
            
        ]
        NSLayoutConstraint.activate(registerbuttonConstraint)
    }
    
    
    private func applyConstraint()
    {
        
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

    @objc private func loginbuttonClicked() {
        
        emailField.resignFirstResponder()
        passwordField.resignFirstResponder()
        fullnameField.resignFirstResponder()
        phoneNumberField.resignFirstResponder()
        
        guard let fullname = fullnameField.text,let phonenumber = phoneNumberField.text, let email = emailField.text,
              let password = passwordField.text,
              !fullname.isEmpty,!phonenumber.isEmpty,
              !email.isEmpty, !password.isEmpty, password.count >= 6
        else{
            loginUserError()
            return
        }
        
        
        //DatabaseManager
        DatabaseManager.shared.userExist(with: email, completion: { [weak self] exists in
            guard let strongSelf = self else
           {
                return
            }
            guard !exists else
            {
                //set user alreaddy exist
                strongSelf.loginUserError(message: "Email adress already")
                return
            }
            //Firebase login
            FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password,completion: { [weak self] authResult, error in
                guard authResult != nil , error == nil else
                {
                    print("Error creating user")
                    return
                }

                //set data up to Firebase
                DatabaseManager.shared.insertUser(with: chatappUser(firstName: fullname,
                                                                    emailAddress: email,
                                                                    phoneNumber: phonenumber,
                                                                    Gender: true))
                strongSelf.navigationController?.dismiss(animated: true,completion: nil)
            })
        })
        
        
        
     
    }
    
    func loginUserError(message : String = "Vui long nhap du thong tin")
    {
        let alert = UIAlertController(title: "woops", message: message , preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
        present(alert,animated: true)
    }

}

extension RegisterrViewController: UITextFieldDelegate{
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

extension RegisterrViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func presentPhotoActionSheet()
    {
        let actionSheet = UIAlertController(title: "Profile Picture", message: "How would you like to select a picture", preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel,handler: nil))
        
        actionSheet.addAction(UIAlertAction(title: "Take Photo", style: .default, handler: {
            [weak self] _ in self?.presentCamera() }))
        actionSheet.addAction(UIAlertAction(title: "Chose photo", style: .default, handler: {
            [weak self] _ in self?.presentPhotoPicker() }))
        present(actionSheet, animated: true)
        
    }
    
    func presentCamera()
    {
        let vc = UIImagePickerController()
        vc.sourceType = .camera
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }
    func presentPhotoPicker()
    {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])
    {
        picker.dismiss(animated: true, completion:  nil)
        guard let selectedImage =  info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {
            return
        }
        self.imageView.image =  selectedImage
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController)
    {
        picker.dismiss(animated: true, completion: nil)
    }
}
