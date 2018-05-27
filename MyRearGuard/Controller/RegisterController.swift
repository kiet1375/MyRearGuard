//
//  RegisterController.swift
//  Medic
//
//  Created by Kiet Lam on 12/5/18.
//  Copyright © 2018 Kiet Lam. All rights reserved.
//
import UIKit
import FirebaseDatabase

class RegisterController: UIViewController {
    
    var secret: String?
    let systemManager = SystemManager()
    
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    
    var db: DatabaseReference?
    var handle:DatabaseHandle?
    
    //Action method is called when user is directed by authenticationManager
    @IBAction func register(_ sender: Any)
    {
        self.systemManager.storeEmail(secret: secret!) // creates authentication configuration file
        self.systemManager.addMedicDetails(firstName: self.firstName.text!, lastName: self.lastName.text!, email: self.email.text!)
        self.systemManager.addActive(secret: self.secret!) //creates new branch of active
        self.performSegue(withIdentifier: "registered", sender: self) // reutrn user bck to authentication view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        email.text = secret //send text back to authentication view
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
