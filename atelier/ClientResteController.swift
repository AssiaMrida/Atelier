//
//  ClientResteController.swift
//  atelier
//
//  Created by mac on 11/06/2017.
//  Copyright © 2017 mac. All rights reserved.
//

import UIKit
import CoreData

class ClientResteController: UIViewController,UITableViewDataSource,UITableViewDelegate{
    
    @IBOutlet weak var tbl: UITableView!
    
    var client: [NSManagedObject] = []

    var Clients: [NSManagedObject] = []
    let appDelegateObj : AppDelegate = UIApplication.shared.delegate as! AppDelegate

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Clients de reste a payer"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        
        
        for person in Clients {
            let r :Double = person.value(forKeyPath: "reste") as! Double
            if r != 0.0 {
                
            client.append(person)
            }
        }
    
        
        
        
    }

    
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return client.count
    }
  
    func tableView(_ tableView: UITableView, cellForRowAt i: IndexPath) -> UITableViewCell {
       
         let managedContext = appDelegateObj.persistentContainer.viewContext
        let v = tableView.dequeueReusableCell(withIdentifier: "CellReste", for: i) as! ClientResteCell
        
        let person = client[i.row]
    
            if person.value(forKeyPath: "prenom") != nil {
                
                v.Prenom?.text = person.value(forKeyPath: "prenom") as? String
            }
            if person.value(forKeyPath: "nom") != nil {
                
                v.Nom?.text = person.value(forKeyPath: "nom") as? String
            }
        let r :Double = person.value(forKeyPath: "reste") as! Double
                v.Reste?.text = String(r)
        var Im = Image(context: managedContext)
        if person.value(forKey: "toImage") != nil {
            Im = person.value(forKey: "toImage") as! Image
            let V = Im.image
            v.img?.image  = V as? UIImage
        }
        

             return v
        }
        
       

    

}
