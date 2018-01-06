
import UIKit
import CoreData
import CoreLocation
import MapKit

class ViewController: UIViewController , UIPickerViewDelegate , UIImagePickerControllerDelegate , UINavigationControllerDelegate{

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var Tel: UITextField!
 
    @IBOutlet weak var Prenom: UITextField!
    
    @IBOutlet weak var Nom: UITextField!
    
    @IBOutlet weak var Reste: UITextField!
    @IBOutlet weak var mapview: MKMapView!
    @IBOutlet weak var Img: UIButton!
    
    @IBOutlet weak var Code: UITextField!
    
    var imagePicker: UIImagePickerController!
     let annotation = MKPointAnnotation()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imgView.image = UIImage(named: "Image")

    }
    @IBAction func AddImage(_ sender: Any) {
        
         present(imagePicker, animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let img = info[UIImagePickerControllerOriginalImage] as? UIImage
        {
            imgView.image = img
        }
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    

    @IBAction func Save(_ sender: Any) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let context = appDelegate.persistentContainer.viewContext
   
        
        let picture = Image(context: context)
        picture.image = imgView.image
       
    
       
        
        
        // inserer new object
        let  newClient = NSEntityDescription.insertNewObject(forEntityName: "Client", into: context)
     //   newClient.setValue(picture, forKey: "image")
        newClient.setValue(Nom.text, forKey: "nom")
        newClient.setValue(Prenom.text, forKey: "prenom")
        newClient.setValue(Tel.text, forKey: "telephone")
        newClient.setValue(Int(Code.text!), forKey: "code")
        newClient.setValue(String(format:"%f", lat), forKey: "lat")
        newClient.setValue(String(format:"%f", lng), forKey: "lang")
         newClient.setValue(Double(Reste.text!), forKey: "reste")
   /*     let img = UIImage(named: "test")
        let imgData = UIImagePNGRepresentation(img!)! as NSData

         newClient.setValue(imgData, forKey: "image")*/
       

         newClient.setValue(picture, forKey: "toImage")
        do {
            //
            try context.save()
            print("saved")
           Code.text = ""
             Prenom.text = ""
             Nom.text = ""
             Tel.text = ""
            Reste.text = ""
              self.mapview.removeAnnotation(annotation)
            let Alertctr = UIAlertController(title: "alert", message: "Client bien ajouter", preferredStyle: .alert)
             // creer action de  l alert
            let AlertAct = UIAlertAction(title: "Ok", style: .default, handler: { (action) -> Void in
                self.performSegue(withIdentifier: "List", sender: self)
            
            })
             // ajoute l action a alert
             Alertctr.addAction(AlertAct)
             // ajout alert a view controller
             self.present(Alertctr, animated: true, completion: nil)
            
        }
        catch {
            // : error
        }
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var lat:Double = 0
    var lng:Double = 0

    @IBAction func addPin(_ sender: UILongPressGestureRecognizer) {
    
            
            let location = sender.location(in: self.mapview)
            let locCoord = self.mapview.convert(location,toCoordinateFrom: self.mapview)
            lat = locCoord.latitude
            lng = locCoord.longitude
            
            
        
            annotation.coordinate = locCoord
            annotation.title = "client"
            annotation.subtitle = "l adresse de client"
            
            
            self.mapview.removeAnnotations(mapview.annotations)
            self.mapview.addAnnotation(annotation)
            
        }
        

    

        
        

    
    
        
    
  
}

