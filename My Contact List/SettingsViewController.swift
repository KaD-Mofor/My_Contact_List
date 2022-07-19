//
//  SettingsViewController.swift
//  My Contact List
//
//  Created by Daniel Kubong on 10/21/21.
//

import UIKit

class SettingsViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
   
    @IBOutlet weak var pckSortField: UIPickerView!
    @IBOutlet weak var swAscending: UISwitch!
    @IBOutlet weak var sgmtSortField: UISegmentedControl!
    @IBOutlet weak var swDescending: UISwitch!
    
    let sortOrderItems: Array<String> = ["contactName", "city", "birthday"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        pckSortField.dataSource = self;
        pckSortField.delegate = self
        
    }
    
    @IBAction func sortDirectionChanged(_ sender: Any) {
        let settings = UserDefaults.standard
        settings.set(swAscending.isOn, forKey: Constants.kSortDirectionAscending)
        settings.synchronize()
    }
    
    //MARK: UIPickerViewDelegate Methods
    
    //Returns the number of "Columns" to display
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
           return 1
       }
     
    //Returns the # of rows in the picker
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return sortOrderItems.count
       }
    
    //Sets the value that is shown for each row in the picker
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return sortOrderItems[row]
    }
    
    //If the user chooses from the pickerview, it calls this function;
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //print("Chosen item: \(sortOrderItems[row])")
        let sortField = sortOrderItems[row]
        let settings = UserDefaults.standard
        settings.set(sortField, forKey: Constants.kSortField)
        settings.synchronize()
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        //Override point for customization after application launch.
        
        let settings = UserDefaults.standard
        
        if settings.string(forKey: "sortField") == nil {
            settings.set("City", forKey: "sortfField")
        }
        if settings.string(forKey: "sortDirectionAscending") == nil {
            settings.set(true, forKey: "sortDirectionAscending")
        }
        settings.synchronize()
        print("Sort field: \(settings.string(forKey: "sortField")!)")
        print("Sort direction: \(settings.bool(forKey: "sortDirectionAscending"))")
        return true
    }
    
    //MARK: viewWillAppear Method
    
    override func viewWillAppear(_ animated: Bool) {
        //Set the UI based on values in the UserDefaults
        let settings = UserDefaults.standard
        swAscending.setOn(settings.bool(forKey: Constants.kSortDirectionAscending), animated: true)
        //Second sort
        swDescending.setOn(settings.bool(forKey: Constants.vSortDirectionDescending), animated: true)
        
        let sortField = settings.string(forKey: Constants.kSortField) //Ascending sort
        let dSortField = settings.string(forKey: Constants.vSortField) //Descending sort
        
        var i = 0
        for field in sortOrderItems {
            if field == sortField && sgmtSortField.selectedSegmentIndex == 0 && swDescending.isOn {
                pckSortField.selectRow(i, inComponent: 0, animated: false)
                
            }
            else if field == sortField && sgmtSortField.selectedSegmentIndex == 1 && swDescending.isOn {
                pckSortField.selectRow(i, inComponent: 0, animated: false)
                
            }
            else if field == sortField && sgmtSortField.selectedSegmentIndex == 2 && swDescending.isOn {
                pckSortField.selectRow(i, inComponent: 0, animated: false)
                
            }
            i += 1
        }
        pckSortField.reloadComponent(0)
    }

}
