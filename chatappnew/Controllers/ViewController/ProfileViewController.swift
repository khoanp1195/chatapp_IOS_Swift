//
//  ProfileViewController.swift
//  ChatApp
//
//  Created by Nguyen  Khoa on 30/06/2023.
//

import UIKit
import FirebaseAuth

class ProfileViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    let data = ["Log out"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.count
    }
    //alert if notice
    func AlertViewError()
    {
        let alertController = UIAlertController(title: "Alert Title", message: "Alert Message", preferredStyle: .alert)

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { action in
            // Handle cancel action
            alertController.dismiss(animated: true, completion:  nil)
        }

        let okAction = UIAlertAction(title: "OK", style: .default, handler: { [weak self] _ in
            
            guard let strongSelf = self else
            {
                return
            }
            do{
                try FirebaseAuth.Auth.auth().signOut()
                let vc = WCViewController()//LoginViewController()
                           let nav = UINavigationController(rootViewController: vc)
                           nav.modalPresentationStyle = .fullScreen
                strongSelf.present(nav, animated: true)
            }
            catch{
                
            }
        })
        
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = data[indexPath.row]
        cell.textLabel?.textAlignment  = .center
        cell.textLabel?.textColor = .red
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
       
        AlertViewError()
    }
}
