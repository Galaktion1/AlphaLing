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
    
    let cellSpacingHeight: CGFloat = 10
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadMyTaskData()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        tableView.delegate = self
        tableView.dataSource = self
        
        
        tableView.register(MyTasksTableViewCell.nib(), forCellReuseIdentifier: MyTasksTableViewCell.identifier)
        
        viewModel.reloadTableView = {
            self.tableView.reloadData()
        }
    }
    
    
    
    
    private func loadMyTaskData() {
        viewModel.fetchMyTasksData()
    }
    
    
}

extension MyTasksViewController: UITableViewDelegate, UITableViewDataSource  {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100.0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    // There is just one row in every section
    
    
    // Set the spacing between sections
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        cellSpacingHeight
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

