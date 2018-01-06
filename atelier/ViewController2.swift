import UIKit
import CoreData
import CoreLocation
import MapKit

class ViewController2: UIViewController,UITableViewDataSource,UITableViewDelegate{

    @IBOutlet weak var tbl: UITableView!
   
    var Clients: [NSManagedObject] = []
    let appDelegateObj : AppDelegate = UIApplication.shared.delegate as! AppDelegate
  
    
   
    
     func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Client"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        tbl.reloadData()
    }
    
    
 override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
    
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Client")
        do {
            Clients = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
   /* for r in self.Clients {
    managedContext.delete(r)
       }
    do {
        try managedContext.save()
    } catch _ {
    }
 */

    
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
        func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return Clients.count
    }

    
 func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
    
        if editingStyle == .delete {
            let AlrtController = UIAlertController(title: "Delete", message: "voulez vraiment supprimer ??", preferredStyle: .alert)
            let AlrtActionConcel = UIAlertAction(title: "annuler", style: .cancel, handler: nil)
            let AlrtActionDelete = UIAlertAction(title: "Confirmer", style: .destructive, handler: { (action) -> Void in
                guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                return
                }
                
                let managedContext = appDelegate.persistentContainer.viewContext
                
                managedContext.delete(self.Clients[indexPath.row])
                self.Clients.remove(at: indexPath.row)
                do {
                    try managedContext.save()
                } catch _ {
                }
                self.tbl.deleteRows(at: [indexPath], with: .fade)
               })
            AlrtController.addAction(AlrtActionConcel)
            AlrtController.addAction(AlrtActionDelete)
            self.present(AlrtController, animated: true, completion: nil)
                   }
   
    
    
        }

    var code1 : Int = 0
    var Prenom1 = String()
    var nom1 = String()
    var Tel1 = String()
    var reste1 :Double = 0.0
   var annotation1 = MKPointAnnotation()
    
    var imagek = UIImage()
/*let indexPath = tableView.indexPathForSelectedRow();
 let currentCell = tableView.cellForRowAtIndexPath(indexPath!) as UITableViewCell!;
 
 valueToPass = currentCell.textLabel.text*/
 
func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let indexPath = tbl.indexPathForSelectedRow
   

   // let currentCell = tbl.cellForRow(at: indexPath!) as UITableViewCell!
    let Client = self.Clients[(indexPath?.row)!]
    
    if (Client.value(forKey: "code")) != nil {
        self.code1 = (Client.value(forKey: "code") as? Int)!
        print(code1)
    }
    else{
        print("null value")
    }
    if (Client.value(forKey: "reste")) != nil {
        self.reste1 = (Client.value(forKey: "reste") as? Double)!
        print(reste1)
    }
    else{
        print("null value")
    }

    if (Client.value(forKey: "prenom")) != nil {
        self.Prenom1 =  (Client.value(forKey: "prenom") as? String)!
        print(Prenom1)
    }
    else{
        print("null value")
    }
    if (Client.value(forKey: "nom")) != nil {
        self.nom1 = (Client.value(forKey: "nom") as? String)!
        print(nom1)
    }
    else{
        print("null value")
    }
    if (Client.value(forKey: "telephone")) != nil {
        self.Tel1 = (Client.value(forKey: "telephone") as? String)!
        print(Tel1)
    }else{print("null value")}

   
    if let name = Client.value(forKey: "nom") as? String {
        annotation1.title = name
      
    }
    if let lat : String = Client.value(forKey: "lat")  as? String {
        
        if let lang : String = Client.value(forKey: "lang") as? String {
            annotation1.coordinate = CLLocationCoordinate2D(latitude: Double(lat)!, longitude: Double(lang)!)
        }
        
    }
   let managedContext = appDelegateObj.persistentContainer.viewContext
    var  Im2 = Image(context: managedContext)
   // if (Client.value(forKey: "toImage")) != nil {
        Im2 = (Client.value(forKey: "toImage") as? Image!)!
        self.imagek = Im2.image as! UIImage
       
 //   }


    
    self.performSegue(withIdentifier: "affiche", sender: self)
    
   
    
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
          if segue.identifier == "affiche" {
           
            
                let vueDestination = segue.destination as! AfficheClientController
                
             vueDestination.v1 =  String(self.code1)
            
                    vueDestination.v2 = self.nom1
            print("prepare")
            print(vueDestination.v2)
            
                 vueDestination.v3 = self.Prenom1
            print(vueDestination.v3)
            vueDestination.v5 = String(self.reste1)
            print(vueDestination.v5)
           vueDestination.v4 = self.Tel1
            
            print(vueDestination.v4)
            vueDestination.annotation = self.annotation1
             vueDestination.v7 = self.imagek
            print("fin prepare")
        }
            

            /*
                    vueDestination.code?.text = String(self.code1)
        //vueDestination.MapView = Prenom
        vueDestination.nom?.text = self.nom1
        vueDestination.Prenom?.text = self.Prenom1
        vueDestination.tel?.text = self.Tel1*/
        
        }
    /*override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "affiche" {
            if let personController = segue.destination as? YOURPERSONCONTROLLERCLASS {
                personController.person = selectedPerson
            }
        }
    }*/
    
 /*
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
               }*/
    var k : Int = 0
func tableView(_ tableView: UITableView, cellForRowAt i: IndexPath) -> UITableViewCell {
        
  
    let managedContext = appDelegateObj.persistentContainer.viewContext
    
        let v = tableView.dequeueReusableCell(withIdentifier: "Cell", for: i) as! ClientCell
    
        let person = Clients[i.row]
        let annotation = MKPointAnnotation()
    if person.value(forKeyPath: "code") != nil {
      k = person.value(forKeyPath: "code") as! Int
    }

       
        v.Code?.text = String(k)
        //  v.img?.text = person.value(forKeyPath: "image")
        
        v.Prenom?.text = person.value(forKeyPath: "prenom") as? String
        v.Tel?.text = person.value(forKeyPath: "telephone") as? String
        if let name = person.value(forKey: "nom") as? String {
            annotation.title = name
              v.Nom?.text = person.value(forKeyPath: "nom") as? String
        }
        if let lat : String = person.value(forKey: "lat")  as? String {
            
            if let lang : String = person.value(forKey: "lang") as? String {
                annotation.coordinate = CLLocationCoordinate2D(latitude: Double(lat)!, longitude: Double(lang)!)
            }
            
        }

   
    var Im = Image(context: managedContext)
    if person.value(forKey: "toImage") != nil {
        Im = person.value(forKey: "toImage") as! Image
        let V = Im.image
        v.img?.image  = V as? UIImage
    }

    
    
    

    
    
        v.MapView.addAnnotation(annotation)
      
        return v
        
    }
    


}
