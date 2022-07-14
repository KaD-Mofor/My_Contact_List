//
//  StateViewController.swift
//  My Contact List
//
//  Created by Daniel Kubong on 11/11/21.
//

import UIKit

protocol StateControllerDelegate: AnyObject {
    func stateChanged(string: String)
}

class StateViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    
    @IBOutlet weak var statePicker: UIPickerView!
    
    var selectState: Array<String> = ["AL","AK", "AZ", "AR", "CA", "CO", "CT", "DE", "FL", "GA",
                                       "HI", "ID", "IL", "IN", "IA", "KS", "KY", "LA", "ME", "MD",
                                       "MA", "MI","MN", "MS", "MO", "MT", "NE", "NV", "NH", "NJ",
                                       "NM", "NY", "NC", "ND", "OH", "OK", "OR", "PA", "RI", "SC",
                                       "SD", "TN", "TX", "UT", "VT", "VA", "WA", "WV", "WI", "WY" ]
    
    weak var delegate: StateControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let saveCity: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.save, target: self, action: #selector(saveState))
        self.navigationItem.rightBarButtonItem = saveCity
        self.title = "Pick State"
    }
    

    // MARK: - Navigation

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1;
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return selectState.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return selectState[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print("chosen state: \(selectState[row])")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //Set the UI based on values in the UserDefaults
        let settings = UserDefaults.standard
        let sortField = settings.string(forKey: Constants.kSortField)
        var i = 0
        for field in selectState {
            if field == sortField{
                statePicker.selectRow(i, inComponent: 0, animated: false)
            }
            i += 1
        }
        statePicker.reloadComponent(0)
    }
    
    @objc func saveState(){
        //self.delegate?.stateChanged(string: statePicker.string)
        self.navigationController?.popViewController(animated: true)
    }
}
