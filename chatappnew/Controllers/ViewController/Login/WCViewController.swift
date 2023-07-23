//
//  WCViewController.swift
//  chatappnew
//
//  Created by NguyenPhuongkhoa on 09/07/2023.
//

import UIKit
import Lottie


class WCViewController: UIViewController {


    private let imageView: UIImageView = {
        let imageview = UIImageView()
        imageview.image = UIImage(named: "logo")
        imageview.contentMode = .scaleAspectFit
        imageview.translatesAutoresizingMaskIntoConstraints = false
        return imageview
    }()
    
    let animationView = LottieAnimationView(name: "ani_chat1")
    
    
    private let Tittle1: UITextView = {
        let field = UITextView()
        field.textColor = .black
        field.textAlignment = .center
        field.backgroundColor = UIColor(red: 228/255, green: 241/255, blue: 248/255, alpha: 1.0)
        field.text = "Nền tảng kết nối cho lập trình viên"
        field.font = UIFont(name: "Arial-BoldMT", size: 25)
        return field
    }()
    
    private let Tittle2: UITextView = {
        let field = UITextView()
        field.textColor = .black
        field.textAlignment = .left
        field.backgroundColor = UIColor(red: 228/255, green: 241/255, blue: 248/255, alpha: 1.0)
        field.text = "Nơi lập trình viên tập hợp trend mới nhất, ínight từ người trong ngành, trải nghiệm công việc và cả networking"
        field.font = UIFont(name: "ArialMT", size: 17)
        return field
    }()
    
    
    private let loginRegisterButton: UIView = {
        let button = UIView()
        button.backgroundColor = .white
        button.layer.cornerRadius = 15
        button.layer.masksToBounds = true
        button.layer.shadowColor =  UIColor.black.cgColor
        button.layer.shadowOpacity = 0.5
        button.layer.shadowOffset = CGSize(width: 2, height: 2)
        button.layer.shadowRadius = 15
        button.layer.borderColor = UIColor.black.cgColor
        return button
        
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Login", for: .normal)
        button.backgroundColor =  UIColor(red: 228/250, green: 241/255, blue: 248/255, alpha: 0.8)

        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 17
        button.layer.masksToBounds = true
        button.titleLabel?.font = .systemFont(ofSize: 20,weight:.regular)
        return button
    }()
    
    private let registerButton: UIButton = {
        let button = UIButton()
        button.setTitle("Register", for: .normal)
        button.backgroundColor = .white
        button.setTitleColor(.black, for: .normal)
        button.layer.masksToBounds = true
        button.titleLabel?.font = .systemFont(ofSize: 20,weight:.regular)
        return button
    }()
    
    private let helpButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.setImage(UIImage(named: "icon_info"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.masksToBounds = true
       return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(red: 228/255, green: 241/255, blue: 248/255, alpha: 1)
        //Add Subviews
        view.addSubview(imageView)
        view.addSubview(Tittle1)
        view.addSubview(Tittle2)
        view.addSubview(loginRegisterButton)
        view.addSubview(animationView)
        view.addSubview(helpButton)

        // Optional: set the animation view's loop and play settings
        animationView.loopMode = .loop
        animationView.play()
        loginRegisterButton.addSubview(registerButton)
        loginRegisterButton.addSubview(loginButton)
        
        // Add target action
        loginButton.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
        
        registerButton.addTarget(self, action: #selector(registerClicked), for: .touchUpInside)
    }
        override func viewDidLayoutSubviews() {
            super.viewDidLayoutSubviews()
            view.frame = view.bounds
            let size = view.frame.width/3
          
            imageView.isHidden = true
            animationView.contentMode = .scaleAspectFit
            animationView.translatesAutoresizingMaskIntoConstraints = false
            let animationConstraint = [
                animationView.widthAnchor.constraint(equalToConstant: 350),
                animationView.heightAnchor.constraint(equalToConstant: 350),
                animationView.topAnchor.constraint(equalTo: view.topAnchor,constant:  100),
                animationView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ]
            NSLayoutConstraint.activate(animationConstraint)
        
            
            let helpButtonConstraint =
            [
                helpButton.widthAnchor.constraint(equalToConstant: 40),
                helpButton.heightAnchor.constraint(equalToConstant: 40),
                helpButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
                helpButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -27)
            ]
            NSLayoutConstraint.activate(helpButtonConstraint)
            Tittle1.frame = CGRect(x:(view.frame.width - 250)/2, y: imageView.bottom + 250, width: 250, height: 60)
            
            Tittle2.frame = CGRect(x:(view.frame.width - 300)/2, y: Tittle1.bottom + 5, width: 300, height: 100)
            loginRegisterButton.frame = CGRect(x: 30, y: Tittle2.bottom + 150, width: view.width - 60 , height: 70)
            
            loginButton.frame = CGRect(x: 0, y: 0, width: loginRegisterButton.width/2 + 10 , height: loginRegisterButton.heigth)
            
            registerButton.frame = CGRect(x: loginRegisterButton.width/2 , y: 0, width: loginRegisterButton.width/2 , height: loginRegisterButton.heigth)
            
        }
    
    // Handler function
    @objc func buttonClicked() {
        let vc = LoginnViewController()
        navigationController?.pushViewController(vc, animated: true)
    }

    @objc func registerClicked()
    {
        let vc2 = RegisterrViewController()
        navigationController?.pushViewController(vc2, animated: true)
    }

}

