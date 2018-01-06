//
//  EditController.swift
//  atelier
//
//  Created by mac on 10/06/2017.
//  Copyright © 2017 mac. All rights reserved.
//

import UIKit
import MapKit
import CoreData

class EditController: UIViewController , UIPickerViewDelegate , UIImagePickerControllerDelegate , UINavigationControllerDelegate {

    var v12 = String()
    var v22 = String()
    var v32 = String()
    var v42 = String()
    var v52 = String()
    var v62 = UIImage()
    var annotation2 = MKPointAnnotation()
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var code: UILabel!
    @IBOutlet weak var Nom: UITextField!
    
    @IBOutlet weak var prenom: UITextField!
    
    
    @IBOutlet weak var reste: UITextField!
    @IBOutlet weak var Tel: UITextField!
    var imagePicker: UIImagePickerController!
    @IBOutlet weak var mapView: MKMapView!
    var Clients: [NSManagedObject] = []
    
    @IBAction func EditImage(_ sender: Any) {
        present(imagePicker, animated: true, completion: nil)

    }
    @IBAction func Precedent(_ sender: UIButton) {
         self.dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let img = info[UIImagePickerControllerOriginalImage] as? UIImage
        {
            image.image = img
        }
        imagePicker.dismiss(animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        mapView.addAnnotation(annotation2)
        
        code.text = v12
        Nom.text = v22
        prenom.text = v32
        Tel.text = v42
        reste.text = v52
        image.image = v62
        print("secondpage")
        print(v12)
        print(v22)
        print(v32)
    }

    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func Edit(_ sender: UIButton) {
       
        let AlrtController = UIAlertController(title: "Update", message: "voulez vraiment enregistrer les modifications ??", preferredStyle: .alert)
        let AlrtActionConcel = UIAlertAction(title: "annuler", style: .default, handler:{ (action) -> Void in
        self.performSegue(withIdentifier: "list", sender: self)
        })
        let AlrtActionUpdate = UIAlertAction(title: "Confirmer", style: .default, handler: { (action) -> Void in
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                return
            }
            
            let managedContext = appDelegate.persistentContainer.viewContext
            let picture = Image(context: managedContext)
            picture.image = self.image.image

            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Client")
            do {
                self.Clients = try managedContext.fetch(fetchRequest)
            } catch let error as NSError {
                print("Could not fetch. \(error), \(error.userInfo)")
            }
            
            if self.Clients.count > 0 {
                for r in self.Clients {
                    let k = r.value(forKey: "code") as! Int
                    let n = String(k)
                    if self.v12 == n {
                        r.setValue(Double(self.reste.text!), forKey: "reste")
                        r.setValue(self.Nom.text, forKey: "nom")
                         r.setValue(self.prenom.text, forKey: "prenom")
                         r.setValue(self.Tel.text, forKey: "telephone")
                        r.setValue(String(format:"%f", self.lat), forKey: "lat")
                        r.setValue(String(format:"%f", self.lng), forKey: "lang")
                        r.setValue(picture, forKey: "toImage")
                    }
                    
                
                }
            }
            do {
                try managedContext.save()
            } catch _ {
            }

           self.performSegue(withIdentifier: "list", sender: self)
                  })
        AlrtController.addAction(AlrtActionConcel)
        AlrtController.addAction(AlrtActionUpdate)
        self.present(AlrtController, animated: true, completion: nil)

    }
    
    var lat:Double = 0
    var lng:Double = 0
    
    @IBAction func AddPin(_ sender: UILongPressGestureRecognizer) { let location = sender.location(in: self.mapView)
        let locCoord = self.mapView.convert(location,toCoordinateFrom: self.mapView)
        lat = locCoord.latitude
        lng = locCoord.longitude
        
        
        
        annotation2.coordinate = locCoord
        annotation2.title = "client"
        annotation2.subtitle = "l adresse de client"
        
        
        self.mapView.removeAnnotations(mapView.annotations)
        self.mapView.addAnnotation(annotation2)
        
    }
    
   
    
}
