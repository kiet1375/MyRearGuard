//
//  HomeController.swift
//  Medic
//
//  Created by Kiet Lam on 12/5/18.
//  Copyright © 2018 Kiet Lam. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import MapKit


class HomeController: UIViewController {
    
    let systemManager = SystemManager()
    var secret: String?
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var details: UIButton!
    
    var db: DatabaseReference?
    var handle:DatabaseHandle?
    

    @IBAction func signOff(_ sender: AnyObject)
    {
        self.systemManager.notWorking(secret: self.secret!)
        try! Auth.auth().signOut()
        self.performSegue(withIdentifier: "authentication", sender: self)
    }
    
    @IBAction func mapping(_ sender: AnyObject){

        var incident = Incident()
        let group = DispatchGroup()
        group.enter()
        incident = systemManager.getIncident(group: group)
        
        group.notify(queue: .main) {
            
            let latitude: CLLocationDegrees = incident.latitude
            let longitude: CLLocationDegrees = incident.longitude
            let regionDistance: CLLocationDistance = 0.01
            let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
            let regionSpan = MKCoordinateRegionMakeWithDistance(coordinates, regionDistance, regionDistance)
            let options = [MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center), MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)]
            let placeMark = MKPlacemark(coordinate: coordinates)
            let mapItem = MKMapItem(placemark: placeMark)
            mapItem.name = "Patient"
            mapItem.openInMaps(launchOptions: options)
        }
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        //let secret = segue.destination as! MapController
        
        //if(self.secret != ""){
           // secret.secret = self.secret
        //}
    }
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
