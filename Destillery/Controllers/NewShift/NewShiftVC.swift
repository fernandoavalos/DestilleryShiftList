//
//  NewShiftVC.swift
//  Destillery
//
//  Created by Fernando Avalos on 12/02/22.
//

import UIKit

protocol NewShiftVCDelegate: AnyObject {
    func didSaveNewShift(shift: Shift)
}

class NewShiftVC: UIViewController {
    @IBOutlet weak var startDatePicker: UIDatePicker!
    @IBOutlet weak var endDatePicker: UIDatePicker!
    @IBOutlet weak var employeeTxtFld: UITextField!
    @IBOutlet weak var roleTxtFld: UITextField!
    @IBOutlet weak var colorTxtFld: UITextField!
    
    weak var delegatge: NewShiftVCDelegate?
    
    var employees: [String]?
    var roles: [String]?
    var colors: [String]?
    
    var employeePicker = UIPickerView()
    var rolePicker = UIPickerView()
    var colorPicker = UIPickerView()
    
    var newShift: Shift?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSelecctions()
    }
    
    func setupSelecctions() {
        employeeTxtFld.inputView = employeePicker
        employeeTxtFld.placeholder = "Select Employee"
        roleTxtFld.inputView = rolePicker
        roleTxtFld.placeholder = "Select Role"
        colorTxtFld.inputView = colorPicker
        colorTxtFld.placeholder = "Select Color"
        
        startDatePicker.tag = 1
        endDatePicker.tag = 2
        
        employeePicker.delegate = self
        employeePicker.dataSource = self
        employeePicker.tag = 3
        
        rolePicker.delegate = self
        rolePicker.dataSource = self
        rolePicker.tag = 4
        
        colorPicker.delegate = self
        colorPicker.dataSource = self
        colorPicker.tag = 5
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveAction(_ sender: Any) {
        guard let role = roleTxtFld.text, !role.isEmpty,
              let name = employeeTxtFld.text, !name.isEmpty,
              let color = colorTxtFld.text, !color.isEmpty else { return }
        let startDate = startDatePicker.date
        let endDate = endDatePicker.date
        delegatge?.didSaveNewShift(shift: Shift(role: role, name: name, startDate: startDate, endDate: endDate, color: color))
        dismiss(animated: true, completion: nil)
    }
}

extension NewShiftVC: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.tag {
        case 3:
            return employees?.count ?? 0
        case 4:
            return roles?.count ?? 0
        case 5:
            return colors?.count ?? 0
        default:
            return 1
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView.tag {
        case 3:
            return employees?[row]
        case 4:
            return roles?[row]
        case 5:
            return colors?[row]
        default:
            return "data not found"
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView.tag {
        case 3:
            employeeTxtFld.text = employees?[row]
            employeeTxtFld.resignFirstResponder()
        case 4:
            roleTxtFld.text = roles?[row]
            roleTxtFld.resignFirstResponder()
        case 5:
            colorTxtFld.text = colors?[row]
            colorTxtFld.resignFirstResponder()
        default:
            print("pickerView == \(pickerView.tag)")
        }
    }
}
