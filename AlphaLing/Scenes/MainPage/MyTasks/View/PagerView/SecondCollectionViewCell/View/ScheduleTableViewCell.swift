//
//  ScheduleTableViewCell.swift
//  AlphaLing
//
//  Created by Gaga Nizharadze on 16.06.22.
//

import UIKit

class ScheduleTableViewCell: UITableViewCell {

    @IBOutlet weak var startLabel: UILabel!
    
    @IBOutlet weak var endLabel: UILabel!
    
    @IBOutlet weak var noteLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    static let identifier = "ScheduleTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "ScheduleTableViewCell", bundle: nil)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = 25
        self.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func updateCells(scheduleInfo: TimeTrackingModel) {
        
        guard let startTime = scheduleInfo.startedAt else { return }
        guard let endTime = scheduleInfo.endedAt else { return }
        updateUI(start: "Start: \(startTime.prefix(10)) \(startTime[11 ... 15])", end: "End: \(endTime.prefix(10)) \(endTime[11 ... 15])", note: scheduleInfo.note ?? "")
    }
    
    private func updateUI(start: String, end: String, note: String) {
        self.startLabel.text = start
        self.endLabel.text = end
        self.noteLabel.text = note
    }
    
}

