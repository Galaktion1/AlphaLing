//
//  MyTasksTableViewCell.swift
//  AlphaLing
//
//  Created by Gaga Nizharadze on 01.06.22.
//

import UIKit

class MyTasksTableViewCell: UITableViewCell {

    @IBOutlet weak var senderLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var docIconImage: UIImageView!
    
    @IBOutlet weak var docIconBackgroundView: UIView!
    
    static let identifier = "MyTasksTableViewCell"
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "MyTasksTableViewCell", bundle: nil)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = 25
        self.layer.masksToBounds = true
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
    func configureRedCells() {
        
        senderLabel.text = "Dolmetschen vor Ort Litauisch"
        dateLabel.text = "2021-09-02"
        timeLabel.text = "23:00 - 23:45"
        
        docIconImage.image = UIImage(systemName: "doc")?.withRenderingMode(.alwaysTemplate)
        
        docIconImage.tintColor = .systemPink
        docIconImage.backgroundColor = UIColor(named: "redDocBackgroundColor")
        
        docIconBackgroundView.backgroundColor = UIColor(named: "redDocBackgroundColor")
  
    }
    
    
    func updateCells(userInfo: TaskData) {
        updateUI(title: userInfo.title?.de ?? "no info", date: "\(userInfo.taskDate ?? "")", time: "\(userInfo.taskTime ?? "")")
    }
    
    private func updateUI(title: String, date: String, time: String) {
        self.senderLabel.text = title
        self.dateLabel.text = date
        self.timeLabel.text = time
    }
    
}
