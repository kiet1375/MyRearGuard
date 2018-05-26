//
//  MapManager.swift
//  Medic
//
//  Created by Kiet Lam on 26/5/18.
//  Copyright © 2018 Kiet Lam. All rights reserved.
//

import Foundation
import FirebaseDatabase


class SystemManager
{
    var db: DatabaseReference?
    var handle:DatabaseHandle?
    
    init(){} //default constructor
    
    func storeEmail(secret: String)-> Void
    {
        // Save data to file
        let fileName = "email"
        var message = ""
        
        let DocumentDirURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        
        let fileURL = DocumentDirURL.appendingPathComponent(fileName).appendingPathExtension("txt")
        
        
        do {
            // Read the file contents
            message = try String(contentsOf: fileURL)
            if(message == ""){
                do {
                    // Write to the file
                    message = secret
                    try message.write(to: fileURL, atomically: true, encoding: String.Encoding.utf8)
                } catch let error as NSError {
                    print("Failed writing to URL: \(fileURL), Error: " + error.localizedDescription)
                }
            }
            
        } catch let error as NSError {
            print("Failed reading from URL: \(fileURL), Error: " + error.localizedDescription)
        }
    }
    
    func isWorking(secret: String) -> Void
    {
        db = Database.database().reference()
        let ref = db?.child("actives").child("active")
        print("Starting observing");
        ref?.observe(.value, with: { (snapshot: DataSnapshot!) in
            self.handle = ref?.observe(.childAdded, with: { (snapshot) in
                if let key = snapshot.key as? String {
                    self.handle = self.db?.child("actives/active").child(key).observe(.childAdded, with: { (snapshot) in
                        if let data = snapshot.key as? String {
                            if(data == "email"){
                                let p = snapshot.value as! String
                                if(p == secret){
                                    self.db?.child("actives").child("active").child(key).child("working").setValue("true")
                                    ref?.removeAllObservers()
                                    
                                }
                            }
                        }
                        ref?.removeAllObservers()
                    })
                }
            })
        })
    }
    
    func notWorking(secret: String) -> Void
    {
        db = Database.database().reference()
        let ref = db?.child("actives").child("active")
        print("Starting observing");
        ref?.observe(.value, with: { (snapshot: DataSnapshot!) in
            self.handle = ref?.observe(.childAdded, with: { (snapshot) in
                if let key = snapshot.key as? String {
                    self.handle = self.db?.child("actives/active").child(key).observe(.childAdded, with: { (snapshot) in
                        if let data = snapshot.key as? String {
                            if(data == "email"){
                                let p = snapshot.value as! String
                                if(p == secret){
                                    self.db?.child("actives").child("active").child(key).child("working").setValue("true")
                                    ref?.removeAllObservers()
                                    
                                }
                            }
                        }
                        ref?.removeAllObservers()
                    })
                }
            })
        })
    }
    
    
    func getIncident(group: DispatchGroup) -> Incident
    {
        let incident = Incident() // default constructor
        var count = 0
        db = Database.database().reference()
        let ref = db?.child("incidents").child("incident")
        ref?.observe(.value, with: { (snapshot: DataSnapshot!) in
            self.handle = ref?.observe(.childAdded, with: { (snapshot) in
                if let key = snapshot.key as? String {
                    self.handle = self.db?.child("incidents/incident").child(key).observe(.childAdded, with: { (snapshot) in
                        if let data = snapshot.key as?
                            String {
                            let child = snapshot.value as! String
                            if(count < 1)
                            {
                                DispatchQueue.main.async {
                                    if(data == "date"){
                                        incident.date = child
                                    }
                                    if(data == "latitude"){
                                        incident.latitude = Double(child)!
                                    }
                                    if(data == "longitude"){
                                        incident.longitude = Double(child)!
                                    }
                                    if(data == "time"){
                                        incident.time = child
                                    }
                                    if(data == "attack type"){
                                        incident.attackType = child
                                    }
                                    if(data == "medic"){
                                        incident.medic = child
                                        
                                        if(child == "" && count == 0){
                                            count = count+1
                                        }
                                    }
                                    if(data == "patient"){
                                        incident.patient = child
                                    }
                                    if(incident.date != "" && incident.latitude != 0.0 && incident.longitude != 0.0 && incident.time != "" && incident.patient != "" && incident.attackType != "" && incident.medic == "" && count == 1){
                                        incident.medic = "kitkat1375@hotmail.com"
                                        count = count+1
                                        self.db?.child("incidents/incident").child(key).child("medic").setValue("kitkat1375@hotmail.com")
                                        group.leave()
                                        ref?.removeAllObservers()
                                    }
                                }
                            }
                        }
                        ref?.removeAllObservers()
                    })
                }
            })
        })
        return incident
    }
    
    func addMedicDetails(firstName: String, lastName: String, email: String)-> Void
    {
        let medic = Medic()
        db = Database.database().reference()
        let ref = db?.child("medics").child("medic").queryLimited(toLast: 1)
        self.handle = ref?.observe(.childAdded, with: { (snapshot) in
            if let key = snapshot.key as? String{
                medic.indexNumber = Int(key)!
                medic.indexNumber = medic.indexNumber+1
                self.db?.child("medics").child("medic").child("\(String(medic.indexNumber))").child("email").setValue(email)
                self.db?.child("medics").child("medic").child("\(String(medic.indexNumber))").child("first name").setValue(firstName)
                self.db?.child("medics").child("medic").child("\(String(medic.indexNumber))").child("last name").setValue(lastName)
                ref?.removeAllObservers()
            }
        })
    }
    
    func addActive(secret: String)-> Void
    {
        db = Database.database().reference()
        let ref = db?.child("actives").child("active").queryLimited(toLast: 1)
        self.handle = ref?.observe(.childAdded, with: { (snapshot) in
            if let key = snapshot.key as? String{
                let medic = Medic()
                medic.indexNumber = Int(key)!
                medic.indexNumber = medic.indexNumber+1
                self.db?.child("actives").child("active").child("\(String(medic.indexNumber))").child("email").setValue(secret)
                self.db?.child("actives").child("active").child("\(String(medic.indexNumber))").child("working").setValue(false)
                ref?.removeAllObservers()
            }
        })
    }
    
}
