//
//  ViewController.swift
//  ChatApp
//
//  Created by Nguyen  Khoa on 02/06/2023.
//

import UIKit
import FirebaseAuth
import JGProgressHUD

class ConverstationsViewController: UIViewController {
    private let spinner = JGProgressHUD(style: .dark)

    private let tableView: UITableView = {
        let table = UITableView()
        table.isHidden = true
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
//
    private let conversationLabel: UILabel =
    {
        let label = UILabel()
        label.text = "No Conversations"
        label.textAlignment  = .center
        label.textColor = .gray
        label.font = .systemFont(ofSize: 21, weight: .medium)
        label.isHidden = true
        return label
    }()
    
    private let buttonAdd: UIButton =
    {
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(didTapComposeButton))
       view.addSubview(tableView)
        view.addSubview(conversationLabel)
        setupTableView()
        fetchConversation()
        
      
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
       // let isLoggedIn = UserDefaults.standard.bool(forKey: "logged_in")
        validateAuth()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableView.frame = view.bounds
    }
    
    @objc private func didTapComposeButton(){
        let vc = NewConversationViewController()
        vc.completion = {[ weak self] result in
            print("\(result)")
            self?.createNewConversation(result: result)
        }
        let navVc = UINavigationController(rootViewController: vc)
        present(navVc,animated: true)
    }
    
    private func createNewConversation(result: [String: String])
    {
        guard let name = result["name"],
              let email = result["email"] else
        {
            return
        }
        
        let vc = ChatViewController(with: email)
        vc.title = name
        vc.isnewConversation = true
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    private func validateAuth()
    {
        if FirebaseAuth.Auth.auth().currentUser == nil {
            view.backgroundColor = UIColor.clear
            let vc = WCViewController()//LoginViewController()
                       let nav = UINavigationController(rootViewController: vc)
                nav.modalPresentationStyle = .fullScreen
                       present(nav, animated: true)
        }
    }
    
    private func setupTableView()
    {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func fetchConversation()
    {
        tableView.isHidden = false
    }
    

}


extension ConverstationsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell",for: indexPath)
        cell.textLabel?.text = "Hello Khoa"
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = ChatViewController(with: "zphuongkhoaz@gmail.com")
        vc.title = "Khoa"
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
        
    }
}

