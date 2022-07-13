//
//  ActivityCollectionViewCell.swift
//  AlphaLing
//
//  Created by Gaga Nizharadze on 16.06.22.
//

import UIKit

protocol ActivityCollectionViewCellDelegate {
    func mustPresentAlert(info: TimeTrackingModel, cell: UICollectionViewCell)
    func mustPresentNewScheduleAlert(cell: UICollectionViewCell)
    
}

class ActivityCollectionViewCell: UICollectionViewCell {
  
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var plusButtonBackgroundView: UIView!
    var delegate: ActivityCollectionViewCellDelegate?
    
    var newModel: TimeTrackingModel! {
        didSet {
            activityInfo.append(newModel)
        }
    }
   
    
    
    var activityInfo = [TimeTrackingModel?] () {
        didSet {
            self.tableView?.reloadData()
        }
    }
    
    @IBAction func plusButton(_ sender: UIButton) {
        delegate?.mustPresentNewScheduleAlert(cell: self)
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        tableView.delegate = self
        tableView.dataSource = self
        fetchTimeTrackingData()
        plusButtonBackgroundView.layer.cornerRadius = plusButtonBackgroundView.frame.width / 2
        
        tableView.register(ScheduleTableViewCell.nib(), forCellReuseIdentifier: ScheduleTableViewCell.identifier)
        
    }
    
    func fetchTimeTrackingData() {
        let apiService = TimeTrackingApiService()
        
        apiService.getTimeTrackingData { [weak self] (result) in
            switch result {
                
            case .success(let listOf):
                print("succesful retrived timetracking data")
                self?.activityInfo = listOf
         
            case .failure(let error):
                print("error processing json data \(error)")
            }
        }
        
    }
    

}

extension ActivityCollectionViewCell: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        110.0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        activityInfo.count
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
    
    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
        
        ScheduleDelete.shared.deleteApiCall(id: activityInfo[indexPath.section]?.id ?? 0)
        
        if editingStyle == .delete {
            self.activityInfo.remove(at: indexPath.section)
            
        }
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let info = activityInfo[indexPath.section]!
        
        delegate?.mustPresentAlert(info: info, cell: self)
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ScheduleTableViewCell", for: indexPath) as! ScheduleTableViewCell
        
        let data = activityInfo[indexPath.section]!
        cell.updateCells(scheduleInfo: data)
        return cell
    }
}

