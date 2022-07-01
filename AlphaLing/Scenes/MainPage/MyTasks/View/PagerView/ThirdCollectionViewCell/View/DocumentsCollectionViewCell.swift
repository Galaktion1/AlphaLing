//
//  DocumentsCollectionViewCell.swift
//  AlphaLing
//
//  Created by Gaga Nizharadze on 16.06.22.
//

import UIKit

protocol DocumentsCollectionViewCellDelegate {
    func downloadFile(with url: URL)
    func imageOrFileUploadActionSheet()
}

class DocumentsCollectionViewCell: UICollectionViewCell {
        
    
    @IBAction func fileUploadButton(_ sender: UIButton) {
        delegate?.imageOrFileUploadActionSheet()
        
    }
    
    
    @IBOutlet weak var tableView: UITableView!
    
    let viewModel = FetchDocumentsViewModel()
    
    var delegate: DocumentsCollectionViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        loadNewDocuments()
        
        tableView.register(UploadedFilesTableViewCell.nib(), forCellReuseIdentifier: UploadedFilesTableViewCell.identifier)
        // Initialization code
        
        
        viewModel.reloadTableView = {
            self.tableView.reloadData()
        }
    }
    
    private func loadNewDocuments() {
        viewModel.fetchDocumentsData()
    }
    
}

extension DocumentsCollectionViewCell: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        90.0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    

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
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = viewModel.cellForRowAt(indexPath: indexPath)
        
        guard let url = URL(string: "https://alphatest.webmitplan.de/" + (data.fileKey ?? "")) else { return }
        
        delegate?.downloadFile(with: url)
        
//        FileDownloader.loadFileAsync(url: url) { (path, error) in
//            print("PDF File downloaded to : \(path!)")
//        }
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UploadedFilesTableViewCell", for: indexPath) as! UploadedFilesTableViewCell
        
        let data = viewModel.cellForRowAt(indexPath: indexPath)
        cell.updateCells(documentsInfo: data)
        
        return cell
    }
}

extension PagerViewViewController: DocumentsCollectionViewCellDelegate {
    
    func downloadFile(with url: URL) {
        
        let alert = UIAlertController(title: "Download", message: "Do you really want to download this?", preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "Download", style: .default, handler: { (_) in
            
            FileDownloader.loadFileAsync(url: url) { (path, error) in
                print("PDF File downloaded to : \(path!)")
            }
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: { (_) in
            print("User click Dismiss button")
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func imageOrFileUploadActionSheet() {
        let alert = UIAlertController(title: "UPLOAD", message: "Please Select an Option", preferredStyle: .actionSheet)
        
        
        alert.addAction(UIAlertAction(title: "Image upload", style: .default, handler: { (_) in
            
            let vc = UIImagePickerController()
            vc.sourceType = .photoLibrary
            vc.delegate = self
            vc.allowsEditing = true
            self.present(vc, animated: true)
            
           
        }))
        
        alert.addAction(UIAlertAction(title: "File upload", style: .default, handler: { (_) in
            
            
            
        }))
        
        
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (_) in
            print("User click Dismiss button")
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
}


extension PagerViewViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage else { return }
        
        let uploadImage = FetchDocumentsViewModel()
        
        uploadImage.requestNativeImageUpload(image: image)
        
        picker.dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}

