//
//  ViewController.swift
//  BackDataPassingByClosure
//
// 
//

import UIKit

class ViewController: UIViewController{
    
    // MARK: Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Variables
    var studentArray: [StudentModel] = []
    
    // MARK: View Controller LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        self.navigationItem.title = "FirsrVC"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addBarButtonAction))
        
    }
    
    // MARK: Add Bar Button Method
    @IBAction func addBarButtonAction(){
        guard let secVC = self.storyboard?.instantiateViewController(withIdentifier: "SecondViewController") as? SecondViewController else {
            return
        }
        
        secVC.passDataClosure = {(name,middlename,surname) in
            let student = StudentModel(name: name ?? "", middlename: middlename ?? "", surname: surname ?? "")
            self.studentArray.append(student)
            self.tableView.reloadData()
        }
        
        self.navigationController?.pushViewController(secVC,animated: true)
    }
    
}
// MARK: UITableViewDataSource Protocol
extension ViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if studentArray.count == 0 {
            noDataLabel()
            return 0
        } else {
            self.tableView.backgroundView = nil
            return studentArray.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "CustomCell") as? CustomTableViewCell else {
            return UITableViewCell()
        }
        cell.nameLabel.text = studentArray[indexPath.row].name
        cell.middlenameLabel.text = studentArray[indexPath.row].middlename
        cell.surnameLabel.text = studentArray[indexPath.row].surname
        return cell
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            tableView.beginUpdates()
            studentArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        }
    }
    
}

// MARK: UITableViewDelegate Protocol
extension ViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        90
    }
}
// MARK: No data Label Function
extension ViewController {
    func noDataLabel() {
        let noDataLabel: UILabel = UILabel()
        noDataLabel.text = "No data To display"
        noDataLabel.textAlignment = .center
        noDataLabel.textColor = UIColor.black
        self.tableView.backgroundView = noDataLabel
    }
}
