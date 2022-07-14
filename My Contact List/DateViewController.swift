//
//  DateViewController.swift
//  My Contact List
//
//  Created by Daniel Kubong on 11/9/21.
//

import UIKit

protocol DateControllerDelegate: AnyObject {
    func dateChanged(date: Date)
}

class DateViewController: UIViewController {
    
    @IBOutlet weak var dtpDate: UIDatePicker!
    
    //Delegate may not always be set , so it's weak, and the type is optional (?)
    //Optional tyoes are set to nil by default - no need for init methods.
    weak var delegate: DateControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let saveButton: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.save, target: self, action: #selector(saveDate))
        self.navigationItem.rightBarButtonItem = saveButton
        self.title = "Pick Birthdate"
    }
    
    @objc func saveDate() {
        self.delegate?.dateChanged(date: dtpDate.date)
        self.navigationController?.popViewController(animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
