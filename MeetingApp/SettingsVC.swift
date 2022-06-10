//
//  SettingsVC.swift
//  MeetingApp
//
//  Created by Melih Yuvacı on 2.06.2022.
//

import UIKit
import Firebase

class SettingsVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func logOutClicked(_ sender: Any) {
        do{
           try  Auth.auth().signOut()
            self.performSegue(withIdentifier: "toLoginVC", sender: nil)
        }catch{
            self.makeAlert(titleInput: "Çıkış Hatası", messageInput: error.localizedDescription)
        }
       
    }
    
    func makeAlert (titleInput : String , messageInput : String){
        let alert = UIAlertController(title:titleInput , message: messageInput, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
}
