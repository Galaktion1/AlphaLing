//
//  PagerViewViewController.swift
//  AlphaLing
//
//  Created by Gaga Nizharadze on 08.06.22.
//

import UIKit

class PagerViewViewController: UIViewController {
    
    @IBOutlet weak var mainButtonOutlet: UIButton!
    @IBOutlet weak var activityButtonOutlet: UIButton!
    @IBOutlet weak var documentButtonOutlet: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var activeIndicatorView: UIView!
    
    let viewModel = MyTasksViewModel()
    var data: TaskData?
    private let screenWidt = UIScreen.main.bounds.width
    
    var documentsCell: UICollectionViewCell!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.delegate = self
        collectionView?.dataSource = self
        
        self.tabBarController?.tabBar.isHidden = true
        
        collectionView.register(UINib(nibName: "PagerViewMainCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PagerViewMainCollectionViewCell")
        
        collectionView.register(UINib(nibName: "ActivityCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ActivityCollectionViewCell")
        
        collectionView.register(UINib(nibName: "DocumentsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "DocumentsCollectionViewCell")
        
        confHorizontalStackView()
        confVerticalStackView()
        activeIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        viewModel.activeButton(button: mainButtonOutlet, button1: activityButtonOutlet, button2: documentButtonOutlet)
        
        textField.delegate = self
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    
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
        viewModel.activeButton(button: mainButtonOutlet, button1: documentButtonOutlet, button2: activityButtonOutlet)
        moveToNextCollectionViewCell(item: 0)
        viewModel.moveActiviveIndicatorView(point: 0, indicatorView: self.activeIndicatorView)
    }
    
    
    @IBAction func activityButton(_ sender: UIButton) {
        viewModel.activeButton(button: activityButtonOutlet, button1: documentButtonOutlet, button2: mainButtonOutlet)
        moveToNextCollectionViewCell(item: 1)
        viewModel.moveActiviveIndicatorView(point: screenWidt / 3, indicatorView: self.activeIndicatorView)
    }
    
    
    @IBAction func documentsButton(_ sender: UIButton) {
        viewModel.activeButton(button: documentButtonOutlet, button1: mainButtonOutlet, button2: activityButtonOutlet)
        moveToNextCollectionViewCell(item: 2)
        viewModel.moveActiviveIndicatorView(point: screenWidt * 2 / 3, indicatorView: self.activeIndicatorView)
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
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.spacing = 0
        
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
        datePicker.locale = NSLocale(localeIdentifier: "en_GB") as Locale
        
        return datePicker
    }()
    
    let endDatePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.timeZone = NSTimeZone.local
        datePicker.locale = NSLocale(localeIdentifier: "en_GB") as Locale
        
        return datePicker
    }()
    
    let textField: UITextField = {
        let textField = UITextField()
        
        textField.placeholder = "Leave Note Here"
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.widthAnchor.constraint(equalToConstant: 267).isActive = true
        textField.clearButtonMode = .always
        textField.setLeftPaddingPoints(15)
        textField.returnKeyType = .done
        return textField
    }()
    
    let startLabel: UILabel = {
        let label = UILabel()
        label.text = "   Start:"
        label.font.withSize(15)
        label.textAlignment = .center
        label.textColor = UIColor(named: "specialBlue")
        
        return label
    }()
    
    let endLabel: UILabel = {
        let label = UILabel()
        label.text = "   End:"
        label.font.withSize(15)
        label.textAlignment = .center
        label.textColor = UIColor(named: "specialBlue")
        
        return label
    }()
    
    let verticalStackViewForCheckBoxAndTexxtField: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 5
        stackView.distribution = .fill
        
        return stackView
    }()
    
    let billableLeabel: UILabel = {
        let label = UILabel()
        label.text = "Billable"
        label.font = .systemFont(ofSize: 15)
        
        return label
    }()
    
    private lazy var checkBoxButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 20).isActive = true
        button.widthAnchor.constraint(equalToConstant: 20).isActive = true
        button.setBackgroundImage(UIImage(named: "UnCheckbox")!, for: .normal)
        button.addTarget(self, action: #selector(checkBoxAction), for: .touchUpInside)
        
        return button
    }()
    
    let horizontalStackViewForCheckBoxButton: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 7
        
        return stackView
    }()
    
    let whiteView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.widthAnchor.constraint(equalToConstant: 5).isActive = true
        
        return view
    }()
    
    
    func confHorizontalStackView() {
        startHorizontalStackView.frame = CGRect(x: 0, y: 0, width: 267, height: 50)
        startHorizontalStackView.addArrangedSubview(startLabel)
        startHorizontalStackView.addArrangedSubview(startDatePicker)
        
        endHorizontalStackView.frame = CGRect(x: 0, y: 0, width: 267, height: 50)
        endHorizontalStackView.addArrangedSubview(endLabel)
        endHorizontalStackView.addArrangedSubview(endDatePicker)
        
        verticalStackViewForCheckBoxAndTexxtField.frame = CGRect(x: 0, y: 0, width: 267, height: 50)
        
        horizontalStackViewForCheckBoxButton.addArrangedSubview(whiteView)
        horizontalStackViewForCheckBoxButton.addArrangedSubview(checkBoxButton)
        horizontalStackViewForCheckBoxButton.addArrangedSubview(billableLeabel)
        verticalStackViewForCheckBoxAndTexxtField.addArrangedSubview(horizontalStackViewForCheckBoxButton)
        verticalStackViewForCheckBoxAndTexxtField.addArrangedSubview(textField)
    }
    
    func confVerticalStackView() {
        EntireVerticalStackView.frame = CGRect(x: 0, y: 00, width: 267, height: 220)
        EntireVerticalStackView.addArrangedSubview(startHorizontalStackView)
        EntireVerticalStackView.addArrangedSubview(endHorizontalStackView)
        EntireVerticalStackView.addArrangedSubview(verticalStackViewForCheckBoxAndTexxtField)
        
    }
    
    
    @objc func checkBoxAction() {
        UIView.animate(withDuration: 0.3, delay: 0.1, options: .curveLinear, animations: {
            self.checkBoxButton.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        }) { (success) in
            if self.checkBoxButton.isSelected {
                self.checkBoxButton.setImage(UIImage(named: "UnCheckbox")!, for: .selected)
                self.checkBoxButton.isSelected.toggle()
            }
            else {
                self.checkBoxButton.setImage(UIImage(named: "Checkbox")!, for: .selected)
                self.checkBoxButton.isSelected.toggle()
            }
            UIView.animate(withDuration: 0.3, delay: 0.1, options: .curveLinear, animations: {
                self.checkBoxButton.transform = .identity
            }, completion: nil)
        }

    }
    
    deinit {
        print("pagerView deinited")
    }
    

}

extension PagerViewViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
        
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
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
        vc.reloadDataForMyTask()

        vc.comments = comments
        

        self.present(vc, animated: true, completion: nil)
    }
}


extension PagerViewViewController: ActivityCollectionViewCellDelegate {
    
    func mustPresentNewScheduleAlert(cell: UICollectionViewCell) {
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
                                              billable: self.checkBoxButton.isSelected,
                                              startedAt: "\(self.startDatePicker.date)",
                                              endedAt: "\(self.endDatePicker.date)") { res in
                switch res {
                case .success(let model):
//                    print(model)
                    DispatchQueue.main.async {
                        let casted = cell as! ActivityCollectionViewCell
                        casted.newModel = model
                    }
                case .failure(let err):
                    print(err)
                }
            }
            
        })
        alertController.addAction(somethingAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    
    func mustPresentAlert(info: TimeTrackingModel, cell: UICollectionViewCell) {
        
        let startedAtTime: String = "\(info.startedAt?[0 ... 9] ?? "0000-00-00") \(info.startedAt?[11 ... 15] ?? "00:00")"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        let startDate = dateFormatter.date(from: startedAtTime)
        textField.text = info.note
        
        let endedAtTime: String = "\(info.endedAt?[0 ... 9] ?? "0000-00-00") \(info.endedAt?[11 ... 15] ?? "00:00")"
        let endDate = dateFormatter.date(from: endedAtTime)
        
        
        if let startDate = startDate {
            startDatePicker.setDate(startDate, animated: true)
        }
        
        if let endDate = endDate {
            endDatePicker.setDate(endDate, animated: true)
        }
        
        if info.billable ?? true {
            checkBoxButton.isSelected = true
            checkBoxButton.setImage(UIImage(named: "Checkbox")!, for: .selected)
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
                billable: checkBoxButton.isSelected,
                startedAt: "\(self.startDatePicker.date)",
                endedAt: "\(self.endDatePicker.date)"
            ) { result in
                switch result {
                    
                case .success(_):
//                    print(final)
                    let vm = TimeTrackingApiService()
                    vm.getTimeTrackingData { _ in
                        if let castedCell = cell as? ActivityCollectionViewCell{
                            castedCell.fetchTimeTrackingData()
                        }
                    }
                    
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
    
    
    
    
    func askSomethingWithAlert(alertText: String,
                               alertMessage: String,
                               actionTitle: String,
                               action: ((UIAlertAction) -> Void)?
    ) {
        self.myTaskActionAlert(alertText: alertText, alertMessage: alertMessage, addActionTitle: actionTitle, action: action)
    }
    
    func dismiss() {
        DispatchQueue.main.async { [weak self] in
            let storyboard = UIStoryboard(name: "MyTasksStoryboard", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "MyTasksViewController")
            var viewcontrollers = self?.navigationController?.viewControllers
            viewcontrollers?.removeAll()
            viewcontrollers?.append(vc)
            self?.navigationController?.setViewControllers(viewcontrollers!, animated: true)
            
        }
    }
    
}


extension PagerViewViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
