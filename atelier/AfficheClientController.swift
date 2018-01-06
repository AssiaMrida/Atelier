//
//  AfficheClientController.swift
//  atelier
//
//  Created by mac on 09/06/2017.
//  Copyright © 2017 mac. All rights reserved.
//

import UIKit
import MapKit
import CoreData

class AfficheClientController: UIViewController {


    @IBOutlet weak var MapView: MKMapView!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var code: UILabel!

    @IBOutlet weak var tel: UILabel!
    @IBOutlet weak var nom: UILabel!
    @IBOutlet weak var Prenom: UILabel!
    
    
    @IBOutlet weak var Reste: UILabel!
    var v1 = String()
    var v2 = String()
    var v3 = String()
    var v4 = String()
    var v5 = String()
    var v7 = UIImage()
    
    var annotation = MKPointAnnotation()
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
    @IBAction func Precedent(_ sender: UIButton) {
         self.dismiss(animated: true, completion: nil)
    }
 
    @IBAction func PageEdit(_ sender: Any) {
        self.performSegue(withIdentifier: "Edit", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Edit" {
            
            
            let vueDestination = segue.destination as! EditController
            
            vueDestination.v12 =  code.text!
            
            vueDestination.v22 = nom.text!
            print("prepare")
            print(vueDestination.v22)
            
            vueDestination.v32 = Prenom.text!
            print(vueDestination.v32)
            vueDestination.v42 = tel.text!
            
            print(vueDestination.v42)
            vueDestination.annotation2 = self.annotation
            print("fin prepare")
            print(vueDestination.v52)
            vueDestination.v52 = Reste.text!
            vueDestination.v62 = self.img.image!

        }
        

        
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
      
              
        //  v.img.image = UIImage(data: list[indexPath.row]  as! Data)
        
        MapView.addAnnotation(annotation)

       code.text = v1
        nom.text = v2
        Prenom.text = v3
        tel.text = v4
         Reste.text = v5
        img?.image = v7
        print("secondpage")
        print(v1)
        print(v2)
        print(v3)
        print(v4)
        print(v5)
        
        // Do any additional setup after loading the view.
    }
    

}
