//
//  PagerViewViewController.swift
//  AlphaLing
//
//  Created by Gaga Nizharadze on 08.06.22.
//

import UIKit

class PagerViewViewController: UIViewController {
    

    @IBOutlet weak var collectionView: UICollectionView!
    
    let viewModel = MyTasksViewModel()
    var data: TaskData?
    
    
    private func encodeDataToDescription() -> String?{
        let encoder = JSONEncoder()
        
        guard let data = data else { return nil }

        encoder.keyEncodingStrategy = .convertToSnakeCase

        let description = String(data: try! encoder.encode(data.descriptions), encoding: .utf8)!
//        print(description)
        
//        var string = "<!DOCTYPE html> <html> <body> <h1>My First Heading</h1> <p>My first paragraph.</p> </body> </html>"
        
//        let str = description.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
        
        return description.removeHtmlTags()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.delegate = self
        collectionView?.dataSource = self
        
        collectionView.register(UINib(nibName: "PagerViewMainCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PagerViewMainCollectionViewCell")
        
        collectionView.register(UINib(nibName: "ActivityCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ActivityCollectionViewCell")
        
        collectionView.register(UINib(nibName: "DocumentsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "DocumentsCollectionViewCell")
        
        
    
        
    }
    

}

extension PagerViewViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
        
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.row {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PagerViewMainCollectionViewCell", for: indexPath) as! PagerViewMainCollectionViewCell
            cell.updateMainUIView(data: data!)
            
            if UserDefaults.standard.value(forKey: "ID") == nil {
                
                if let id = data?.taskUsers?[0].id {
                    UserDefaults.standard.set(id, forKey: "ID")
                    print(id)
                }
                
                if let taskID = data?.taskUsers?[0].taskID {
                    UserDefaults.standard.set(taskID, forKey: "taskID")
                    print(taskID)
                }
            }
            
            cell.delegate = self
            
            return cell
            
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ActivityCollectionViewCell", for: indexPath) as! ActivityCollectionViewCell
            
            return cell
        
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DocumentsCollectionViewCell", for: indexPath) as! DocumentsCollectionViewCell
            
            return cell
            
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PagerViewMainCollectionViewCell", for: indexPath) as! PagerViewMainCollectionViewCell
            return cell
        }
    }
    
}


extension PagerViewViewController: PagerViewMainCollectionViewCellDelegate {
    func mustPresent(comments: [Comment]) {
        let sb = UIStoryboard(name: "Comments", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "CommentsViewController") as! CommentsViewController

        vc.comments = comments

//        print(comments[0].userOutputName ?? "")

        self.present(vc, animated: true, completion: nil)
    }
}