//
//  CommentsTableViewCell.swift
//  AlphaLing
//
//  Created by Gaga Nizharadze on 14.06.22.
//

import UIKit

class CommentsTableViewCell: UITableViewCell {

    @IBOutlet weak var authorLabel: UILabel!
    
    @IBOutlet weak var messageTextLabel: UILabel!
    
    static let identifier = "CommentsTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "CommentsTableViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
