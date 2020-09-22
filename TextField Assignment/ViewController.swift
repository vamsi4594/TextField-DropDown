//
//  ViewController.swift
//  TextField Assignment
//
//  Created by THANIKANTI VAMSI KRISHNA on 2/4/20.
//  Copyright © 2020 THANIKANTI VAMSI KRISHNA. All rights reserved.
//

import UIKit
// class for TableView Cell
class TableViewCell: UITableViewCell
{
    
}

class ViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var firstNameTxt: UITextField! // First Name textField
    @IBOutlet weak var lastNameTxt: UITextField! // Last Name textField
    @IBOutlet weak var ageTxt: UITextField! // age textField
    
    
    @IBOutlet weak var genderSelection: UIButton! // button to select gender
    @IBOutlet weak var stateSelection: UIButton! // button to select state
    
    let transparentView = UIView() // for transparent view when selction
    let tableView = UITableView() // to display options for Gender/State buttons
    var selectedButton = UIButton() // to know which button is selected to dispay options
    var dataToDisplayInTableView = [String]() // to store options for buttons
    
    @IBOutlet weak var emailTxt: UITextField! // email textField
    @IBOutlet weak var phoneNumberTxt: UITextField! // phone number textField
    
    @IBOutlet weak var submitBtn: UIButton! // submit button
    @IBOutlet weak var userLabel: UILabel! // to display user details typed on textfields
    

    override func viewDidLoad() {
        super.viewDidLoad()
         // declearing delegates for textfields and tableview
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "Cell") // for cell name
        
        firstNameTxt.delegate = self
        lastNameTxt.delegate = self
        ageTxt.delegate = self
        emailTxt.delegate = self
        phoneNumberTxt.delegate = self
        // adding image to textfields
        let firstNameImage = UIImage(named: "fn1")
        addImagesToTextFields(textField: firstNameTxt, andImage: firstNameImage!)
        addImagesToTextFields(textField: lastNameTxt, andImage: firstNameImage!)
        // adding image to textfields
        let ageImage = UIImage(named: "age1")
        addImagesToTextFields(textField: ageTxt, andImage: ageImage!)
         // adding image to textfields
        let emailImage = UIImage(named: "email1")
        addImagesToTextFields(textField: emailTxt, andImage: emailImage!)
        // adding image to textfields
        let phoneImage = UIImage(named: "cell1")
        addImagesToTextFields(textField: phoneNumberTxt, andImage: phoneImage!)
    
    }
    // to add transparent view to UIView when tableView is displaying
    func addTransparentView(frames: CGRect)
    {
        transparentView.frame = self.view.frame // transparent view as same as UIView
        self.view.addSubview(transparentView)
        transparentView.backgroundColor = UIColor.black.withAlphaComponent(0.9)
         
        // set default frame for tableView.
        tableView.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height, width: frames.width, height: 0)
        self.view.addSubview(tableView)
        tableView.layer.cornerRadius = 5
        tableView.reloadData() // reload data to display on tableview for respective button
        
        // to add transparentview on tap and add function to remove transparent view.
        let tapgesture = UITapGestureRecognizer(target: self, action: #selector(removeTransparentView))
        transparentView.addGestureRecognizer(tapgesture)
        
        // to animate transparent view
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.transparentView.alpha = 0.5
            //set frame to tableview so to display exactly at buttons
            self.tableView.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height + 5, width: frames.width, height: CGFloat(self.dataToDisplayInTableView.count * 40)) // dynamic height based on number of data to display
        }, completion: nil)
        
    }
     // function to remove transparentView, TableView after selected and also on tap
    @objc func removeTransparentView()
    {
        let frames = selectedButton.frame
        // to animate transparent view
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.transparentView.alpha = 0
            self.tableView.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height, width: frames.width, height: 0)
        }, completion: nil)
    }
    
    @IBAction func onClickGender(_ sender: UIButton)
    {
        genderSelection.backgroundColor = .white
        dataToDisplayInTableView = ["Male","Female","Transgender"] // data for tableVIew
        selectedButton = genderSelection
        addTransparentView(frames: genderSelection.frame) // add transparent view
    }
    
    @IBAction func onClickState(_ sender: UIButton)
    {
        stateSelection.backgroundColor = .white
        dataToDisplayInTableView = ["Andhra Pradesh","Arunachal Pradesh","Assam","Bihar","Chhattisgarh","Goa","Gujarat","Haryana","Himachal Pradesh","Jharkhand","Karnataka","Kerala","Madhya Pradesh","Maharashtra","Manipur","Meghalaya","Mizoram","Nagaland","Odisha","Panjab","Rajasthan","Sikkim","Tamil Nadu","Telangana","Tripura","Uttar Pradesh","Uttarakhand","West Bengal","Jammu & Kashmir"] // data for tableView
        selectedButton = stateSelection
        addTransparentView(frames: stateSelection.frame) // add transparentView
    }
    
    
     // to close keypad for number keypad when tap on screen
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        ageTxt.resignFirstResponder()
        phoneNumberTxt.resignFirstResponder()
    }
    
    // adding icons to Left View of TextField
    func addImagesToTextFields(textField: UITextField, andImage img:UIImage)
    {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        imageView.image = img
        textField.leftView = imageView
        textField.leftViewMode = .unlessEditing
    }
    
  
    
    // adding del;egates to textFileds for validation
    // first and last names, only alphabets and spaces should allow
    // age should be below 120
    // email should be validata as per Gmail requirement.
    // phone number should have only 10 digits
    
    // delegate function to validate Textfields
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // validate phone number to not more than 10 digits
        if textField == phoneNumberTxt
        {
            if phoneNumberTxt.text!.count >= 10
            {
                return false
            }
            return true
        }
        
        // validate Name texts to allow only alphabets and spaces
        if textField == firstNameTxt || textField == lastNameTxt
        {
            let allowedCharacters1 = CharacterSet.letters
            let allowedCharacters2 = CharacterSet.whitespaces
            let characterSet = CharacterSet(charactersIn: string)
            return allowedCharacters1.isSuperset(of: characterSet) || allowedCharacters2.isSuperset(of: characterSet)
        }
         // validate age should be between 0 and 120
        if textField == ageTxt
        {
            if let age = Int(ageTxt.text! + string)
            {
                if age > 0 && age <= 120{
                    print(age)
                    return true
                }
                return false
            }
        }
        return true
    }

     // on submit it shows user details
    @IBAction func submitButton(_ sender: UIButton)
    {
        var textFieldEmpty = false
        var selectButtonEmpty = false
        if submitBtn.titleLabel!.text == "submit"
        {
            let textFields = [firstNameTxt,lastNameTxt,ageTxt,emailTxt,phoneNumberTxt]
            for fields in textFields
            {
                if fields!.text == ""
                {
                    textFieldEmpty = true
                    fields!.layer.cornerRadius = 3
                    fields!.layer.borderWidth = 3
                    fields!.layer.borderColor = UIColor.red.cgColor
                }
            }
            if genderSelection.titleLabel!.text == "Select Gender" || stateSelection.titleLabel!.text == "Select State"
            {
                selectButtonEmpty = true
                if genderSelection.titleLabel!.text == "Select Gender"
                {
                    genderSelection.backgroundColor = .red
                }
                if stateSelection.titleLabel!.text == "Select State"
                {
                    stateSelection.backgroundColor = .red
                }
            }
            
            if textFieldEmpty == false && selectButtonEmpty == false
            {
                submitBtn.setTitle("Register Again", for: .normal)
                let gender = genderSelection.titleLabel!.text
                let state = stateSelection.titleLabel!.text
                
                userLabel.text = "First Name: \(firstNameTxt.text!)\nLast Name: \(lastNameTxt.text!)\nGender: \(gender ?? "Not Selected")\nAge: \(ageTxt.text!)\nEmail: \(emailTxt.text!)\nPhone Number: \(phoneNumberTxt.text!)\nState: \(state ?? "Not Selected")"
                
            }
        }else{
            submitBtn.setTitle("submit", for: .normal)
            firstNameTxt.text = ""
            lastNameTxt.text = ""
            ageTxt.text = ""
            emailTxt.text = ""
            phoneNumberTxt.text = ""
            genderSelection.setTitle("Select Gender", for: .normal)
            stateSelection.setTitle("Select State", for: .normal)
            userLabel.text = ""
            
        }

    }
    
    @IBAction func onClickFirstName(_ sender: UITextField)
    {
        // to remove textField Highlights
        firstNameTxt!.layer.cornerRadius = 0
        firstNameTxt!.layer.borderWidth = 0
        firstNameTxt!.layer.borderColor = nil
    }
    
    @IBAction func onClickLastName(_ sender: UITextField)
    {
        // to remove textField Highlights
        lastNameTxt!.layer.cornerRadius = 0
        lastNameTxt!.layer.borderWidth = 0
        lastNameTxt!.layer.borderColor = nil
    }
    
    @IBAction func onClickAge(_ sender: UITextField)
    {
        // to remove textField Highlights
        ageTxt!.layer.cornerRadius = 0
        ageTxt!.layer.borderWidth = 0
        ageTxt!.layer.borderColor = nil
    }
    
    
    
     // validate email based on priorities.
    @IBAction func emailTextField(_ sender: UITextField)
    {
        emailTxt!.layer.cornerRadius = 0
        emailTxt!.layer.borderWidth = 0
        emailTxt!.layer.borderColor = nil
        
        let email = emailTxt.text!
        if isValidateEmail(emailID: email) == false
        {
            emailTxt.text = ""
            emailTxt.text = "Enter valid email ID"
        }
    }
     // phne number should not less than 10 digits
    @IBAction func phoneNumberCheck(_ sender: UITextField)
    {
        phoneNumberTxt!.layer.cornerRadius = 0
        phoneNumberTxt!.layer.borderWidth = 0
        phoneNumberTxt!.layer.borderColor = nil
        
        let number = sender.text!
        if number.count < 10
        {
            phoneNumberTxt.text = "Invalid Phone Number"
        }
    }
     // function for email priorities
    func isValidateEmail(emailID:String)->Bool
    {
        let emailRequirements = "[0-9a-z._%+-]+@[a-z0-9.-]+.[a-z]{2,}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRequirements)
        return emailTest.evaluate(with: emailID)
    }

}
// to close keypad when return is pressed
extension ViewController
{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
// view contoller extension for table view delegates
extension ViewController: UITableViewDelegate, UITableViewDataSource
{
    // add rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataToDisplayInTableView.count
    }
    // add data on each row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel!.text = dataToDisplayInTableView[indexPath.row]
        return cell
    }
    // fix height of each row
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    // recognise the row selected and display the selected data on button.
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        removeTransparentView()
        selectedButton.setTitle(dataToDisplayInTableView[indexPath.row], for: .normal)
    }
    
}

