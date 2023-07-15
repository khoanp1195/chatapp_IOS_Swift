//
//  ViewController.swift
//  ChatApp
//
//  Created by Nguyen  Khoa on 02/06/2023.
//

import UIKit
import FirebaseAuth


class ConverstationsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
      //  DatabaseManager.shared.test()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
       // let isLoggedIn = UserDefaults.standard.bool(forKey: "logged_in")
        validateAuth()
    }
    private func validateAuth()
    {
        if FirebaseAuth.Auth.auth().currentUser == nil {
            let vc = WCViewController()//LoginViewController()
                       let nav = UINavigationController(rootViewController: vc)
                       nav.modalPresentationStyle = .fullScreen
                       present(nav, animated: true)
        }
    }


}

