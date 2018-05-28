//
//  ViewController.swift
//  MyRearGuard
//
//  Created by Kiet Lam on 12/5/18.
//  Copyright © 2018 Kiet Lam. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import SwiftKeychainWrapper

var test = ""

class AuthenticationController: UIViewController {
    
    var secret: String?
    var userID: String!
    let medic = Medic()
    let systemManager = SystemManager()
    
    @IBOutlet weak var type: UISegmentedControl!
    @IBOutlet weak var errorMessage: UILabel!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    var db: DatabaseReference?
    var handle:DatabaseHandle?

    
    //function authenticates a medic sign in or register a new user
    @IBAction func authenticationManager(_ sender: Any)
    {
        if(self.email != nil && self.password != nil){
            if(type.selectedSegmentIndex == 0){
                Auth.auth().signIn(withEmail : email.text!, password : password.text!, completion :{
                    (user, error) in
                    if(user != nil){
                        self.userID = user?.uid
                        self.systemManager.isWorking(secret: self.email.text!) // set isWorking tree to true
                        KeychainWrapper.standard.set(self.userID, forKey: "uid")
                        self.performSegue(withIdentifier: "Home", sender: self)
                    }
                    else{
                        self.errorMessage.text = error?.localizedDescription
                    }
                })
            }else{
                Auth.auth().createUser(withEmail : email.text!, password : password.text!, completion :{
                    (user, error) in
                    if(user != nil){
                        self.userID = user?.uid
                        KeychainWrapper.standard.set(self.userID, forKey: "uid")
                        self.performSegue(withIdentifier: "register", sender: self)
                    }
                    else{
                        self.errorMessage.text = error?.localizedDescription
                    }
                })
            }
        }else{
            errorMessage.isHidden = false
            errorMessage.text = "email and password must not be null"
        }
    }
    
    //prepare to send invisible text to the desired controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if(type.selectedSegmentIndex == 0){
            let home = segue.destination as! HomeController
            
            if(secret != ""){
                home.secret = email.text
            }
        }else{
            let email = segue.destination as! RegisterController
            
            if(self.email.text != ""){
                email.secret = self.email.text
            }
        }
    }
    
    //configuration file for authentication. Each download will only allow one regisration.
    //However, it has been commented out so markers can do there required work
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let fileName = "email"
        
        var message = ""
        
        if(message == ""){
            let DocumentDirURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            
            let fileURL = DocumentDirURL.appendingPathComponent(fileName).appendingPathExtension("txt")
            
            do {
                // Read the file contents
                message = try String(contentsOf: fileURL)
                
            } catch let error as NSError {
                print("Failed reading from URL: \(fileURL), Error: " + error.localizedDescription)
            }
            
            if(message != ""){
                secret = message
                //type.removeSegment(at: 1, animated: false)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

