//
//  UploadedFilesTableViewCell.swift
//  AlphaLing
//
//  Created by Gaga Nizharadze on 16.06.22.
//

import UIKit

class UploadedFilesTableViewCell: UITableViewCell {
    

    @IBOutlet weak var nameOfFileLabel: UILabel!
    
    @IBOutlet weak var sizeOfFileLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    static let identifier = "UploadedFilesTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "UploadedFilesTableViewCell", bundle: nil)
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
    
    func updateCells(documentsInfo: DocumentFetchingResponseModel) {
        let date = (documentsInfo.modifiedAt ?? "0000-00-00T00:00").prefix(16).replacingOccurrences(of: "T", with: " ")
        var docSize = String()
        if ((documentsInfo.size ?? 0) / 1000000) > 0 {
            docSize = "\((documentsInfo.size ?? 0) / 1000000)MB"
        } else {
            docSize = "\((documentsInfo.size ?? 0) / 1000)KB"
        }
        
        updateUI(nameOfFile: documentsInfo.filename ?? "Unnamed", sizeOfFile: "\(docSize) \(date)")
    }
    
    
    private func updateUI(nameOfFile: String, sizeOfFile: String) {
        self.nameOfFileLabel.text = nameOfFile
        self.sizeOfFileLabel.text = sizeOfFile
    }
    
}
    

