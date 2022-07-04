//
//  PagerViewViewController.swift
//  AlphaLing
//
//  Created by Gaga Nizharadze on 08.06.22.
//

import UIKit

class PagerViewViewController: UIViewController {
    
    let viewModel = MyTasksViewModel()
    var data: TaskData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.delegate = self
        collectionView?.dataSource = self
        
        
        collectionView.register(UINib(nibName: "PagerViewMainCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PagerViewMainCollectionViewCell")
        
        collectionView.register(UINib(nibName: "ActivityCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ActivityCollectionViewCell")
        
        collectionView.register(UINib(nibName: "DocumentsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "DocumentsCollectionViewCell")
        
        confHorizontalStackView()
        confVerticalStackView()
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private func moveToNextCollectionViewCell(item: Int) {
        collectionView.isPagingEnabled = false
        
        collectionView.scrollToItem(
            at: IndexPath(item: item, section: 0),
            at: .centeredHorizontally,
            animated: true
        )
        collectionView.isPagingEnabled = true
    }
    
    @IBAction func mainButton(_ sender: UIButton) {
        moveToNextCollectionViewCell(item: 0)
    }
    
    
    @IBAction func activityButton(_ sender: UIButton) {
        moveToNextCollectionViewCell(item: 1)
    }
    
    
    @IBAction func documentsButton(_ sender: UIButton) {
        moveToNextCollectionViewCell(item: 2)
    }
    
    
    
    private func encodeDataToDescription() -> String?{
        let encoder = JSONEncoder()
        
        guard let data = data else { return nil }

        encoder.keyEncodingStrategy = .convertToSnakeCase

        let description = String(data: try! encoder.encode(data.descriptions), encoding: .utf8)!
//        print(description)
        
        return description.removeHtmlTags()
    }
    
    
    let EntireVerticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillProportionally
        stackView.axis = .vertical
        stackView.spacing = 1
        
        return stackView
    }()
    
    let startHorizontalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillProportionally
        stackView.axis = .horizontal
        stackView.spacing = 0
        
        return stackView
    }()
    
    let endHorizontalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillProportionally
        stackView.axis = .horizontal
        stackView.spacing = 0
        
        return stackView
    }()
    
    
    let startDatePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.timeZone = NSTimeZone.local
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.heightAnchor.constraint(equalToConstant: 40).isActive = true
        datePicker.locale = NSLocale(localeIdentifier: "en_GB") as Locale
        
        
        return datePicker
    }()
    
    let endDatePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.timeZone = NSTimeZone.local
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.heightAnchor.constraint(equalToConstant: 40).isActive = true
        datePicker.locale = NSLocale(localeIdentifier: "en_GB") as Locale
        
        return datePicker
    }()
    
    let textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Leave Note Here"
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.setLeftPaddingPoints(15)
        
        return textField
    }()
    
    let startLabel: UILabel = {
        let label = UILabel()
        label.text = " Start At:"
        label.font.withSize(11)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.heightAnchor.constraint(equalToConstant: 50).isActive = true
        label.textColor = UIColor(named: "specialBlue")
        
        return label
    }()
    
    let endLabel: UILabel = {
        let label = UILabel()
        label.text = " End At:"
        label.font.withSize(11)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.heightAnchor.constraint(equalToConstant: 50).isActive = true
        label.textColor = UIColor(named: "specialBlue")
        
        return label
    }()
    
    let whiteView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        return view
    }()
    
    let topView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 15).isActive = true
        return view
    }()
    
    func confHorizontalStackView() {
        startHorizontalStackView.frame = CGRect(x: 0, y: 0, width: 267, height: 50)
        startHorizontalStackView.addArrangedSubview(startLabel)
        startHorizontalStackView.addArrangedSubview(startDatePicker)
        
        endHorizontalStackView.frame = CGRect(x: 0, y: 0, width: 267, height: 50)
        endHorizontalStackView.addArrangedSubview(endLabel)
        endHorizontalStackView.addArrangedSubview(endDatePicker)
    }
    
    func confVerticalStackView() {
        EntireVerticalStackView.frame = CGRect(x: 0, y: 00, width: 267, height: 230)
        EntireVerticalStackView.addArrangedSubview(topView)
        EntireVerticalStackView.addArrangedSubview(startHorizontalStackView)
        EntireVerticalStackView.addArrangedSubview(whiteView)
        EntireVerticalStackView.addArrangedSubview(endHorizontalStackView)

        EntireVerticalStackView.addArrangedSubview(textField)
        
    }
    

}

extension PagerViewViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
        
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.row {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PagerViewMainCollectionViewCell", for: indexPath) as! PagerViewMainCollectionViewCell
            cell.updateMainUIView(data: data!)
            
            cell.delegate = self
            
            return cell
            
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ActivityCollectionViewCell", for: indexPath) as! ActivityCollectionViewCell
            
            cell.delegate = self
            
            return cell
        
        case 3:
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DocumentsCollectionViewCell", for: indexPath) as! DocumentsCollectionViewCell
            
            cell.delegate = self
            
            return cell

            
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DocumentsCollectionViewCell", for: indexPath) as! DocumentsCollectionViewCell
            
            cell.delegate = self
            
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


extension PagerViewViewController: ActivityCollectionViewCellDelegate {
    func mustPresentNewScheduleAlert() {
        let startedAtTime: String = "\(startDatePicker.date)"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        let startDate = dateFormatter.date(from: startedAtTime)
        
        let endedAtTime: String = "\(endDatePicker.date)"
        let endDate = dateFormatter.date(from: endedAtTime)
        
        
        if let startDate = startDate {
            startDatePicker.setDate(startDate, animated: true)
        }
        
        if let endDate = endDate {
            endDatePicker.setDate(endDate, animated: true)
        }
        
        let alertController = UIAlertController(title: "\n\n\n\n\n\n\n\n", message: nil, preferredStyle: UIAlertController.Style.alert)
        
        alertController.view.addSubview(EntireVerticalStackView)

        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.destructive, handler: nil)
        let somethingAction = UIAlertAction(title: "Save", style: UIAlertAction.Style.default, handler: {  _ in
           

            NewShedule.shared.newScheduleCall(taskId: (UserDefaults.standard.value(forKey: "taskID") ?? 0) as! Int,
                                              taskUserId: (UserDefaults.standard.value(forKey: "ID") ?? 0) as! Int,
                                              note: self.textField.text ?? "",
                                              billable: true,
                                              startedAt: "\(self.startDatePicker.date)",
                                              endedAt: "\(self.endDatePicker.date)") { result in
//                print(result)
            }
            
        })
        alertController.addAction(somethingAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    
    func mustPresentAlert(info: TimeTrackingModel) {
        
        let startedAtTime: String = "\(info.startedAt?[0 ... 9] ?? "0000-00-00") \(info.startedAt?[11 ... 15] ?? "00:00")"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        let startDate = dateFormatter.date(from: startedAtTime)
        
        let endedAtTime: String = "\(info.endedAt?[0 ... 9] ?? "0000-00-00") \(info.endedAt?[11 ... 15] ?? "00:00")"
        let endDate = dateFormatter.date(from: endedAtTime)
        
        
        if let startDate = startDate {
            startDatePicker.setDate(startDate, animated: true)
        }
        
        if let endDate = endDate {
            endDatePicker.setDate(endDate, animated: true)
        }
        
        let alertController = UIAlertController(title: "\n\n\n\n\n\n\n\n", message: nil, preferredStyle: UIAlertController.Style.alert)
        
        alertController.view.addSubview(EntireVerticalStackView)

        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.destructive, handler: nil)
        let somethingAction = UIAlertAction(title: "Save", style: UIAlertAction.Style.default, handler: { [self] _ in
           
            ScheduleUpdateAPICall.shared.patchApiCall(
                id: info.id ?? 0,
                taskId: info.taskID ?? 0,
                taskUserId: info.taskUserID ?? 0,
                note: textField.text ?? "",
                billable: info.billable ?? false,
                startedAt: "\(self.startDatePicker.date)",
                endedAt: "\(self.endDatePicker.date)"
            ) { result in
                switch result {
                    
                case .success(_):
//                    print(final)
                    print("success while patch")
                case .failure(_):
                    print("errror while patch")
                }
                
            }
            
        })
        alertController.addAction(somethingAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
}





