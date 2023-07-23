//
//  ProfileViewController.swift
//  ChatApp
//
//  Created by Nguyen  Khoa on 30/06/2023.
//

import UIKit
import FirebaseAuth
import FirebaseStorage

class ProfileViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    let data = ["Log out"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableHeaderView = createTableHeader()
    
    }
    
    func createTableHeader() -> UIView? {
        guard let email = UserDefaults.standard.value(forKey: "email") as? String else
        {
            return nil
        }
        let safeEmail = DatabaseManager.safeEmail(emailAdress: email)
        let filename = safeEmail + " " + "profile_picture.png"
        let path = "image/"+filename
        //"image/hangdt-gmail-com profile_picture.png"
        //hangdt-gmail-com profile_picture.png
        
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.width, height: 300))
        
        headerView.backgroundColor = .link
        
        let imageView = UIImageView(frame: CGRect(x: (headerView.width-280), y: 75, width: 150, height: 150))
        
        imageView.contentMode = .scaleAspectFill
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.borderWidth = 3
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = imageView.width/2
        headerView.addSubview(imageView)
        
        StorageManager.shared.dowloadURL(for: path, completion: { [weak self] result in
            switch result {
            case .success(let url):
                self?.dowloadImage(imageView: imageView, url: url)
            case .failure(let error):
                print("Failed to get dowload url: \(error)")
            }
        })
        return headerView
    }
    
    
    func dowloadImage(imageView: UIImageView, url: URL)
    {
        URLSession.shared.dataTask(with: url, completionHandler: { data, _, error in
            guard let data = data, error == nil else{
                return
            }
            DispatchQueue.main.async {
                let image = UIImage(data: data)
                imageView.image = image
            }
        }).resume()
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
