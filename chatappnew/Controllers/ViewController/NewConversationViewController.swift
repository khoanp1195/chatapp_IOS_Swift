//
//  NewConversationViewController.swift
//  ChatApp
//
//  Created by Nguyen  Khoa on 30/06/2023.
//

import UIKit
import JGProgressHUD

class NewConversationViewController: UIViewController {

    public var completion: (([String: String]) -> (Void))?
    
    private let spinner = JGProgressHUD(style: .dark)
    private var users = [[String: String]]()
    
    private var results = [[String: String]]()
    private var hasFetched = false
    
    private let searchBar : UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search for users...."
        searchBar.searchTextField.backgroundColor = .clear
        searchBar.backgroundColor = .clear
        searchBar.searchTextField.layer.borderWidth = 0
        searchBar.setImage(UIImage(), for: .search, state: .normal)
        searchBar.searchTextField.layer.cornerRadius = 35
        searchBar.layer.cornerRadius = 35
        searchBar.layer.borderWidth = 0
        searchBar.clipsToBounds = true
        searchBar.searchBarStyle = .prominent
        return searchBar
    }()
    
    
    private let viewSearch : UIView = {
        let viewSearch = UIView()
        viewSearch.backgroundColor = .white
        viewSearch.layer.cornerRadius = 35
        return viewSearch
    }()
    
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.isHidden = true
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    private let noResultLabel: UILabel = {
        let label = UILabel()
        label.isHidden = true
        label.text  = "No Result"
        
        label.textAlignment = .center
        label.textColor = .green
        label.font = .systemFont(ofSize: 21,weight: .medium)
    return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Conversation"
        label.font =  UIFont.boldSystemFont(ofSize: 35)
        label.textAlignment = .center
        label.textColor = UIColor(red: CGFloat(53)/255.0, green: CGFloat(7)/255.0, blue: CGFloat(236)/255.0, alpha: 1.0)
        
        label.backgroundColor = UIColor(red: 228/255, green: 248/255, blue: 255/255, alpha: 1.0)

        return label
        
    }()
    
    private let imgOval: UIImageView = {
        let imgOval = UIImageView()
        imgOval.image = UIImage(named: "icon_oval")
        imgOval.translatesAutoresizingMaskIntoConstraints = false
        return imgOval
    }()
    
    private let icon_search: UIImageView = {
       let icon_search =  UIImageView()
        icon_search.image = UIImage(named: "icon_search")
        icon_search.translatesAutoresizingMaskIntoConstraints = false
        return icon_search
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 228/255, green: 248/255, blue: 255/255, alpha: 1.0)
        
        view.addSubview(noResultLabel)
        view.addSubview(tableView)
        view.addSubview(titleLabel)
        view.addSubview(viewSearch)
        viewSearch.addSubview(searchBar)
        viewSearch.addSubview(imgOval)
        viewSearch.addSubview(icon_search)

        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        
    
//        navigationController?.navigationBar.topItem?.titleView = searchBar
//        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Cancel", style: .done, target: self, action: #selector(dismissSelf))
    
        searchBar.becomeFirstResponder()
        
        
        tableView.frame = view.bounds
        tableView.backgroundColor = .yellow
        noResultLabel.frame = CGRect(x: view.width/4, y: (view.heigth - 200)/2, width: view.width/2, height: 200)
    }
    
    @objc private func dismissSelf()
    {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
     //   tableView.frame = view.bounds
        tableView.backgroundColor =  UIColor(red: 228/255, green: 248/255, blue: 255/255, alpha: 1.0)
        noResultLabel.frame = CGRect(x: view.width/4, y: (view.heigth - 200)/2, width: view.width/2, height: 200)
            
        //TitleLabel
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        let titleConstraint = [
            titleLabel.widthAnchor.constraint(equalToConstant: view.width),
            titleLabel.heightAnchor.constraint(equalToConstant: 100),
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor,constant: 0),
        ]
        NSLayoutConstraint.activate(titleConstraint)
        
        //TableView
        tableView.translatesAutoresizingMaskIntoConstraints = false
        let tableViewConstraint = [
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 10),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        NSLayoutConstraint.activate(tableViewConstraint)
        
        
        //ViewSearch
        viewSearch.translatesAutoresizingMaskIntoConstraints = false
        let viewSearchConstraint = [
            viewSearch.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            viewSearch.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            viewSearch.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            viewSearch.heightAnchor.constraint(equalToConstant: 73)
        ]
        NSLayoutConstraint.activate(viewSearchConstraint)
        
        
        
        //searchBar
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        let searchBarConstraint = [
            searchBar.leadingAnchor.constraint(equalTo: viewSearch.leadingAnchor, constant: 55),
            searchBar.trailingAnchor.constraint(equalTo: viewSearch.trailingAnchor, constant: -5),
            searchBar.topAnchor.constraint(equalTo: viewSearch.topAnchor),
            searchBar.heightAnchor.constraint(equalToConstant: 66)
        ]
        NSLayoutConstraint.activate(searchBarConstraint)
        
//        searchBar.frame = CGRect(x: 10, y: 100, width: view.width, height: viewSearch.heigth)

        
        let imgOvalConstraint = [
            imgOval.leadingAnchor.constraint(equalTo: viewSearch.leadingAnchor, constant: 10),
            imgOval.topAnchor.constraint(equalTo: viewSearch.topAnchor, constant: 10),
            imgOval.bottomAnchor.constraint(equalTo: viewSearch.bottomAnchor, constant: -10),
            imgOval.trailingAnchor.constraint(equalTo: searchBar.leadingAnchor, constant: 10)
        ]
        NSLayoutConstraint.activate(imgOvalConstraint)
        
        let iconsearchConstraint =
        [
            icon_search.centerXAnchor.constraint(equalTo: imgOval.centerXAnchor),
            icon_search.centerYAnchor.constraint(equalTo: imgOval.centerYAnchor),
            icon_search.widthAnchor.constraint(equalToConstant: 20),
            icon_search.heightAnchor.constraint(equalToConstant: 20)
        ]
        NSLayoutConstraint.activate(iconsearchConstraint)
        
    }

}
extension NewConversationViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = results[indexPath.row]["name"]
        cell.backgroundColor = UIColor(red: 228/255, green: 248/255, blue: 255/255, alpha: 1.0)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let targetUserData = results[indexPath.row]
        
        dismiss(animated: true, completion: { [weak self] in
                self?.completion?(targetUserData)
                })
       
    }
}

extension NewConversationViewController: UISearchBarDelegate
{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text, !text.replacingOccurrences(of: " ", with: "").isEmpty else
        {
            return
        }
        results.removeAll()
        spinner.show(in: view)
        self.searchUser(query: text)
        searchBar.resignFirstResponder()
    }
    
    func searchUser(query: String)
    {
        // check if array has firebase result
        if hasFetched{
            //if it does: filter
            filterUser(with: query)
        }
        else
        {
            DatabaseManager.shared.getAllUsers(completion: { [weak self] result in
                switch result{
                case .success(let userCollection):
                    self?.hasFetched = true
                    self?.users = userCollection
                    self?.filterUser(with: query)
                case .failure(let error):
                    print("Failed to get user: \(error)")
                }
            })
        }
    }
    
    func filterUser(with term: String)
    {
        guard hasFetched else
        {
            return
        }
        
        self.spinner.dismiss()
        
        let results: [[String: String]] = self.users.filter({
            guard let name = $0["name"]?.lowercased() else
            {
                return false
            }
            return name.hasPrefix(term.lowercased())
        })
        self.results = results
        UpdateUI()
    }
    
    func UpdateUI()
    {
        if results.isEmpty {
            self.noResultLabel.isHidden = false
            self.tableView.isHidden = true
        }
        else
        {
            self.noResultLabel.isHidden = true
            self.tableView.isHidden = false
            self.tableView.reloadData()
        }
    }
}
