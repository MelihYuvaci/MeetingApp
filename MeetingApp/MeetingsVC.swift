//
//  MeetingsVC.swift
//  MeetingApp
//
//  Created by Melih Yuvacı on 2.06.2022.
//

import UIKit
import Firebase

class MeetingsVC: UIViewController, UITableViewDelegate,UITableViewDataSource {
    
    var userEmailArray = [String]()
    var userMeetingSubjectArray = [String]()
    var userMeetingRoomArray = [String]()
    var userMeetingDetailsArray = [String]()
    var userMeetingDateArray = [String]()

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        getDataFromFirestore()
        
    }
    
    func getDataFromFirestore(){
        let fireStoreDatabase = Firestore.firestore()
        fireStoreDatabase.collection("Meetings").order(by: "Date", descending: true).addSnapshotListener { snapshot, error in
            if error != nil {
                self.makeAlert(titleInput: "Veritabanından Veriler Çekilemedi", messageInput: error?.localizedDescription ?? "Error")
            }else {
                if snapshot?.isEmpty != true && snapshot != nil {
                    
                    self.userEmailArray.removeAll(keepingCapacity: false)
                    self.userMeetingDateArray.removeAll(keepingCapacity: false)
                    self.userMeetingRoomArray.removeAll(keepingCapacity: false)
                    self.userMeetingDetailsArray.removeAll(keepingCapacity: false)
                    self.userMeetingSubjectArray.removeAll(keepingCapacity: false)
                    
                    
                    for document in snapshot!.documents{
                        
                        let documentID = document.documentID
                        
                        if let postedBy = document.get("PostedBy") as? String{
                            self.userEmailArray.append(postedBy)
                        }
                        if let subject = document.get("MeetingSubject") as? String {
                            self.userMeetingSubjectArray.append(subject)
                        }
                        if let room = document.get("MeetingRoom") as? String {
                            self.userMeetingRoomArray.append(room)
                        }
                        if let details = document.get("MeetingDetails") as? String {
                            self.userMeetingDetailsArray.append(details)
                        }
                        if let date = document.get("MeetingDate") as? String {
                            self.userMeetingDateArray.append(date)
                        }
                    }
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userEmailArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MeetingsCell
        cell.emailText.text = userEmailArray[indexPath.row]
        cell.subjectText.text = userMeetingSubjectArray[indexPath.row]
        cell.detailsText.text = userMeetingDetailsArray[indexPath.row]
        cell.roomText.text = userMeetingRoomArray[indexPath.row]
        cell.meetingDate.text = userMeetingDateArray[indexPath.row]
        return cell
    }
    
    func makeAlert (titleInput : String , messageInput : String){
        let alert = UIAlertController(title:titleInput , message: messageInput, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }


}
