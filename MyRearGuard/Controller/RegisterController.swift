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

    
    @IBAction func register(_ sender: Any)
    {
        self.systemManager.storeEmail(secret: secret!)
        self.systemManager.addMedicDetails(firstName: self.firstName.text!, lastName: self.lastName.text!, email: self.email.text!)
        self.systemManager.addActive(secret: self.secret!)
        self.performSegue(withIdentifier: "registered", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        email.text = secret
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
