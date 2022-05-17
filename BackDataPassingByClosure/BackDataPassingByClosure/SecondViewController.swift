//
//  SecondViewController.swift
//  BackDataPassingByClosure
//
//
//

import UIKit

class SecondViewController: UIViewController {
    
    // MARK: Outlets
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var middlenameTF: UITextField!
    @IBOutlet weak var surnameTF: UITextField!
    
    // MARK: Variables
    var passDataClosure: ((String?,String?,String?) -> Void)?
    
    // MARK: View Controller LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        self.navigationItem.title = "SecondVC"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveButtonAction))
        
    }
    
    // MARK: Saave Button Method
    @IBAction func saveButtonAction(){
        
        let name = self.nameTF.text
        let middlename = self.middlenameTF.text
        let surname = self.surnameTF.text
        guard let closure = passDataClosure else {
            print("secondVC does not have closure")
            return
        }
        if(name == "" || middlename == "" || surname == ""){
            showAlert()
        } else {
            saveAlert()
        }
        
        func saveAlert(){
            let saveAlert = UIAlertController(title: "Alert", message: "Data Saved", preferredStyle: .alert)
            saveAlert.addAction(UIAlertAction(title: "Ok", style:.default, handler: {action in closure(name,middlename,surname)
                self.navigationController?.popViewController(animated: true)} ))
            present(saveAlert, animated: true)
        }
    }
    
    // MARK: Show Alert Function
    private func showAlert(){
        let alert = UIAlertController(title: "Alert", message: "fill All the Information", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
        present(alert, animated: true)
    }
}
