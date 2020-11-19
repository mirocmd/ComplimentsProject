//
//  AddItemTableViewController.swift
//  Compliments-project
//
//  Created by MacBook Pro on 14.11.20.
//

import UIKit

protocol AddItemTableViewControllerDelegate: class {
    func itemDetailViewControllerDidCancel(_ controller: AddItemTableViewController)
    func itemDetailViewController(_ controller: AddItemTableViewController, didFinishAddingItem item: ChecklistItem)
}

class AddItemTableViewController: UITableViewController {
    
    // Mark: - IBOULETS
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    @IBOutlet weak var shouldRemindSwitch: UISwitch! 
    @IBOutlet weak var dueDateLabel: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet var datePickerCell: UITableViewCell!
    // MARK: - Properties
    weak var delegate: AddItemTableViewControllerDelegate?
    var itemToEdit: ChecklistItem?
    var isDatePickerVisible = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    // MARK: - IBaction
    @IBAction func cancel() {
        delegate?.itemDetailViewControllerDidCancel(self)
    }
    @IBAction func done() {
        // Save me
      
        let checklistItem = ChecklistItem(textField.text!, isChecked: false, shouldRemind: shouldRemindSwitch.isOn)
        delegate?.itemDetailViewController(self, didFinishAddingItem: checklistItem)
    }
    
    // MARK: - Helpers
    private func showDatePicker() {
        isDatePickerVisible = true
        let indexPathDatePicker = IndexPath(row: 2, section: 1)
        tableView.insertRows(at: [indexPathDatePicker], with: .fade)
        dueDateLabel.textColor = dueDateLabel.tintColor
    }
    
    private func hideDatePicker() {
        if isDatePickerVisible {
            isDatePickerVisible = false
            let indexPathDatePicker = IndexPath(row: 2, section: 1)
            tableView.deleteRows(at: [indexPathDatePicker], with: .fade)
            dueDateLabel.textColor = .black
        }
    }
    @IBAction func shouldRemindToggled(_ sender: UISwitch) {
        textField.resignFirstResponder()
        
        UNUserNotificationCenter.current()
            .requestAuthorization(options: [.alert,.sound]) {
                granted, error in
                print("We have permission!")
            }
    }
}

extension AddItemTableViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let oldText = textField.text!
        let stringRange = Range(range, in: oldText)!
        let newText = oldText.replacingCharacters(in: stringRange, with: string)
        doneButton.isEnabled = !newText.isEmpty
        return true
    }
}

extension AddItemTableViewController {
     func tableview(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard section == 1 && isDatePickerVisible else {
            return super.tableView(tableView,numberOfRowsInSection: section)
        }
        return 3
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard indexPath.row == 2 && indexPath.section == 1 else {
            return super.tableView(tableView, cellForRowAt: indexPath)
        }
        
        return datePickerCell
    }
}

extension AddItemTableViewController {
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        guard indexPath.row == 1 && indexPath.section == 1 else {
            return nil
    }
        
        return indexPath
}
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.section == 1 && indexPath.row == 1 {
            isDatePickerVisible ?
                hideDatePicker() :
            showDatePicker()
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard indexPath.row == 2 && indexPath.section == 1 else {
            return super.tableView(tableView, heightForRowAt: indexPath)
        }
        
        return 217.0
    }
    
    override func tableView(_ tableView: UITableView, indentationLevelForRowAt indexPath: IndexPath) -> Int {
        var newIndexPath = indexPath
        if indexPath.section == 1 && indexPath.row == 2 {
            newIndexPath = IndexPath(row: 0, section: indexPath.section)
        }
        
        return super.tableView(tableView,indentationLevelForRowAt: newIndexPath)
    }
}
