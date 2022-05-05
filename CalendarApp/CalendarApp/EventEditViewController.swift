//
//  EventEditViewController.swift
//  CalendarApp
//
//  Created by Nyah Campos on 5/4/22.
//

import UIKit

class EventEditViewController: UIViewController
{
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func save(_ sender: Any) {
        let newEvent = Event()
        newEvent.id = eventsList.count
        newEvent.name = nameTF.text
        newEvent.date = datePicker.date
        
        eventsList.append(newEvent)
        navigationController?.popViewController(animated: true)
    }
    
}
