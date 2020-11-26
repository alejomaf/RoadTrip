//
//  InicioViewController.swift
//  roadtrip
//
//  Created by Aula11 on 26/11/20.
//  Copyright © 2020 ual. All rights reserved.
//

import UIKit
import CoreData

class InicioViewController: UIViewController, UITableViewDataSource {
    
    var registros: [NSManagedObject] = [NSManagedObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    // MARK: - Functions
    
    func validationColor(_ valid: Bool?) -> UIColor {
        if(valid == nil){
            return UIColor.init(red: 204, green: 187, blue: 85, alpha: 1)
        }
        
        return valid!
            ? UIColor.init(red: 85, green: 204, blue: 85, alpha: 1)
            : UIColor.init(red: 204, green: 85, blue: 85, alpha: 1)
    }
    
    // MARK: - TableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return registros.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RegistroTableViewCell", for: indexPath) as! RegistroTableViewCell
        let row = registros[indexPath.row]
        
        cell.titleLbl.text = row.value(forKey: "nombre") as? String ?? "Sin nombre"
        cell.dateLbl.text = (row.value(forKey: "fecha") as? Date ?? Date.distantPast).description
        cell.validationBorder.backgroundColor = validationColor(row.value(forKey: "resultado") as? Bool)
        
        return cell
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
}
