//
//  ContactsViewController.swift
//  My Contact List
//
//  Created by Daniel Kubong on 10/21/21.
//

import UIKit
import CoreData

class ContactsViewController: UIViewController, UITextFieldDelegate, DateControllerDelegate, StateControllerDelegate{
    
    //Implementing the birhtday controller delegate
    func dateChanged(date: Date) {
        if currenContact == nil {
            let context = appDelegate.persistentContainer.viewContext
            currenContact = Contact (context: context)
        }
        currenContact?.birthday = date
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        lblBirthdate.text = formatter.string(from: date)
    }
    
    //Implementing the State change controller delegate
    func stateChanged(string: String) {
        if currenContact == nil {
            let context = appDelegate.persistentContainer.viewContext
            currenContact = Contact(context: context)
        }
        currenContact?.state = string
        
    }
    
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var sgmtEditMode: UISegmentedControl!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtAddress: UITextField!
    @IBOutlet weak var txtCity: UITextField!
    @IBOutlet weak var txtState: UITextField!
    @IBOutlet weak var txtZip: UITextField!
    @IBOutlet weak var txtCell: UITextField!
    @IBOutlet weak var txtPhone: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var lblBirthdate: UILabel!
    @IBOutlet weak var btnChange: UIButton!
    
    var currenContact: Contact? = nil
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if currenContact == nil {
            let context = appDelegate.persistentContainer.viewContext
            currenContact = Contact(context: context)
        }
        currenContact?.contactName = txtName.text
        currenContact?.streetAddress = txtAddress.text
        currenContact?.city = txtCity.text
        currenContact?.state = txtState.text
        currenContact?.zipCode = txtZip.text
        currenContact?.cellNumber = txtCell.text
        currenContact?.phoneNumber = txtPhone.text
        currenContact?.email = txtEmail.text
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        changeEditMode(self)
        
        let textFields: [UITextField] = [txtName, txtAddress, txtCity, txtState, txtZip,
                                        txtPhone, txtCell, txtEmail]
        for textfield in textFields {
            textfield.addTarget(self,
                                action: #selector(UITextFieldDelegate.textFieldShouldEndEditing(_:)),
                                for: UIControl.Event.editingDidEnd)
        }
        
    }
    
    @IBAction func changeEditMode(_ sender: Any) {
        let textFields: [UITextField] = [txtName,txtAddress, txtCity, txtState, txtZip, txtCell, txtPhone, txtEmail]
        if sgmtEditMode.selectedSegmentIndex == 0 {
            for textField in textFields {
                textField.isEnabled = false
                textField.borderStyle = UITextField.BorderStyle.none
            }
            btnChange.isHidden = true
            navigationItem.rightBarButtonItem = nil
        }
        else if sgmtEditMode.selectedSegmentIndex == 1 {
            for textField in textFields {
                textField.isEnabled = true
                textField.borderStyle = UITextField.BorderStyle.roundedRect
            }
            btnChange.isHidden = false
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem:.save, target: self, action: #selector(self.saveContact))
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        //Dispose of any resources that can be recreated
    }
    
    // MARK: - Keyboard changes
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.registerKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.unregisterKeyboardNotifications()
    }
    
    //Birthdate and State delegate reference
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "segueContactDate") {
            let dateController = segue.destination as! DateViewController
            dateController.delegate = self
        }
        //State delegate reference
        else if (segue.identifier == "segueContactState"){
            let stateController = segue.destination as! StateViewController
            //stateController.selectState = txtState.text
            stateController.delegate = self
        }
    }
    
    
    func registerKeyboardNotifications(){
        NotificationCenter.default.addObserver(self, selector: #selector(ContactsViewController.keyboardDidShow(notification:)), name: UIResponder.keyboardDidShowNotification, object: nil)
    }
    
    func unregisterKeyboardNotifications(){
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func keyboardDidShow(notification: NSNotification){
        let userInfo: NSDictionary = notification.userInfo! as NSDictionary
        let keyboardInfo = userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue
        let keyboardSize = keyboardInfo.cgRectValue.size
        
        //Get the existing content for the scrollview and set the bottom property to be the height of the keyboard.
        var contentInset = self.scrollView.contentInset
        contentInset.bottom = keyboardSize.height
        
        self.scrollView.contentInset = contentInset
        self.scrollView.scrollIndicatorInsets = contentInset
    }

    @objc func keyboardWillHide(notification: NSNotification){
        var contentInset = self.scrollView.contentInset
        contentInset.bottom = 0
        
        self.scrollView.contentInset = contentInset
        self.scrollView.scrollIndicatorInsets = UIEdgeInsets.zero
    }
    
    @objc func saveContact() {
        appDelegate.saveContext()
        sgmtEditMode.selectedSegmentIndex = 0
        changeEditMode(self)
    }
    
    //MARK: State picker
    
    
}
