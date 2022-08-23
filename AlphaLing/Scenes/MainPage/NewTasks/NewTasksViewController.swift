//
//  NewTasksViewController.swift
//  AlphaLing
//
//  Created by Gaga Nizharadze on 01.06.22.
//

import UIKit

class NewTasksViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private var viewModel = NewTasksViewModel()
    
    let cellSpacingHeight: CGFloat = 0
    
    let refreshControl = UIRefreshControl()
    
    let label = EmptyColllectionExtension.shared.centerLabel(text: "There are no new tasks 🌐")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadNewTaskData()
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
  
   
    private func loadNewTaskData() {
        viewModel.fetchNewTasksData(view: view)
    }

    @objc func refresh(_ sender: AnyObject) {
        loadNewTaskData()
        presentEmptyTasksNotifyLabel()
        refreshControl.endRefreshing()
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

extension NewTasksViewController: UITableViewDelegate, UITableViewDataSource  {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 100.0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.numberOfRowsInSection()
        }
        
        // There is just one row in every section
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            1
        }
        
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
        
        
        
        let sb = UIStoryboard(name: "NewTasksPageStoryboard", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "NewTaskPageVC") as! NewTaskPageVC
        
        let data = viewModel.cellForRowAt(indexPath: indexPath)
        UserDefaults.standard.set(data.taskUsers?[0].id, forKey: "ID")
        
        UserDefaults.standard.setValue(indexPath.section, forKey: "numberOfSectionTappedInMyTask")
        
        vc.data = data
        
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyTasksTableViewCell", for: indexPath) as! MyTasksTableViewCell
        
        cell.configureRedCells()
        
        let data = viewModel.cellForRowAt(indexPath: indexPath)
        cell.updateCells(userInfo: data)
        
        return cell
    }
 
}
