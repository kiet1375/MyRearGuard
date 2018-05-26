//
//  MapController.swift
//  Medic
//
//  Created by Kiet Lam on 22/5/18.
//  Copyright © 2018 Kiet Lam. All rights reserved.
//

import UIKit
import MapKit
import FirebaseDatabase

class MapController: UIViewController, MKMapViewDelegate {
    
    var secret: String?
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var email: UILabel!
    
    var db: DatabaseReference?
    var handle:DatabaseHandle?
    
    
    @IBAction func mapping(_ sender: AnyObject)
    {
        self.email.text = self.secret
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

