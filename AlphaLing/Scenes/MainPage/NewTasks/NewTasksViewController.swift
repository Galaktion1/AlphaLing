//
//  NewTasksViewController.swift
//  AlphaLing
//
//  Created by Gaga Nizharadze on 01.06.22.
//

import UIKit

class NewTasksViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let cellSpacingHeight: CGFloat = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(MyTasksTableViewCell.nib(), forCellReuseIdentifier: MyTasksTableViewCell.identifier)
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension NewTasksViewController: UITableViewDelegate, UITableViewDataSource  {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 100.0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5 //viewModel.numberOfRowsInSection(section: section)
        }
        
        // There is just one row in every section
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 1 //viewModel.numberOfRowsInSection(section: section)
        }
        
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
        let sb = UIStoryboard(name: "NewTasksPageStoryboard", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "NewTaskPageVC")
        
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyTasksTableViewCell", for: indexPath) as! MyTasksTableViewCell
       
//        let data = viewModel.cellForRowAt(indexPath: indexPath)
//        cell.setCellWithValuesOf(data)
        cell.configureRedCells()
        
        return cell
    }

    
 
}
