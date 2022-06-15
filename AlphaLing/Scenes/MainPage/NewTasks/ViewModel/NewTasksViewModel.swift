//
//  NewTasksViewModel.swift
//  AlphaLing
//
//  Created by Gaga Nizharadze on 09.06.22.
//

import Foundation
import UIKit

class NewTasksViewModel {
    
    private var apiService = TaskApiService(linkSnippet: "my-new")
    var reloadTableView: (()->Void)?
    private var userInfo = [TaskData](){
        didSet {
            self.reloadTableView?()
        }
    }
    
    func fetchMyTasksData() {
        apiService.getMyTasksData { [weak self] (result) in
            switch result {
            case .success(let listOf):
                print("succesful retrived data")
                self?.userInfo = listOf.data!
            case .failure(let error):
                print("error processing json data \(error)")
            }
        }
    }
    
    func numberOfRowsInSection() -> Int {
        userInfo.count != 0 ? userInfo.count :0
        
        
    }
    func cellForRowAt (indexPath: IndexPath) -> TaskData {
        userInfo[indexPath.section]
    }

}
