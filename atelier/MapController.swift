    import UIKit
    import MapKit
    import CoreLocation
    import CoreData
class MapController: UIViewController {

    @IBOutlet weak var MapView: MKMapView!
    var Clients: [NSManagedObject] = []
    
       
  
    
        
        override func viewDidLoad() {
            
            super.viewDidLoad()
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                return
            }

            
            let managedContext = appDelegate.persistentContainer.viewContext
            
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Client")
            do {
                Clients = try managedContext.fetch(fetchRequest)
                if  Clients.count > 0 {
                    for r in Clients {
                        let annotation = MKPointAnnotation()
                        if let name = r.value(forKey: "nom") as? String {
                            annotation.title = name
                        }
                        if let lat : String = r.value(forKey: "lat")  as? String {

                            if let lang : String = r.value(forKey: "lang") as? String {
                                annotation.coordinate = CLLocationCoordinate2D(latitude: Double(lat)!, longitude: Double(lang)!)
                            }
                       
                        }
                        
                         MapView.addAnnotation(annotation)
                    }
                }

            } catch let error as NSError {
                print("Could not fetch. \(error), \(error.userInfo)")
            }
       
            
        
        
            
        }
        
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
        
        
}
