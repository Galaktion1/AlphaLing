//
//  MyTasksViewModel.swift
//  AlphaLing
//
//  Created by Gaga Nizharadze on 01.06.22.
//

import Foundation

class MyTasksViewModel {
    private var apiService = MyTaskApiService()
    var reloadTableView: (()->Void)?
    var reloadCollectionView: (()->Void)?
    private var userInfo = [MyTasksData](){
        didSet {
            self.reloadTableView?()
            self.reloadCollectionView?()
        }
    }
    
    func fetchMyTasksData() {
        apiService.getMyTasksData { [weak self] (result) in
            switch result {
            
            case .success(let listOf):
                print("succesful retrived data")
                self?.userInfo = listOf.data!
//                print(listOf.data ?? "mhbgjhghbjk")
            case .failure(let error):
                print("error processing json data \(error)")
            }
        }
    }
    
    func numberOfRowsInSection() -> Int {
        if userInfo.count != 0 {
            return userInfo.count
        }
        else {  return 0 }
        
        
    }
    func cellForRowAt (indexPath: IndexPath) -> MyTasksData {
        return userInfo[indexPath.row]
    }
    
}
