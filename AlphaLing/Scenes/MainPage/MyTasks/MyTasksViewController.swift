//
//  MyTasksViewController.swift
//  AlphaLing
//
//  Created by Gaga Nizharadze on 01.06.22.
//

import UIKit

class MyTasksViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var myTaskApiService = TaskApiService(linkSnippet: "my")
    
    private var viewModel = MyTasksViewModel()
    
    let refreshControl = UIRefreshControl()
    let label = EmptyColllectionExtension.shared.centerLabel(text: "My tasks are empty 🌐")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadMyTaskData()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        tableView.delegate = self
        tableView.dataSource = self
        
        
        tableView.register(MyTasksTableViewCell.nib(), forCellReuseIdentifier: MyTasksTableViewCell.identifier)
        
        viewModel.reloadTableView = { [weak self] in
            self?.tableView.reloadData()
            self?.presentEmptyTasksNotifyLabel()
        }
        
        refreshControl.attributedTitle = NSAttributedString(string: "Loading...")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl) // not required when using UITableViewController
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        checkInternetConnection()
    }
    
    
    @objc func refresh(_ sender: AnyObject) {
        loadMyTaskData()
        presentEmptyTasksNotifyLabel()
        refreshControl.endRefreshing()
    }
    
    private func checkInternetConnection() {
        if !Reachability.isConnectedToNetwork() {
            self.showAlert(alertText: "Internet connection fault", alertMessage: "Internet Connection not Available", addActionTitle: "Ok")
        }
    }
    
    func loadMyTaskData() {
        viewModel.fetchMyTasksData(myTastView: view)
    }
    
    private func presentEmptyTasksNotifyLabel() {
        if viewModel.numberOfRowsInSection() == 0 {
            tableView.addSubview(label)
            label.topAnchor.constraint(equalTo: tableView.topAnchor, constant: (tableView.frame.height / 2) - 20).isActive = true
            label.centerXAnchor.constraint(equalTo: tableView.centerXAnchor).isActive = true
        } else {
            label.removeFromSuperview()
        }
    }
    
}

extension MyTasksViewController: UITableViewDelegate, UITableViewDataSource  {
    
    private struct TableViewConstants {
        static let cellSpacingHeight: CGFloat = 0
        static let heightForRowAt: CGFloat = 100.0
        static let numberOfRowsInSection: Int = 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        TableViewConstants.heightForRowAt
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        TableViewConstants.numberOfRowsInSection
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        TableViewConstants.cellSpacingHeight
    }
    
    // Make the background color show through
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let sb = UIStoryboard(name: "PagerViewStoryboard", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "PagerViewViewController") as! PagerViewViewController
        
        UserDefaults.standard.setValue(indexPath.section, forKey: "numberOfSectionTappedInMyTask")
        
        let data = viewModel.cellForRowAt(indexPath: indexPath)
        vc.data = data
        
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyTasksTableViewCell", for: indexPath) as! MyTasksTableViewCell
        
        let data = viewModel.cellForRowAt(indexPath: indexPath)
        cell.updateCells(userInfo: data)
        
        return cell
    }
}

