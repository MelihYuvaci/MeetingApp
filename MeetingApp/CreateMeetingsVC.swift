//
//  CreateMeetingsVC.swift
//  MeetingApp
//
//  Created by Melih Yuvacı on 2.06.2022.
//

import UIKit
import Firebase

class CreateMeetingsVC: UIViewController {

    @IBOutlet weak var createMeetingSubjectText: UITextField!
    @IBOutlet weak var createMeetingRoomText: UITextField!
    @IBOutlet weak var createMeetingDateText: UITextField!
    @IBOutlet weak var createMeetingDetailsText: UITextField!
    
    let datePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        createDatePicker()
        
    }
    
    @IBAction func shareClicked(_ sender: Any) {
        let firestoreDatabase = Firestore.firestore()
        var firestoreReference : DocumentReference? = nil
        
        if createMeetingSubjectText.text != "" && createMeetingDateText.text != "" && createMeetingRoomText.text != "" && createMeetingDetailsText.text != "" && Auth.auth().currentUser != nil{
            
            let firestorePost = ["MeetingSubject" : createMeetingSubjectText.text!, "MeetingRoom" : createMeetingRoomText.text!, "MeetingDate" : createMeetingDateText.text!, "MeetingDetails": createMeetingDetailsText.text! ,"PostedBy":Auth.auth().currentUser!.email!, "Date":FieldValue.serverTimestamp() ] as [String:Any]
            
            firestoreReference = firestoreDatabase.collection("Meetings").addDocument(data: firestorePost, completion: { error in
                if error != nil {
                    self.makeAlert(titleInput: "Veritabanına Yüklenemedi", messageInput: error?.localizedDescription ?? "Error")
                }else {
                    self.createMeetingDetailsText.text = ""
                    self.createMeetingDateText.text = ""
                    self.createMeetingRoomText.text = ""
                    self.createMeetingSubjectText.text = ""
                    self.tabBarController?.selectedIndex = 0
                }
            })
        }
    }
    
    func createDatePicker(){
        datePicker.preferredDatePickerStyle = .wheels
        createMeetingDateText.inputView = datePicker
        createMeetingDateText.inputAccessoryView = createToolbar()
    }
    
    func createToolbar() -> UIToolbar {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneClicked))
        toolbar.setItems([doneButton], animated: true)
        return toolbar
    }
    
    @objc func doneClicked(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .medium
        self.createMeetingDateText.text = dateFormatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    
    func makeAlert (titleInput : String , messageInput : String){
        let alert = UIAlertController(title:titleInput , message: messageInput, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
}
