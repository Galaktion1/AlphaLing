//
//  MyTasksViewController.swift
//  AlphaLing
//
//  Created by Gaga Nizharadze on 01.06.22.
//

import UIKit

class MyTasksViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var myTaskApiService = MyTaskApiService()
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadMyTaskData()
        
    }
    
    
    
    private func loadMyTaskData() {
        viewModel.fetchMyTasksData()
    }
    
    
}

extension MyTasksViewController: UITableViewDelegate, UITableViewDataSource  {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    // There is just one row in every section
    
    
    // Set the spacing between sections
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return cellSpacingHeight
    }
    
    // Make the background color show through
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = ViewPagerViewController()
        
//        let mainView = MainView()
        let data = viewModel.cellForRowAt(indexPath: indexPath)
        
        vc.data = data
        
//        let pagedView = PagedView()
        
        
//        mainView.updateMainUIView(data: data)
        
//
//
//        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
//            pagedView.collectionView.reloadData()
//        }
        
//        mainView.nameTitleLabel?.text = data.title ?? "None"
//        mainView.timeLabel?.text = data.taskTime ?? "None"
//        mainView.baseLabel?.text = data.baseTaskKey ?? "None"
//        mainView.dateLabel?.text = data.taskDate ?? "None"
//        mainView.customerNameLabel.text = data.singleEditor
        
        
        
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

