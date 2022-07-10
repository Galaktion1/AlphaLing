//
//  ActivityCollectionViewCell.swift
//  AlphaLing
//
//  Created by Gaga Nizharadze on 16.06.22.
//

import UIKit

protocol ActivityCollectionViewCellDelegate {
    func mustPresentAlert(info: TimeTrackingModel)
    func mustPresentNewScheduleAlert()
    
}

class ActivityCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var plusButtonBackgroundView: UIView!
    private let viewModel = TimeTrackingViewModel()
    
    var delegate: ActivityCollectionViewCellDelegate?
    
    var activityInfo = [TimeTrackingModel?]()
    
    @IBAction func plusButton(_ sender: UIButton) {
        delegate?.mustPresentNewScheduleAlert()
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        tableView.delegate = self
        tableView.dataSource = self
        loadNewTaskData()
        plusButtonBackgroundView.layer.cornerRadius = plusButtonBackgroundView.frame.width / 2
        
        
        tableView.register(ScheduleTableViewCell.nib(), forCellReuseIdentifier: ScheduleTableViewCell.identifier)
        
        viewModel.reloadTableView = {
            self.tableView.reloadData()
        }
        
        
    }
    
    private func loadNewTaskData() {
        viewModel.fetchTimeTrackingData()
    }

}

extension ActivityCollectionViewCell: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        110.0
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
        10
    }
    
    // Make the background color show through
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {

            ScheduleDelete.shared.deleteApiCall(id: viewModel.getActivityInfo()[indexPath.section]?.id ?? 0) { _ in
                let viewModel = TimeTrackingViewModel()
                viewModel.activityInfo.remove(at: indexPath.section)
                
                self.tableView.beginUpdates()
                self.tableView.deleteRows(at: [indexPath], with: .automatic)
                self.tableView.endUpdates()
            }
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let info = viewModel.cellForRowAt(indexPath: indexPath)
        
        delegate?.mustPresentAlert(info: info)
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ScheduleTableViewCell", for: indexPath) as! ScheduleTableViewCell
        
        let data = viewModel.cellForRowAt(indexPath: indexPath)
        cell.updateCells(scheduleInfo: data)
        return cell
    }
    
    
}

