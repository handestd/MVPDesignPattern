//
//  ViewController.swift
//  MVPDesignPattern
//
//  Created by Dat, Dinh Tien on 29/09/2022.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UserPresenterDelegate {
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    private var users = [User]()
    private let presenter = UserPresenter()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        title = "Users"

        // Table
        
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
        // Presenter
        presenter.setViewDelegate(delegate: self)
        presenter.getUsers()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = users[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        // ask the presenter to handle the tap
        
        presenter.didTabUser(user: users[indexPath.row])
        
        
    }
    // Presenter Delegate
    
    func presentUsers(users: [User]) {
        self.users = users
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func presentAlert(title: String, message: String) {
       // delegate?.present(alert, animated: true)
    }
    
}

