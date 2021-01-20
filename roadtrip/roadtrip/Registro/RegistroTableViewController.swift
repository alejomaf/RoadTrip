//
//  InicioViewController.swift
//  roadtrip
//
//  Created by Aula11 on 26/11/20.
//  Copyright © 2020 ual. All rights reserved.
//

import UIKit
import CoreData

class RegistroTableViewController: UITableViewController{
    
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var registros: [Registro]?
    var usuarioSesion: Usuario?
    var usuarios : [Usuario]?
	var nombreRegistroCreado : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let request : NSFetchRequest<Usuario> = Usuario.fetchRequest()
        do{
            usuarios = try context.fetch(request)
        }catch{
            print("Error cargando las páginas")
        }
        
        let nombreAux = UserDefaults.standard.string(forKey: "username")
        let contrasenaAux = UserDefaults.standard.string(forKey: "password")
        
        for usuarioB in usuarios! {
            if(usuarioB.nombre == nombreAux) {
                if(usuarioB.contrasena == contrasenaAux) {
                    usuarioSesion = usuarioB
                }
            }
        }
        
        
        cogerRegistros()
        //tableView.reloadData()
    }
    
    func saveData() {
        do {
            try context.save()
        } catch {
            print("Error al guardar el usuario")
        }
        cogerRegistros()
    }
    
    func cogerRegistros(){
        self.registros = usuarioSesion?.registros?.array as? [Registro]
        
        
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
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
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print (registros?.count ?? 0)
        return registros?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RegistroTableViewCell", for: indexPath) as! RegistroTableViewCell
        let row = registros?[indexPath.row]
        
        cell.titleLbl.text = row?.value(forKey: "nombre") as? String ?? "Sin nombre"
        cell.dateLbl.text = (row?.value(forKey: "fecha") as? Date)?.description ?? "-"
        //cell.validationBorder.backgroundColor = validationColor(row?.value(forKey: "resultado") as? Bool)
        
        return cell
    }
	
	
    func anadirRegistro(a1:Float,a2:Float,a3:Float,a4:Float,a5:Float,a6:Float, ejex:Double, ejey: Double) {
        let nuevoRegistro = Registro(context: self.context)
        nuevoRegistro.a01 = a1
        nuevoRegistro.a02 = a2
        nuevoRegistro.a03 = a3
        nuevoRegistro.a04 = a4
        nuevoRegistro.a05 = a5
        nuevoRegistro.a06 = a6
        nuevoRegistro.ubicacion?.horizontal = ejex
        nuevoRegistro.ubicacion?.vertical = ejey
        nuevoRegistro.usuario = usuarioSesion
        nuevoRegistro.nombre = nombreRegistroCreado
        nuevoRegistro.fecha = Date() as NSDate
        
        print("\(a1), \(a2),\(a3),\(a4), \(ejex), \(ejey)")
        usuarioSesion?.addToRegistros(nuevoRegistro)
        self.saveData()
    }
    
    @IBAction func guardarRegistro(sender: UIStoryboardSegue) {
        let a1 = (sender.source as! RegistroViewController).a1
        let a2 = (sender.source as! RegistroViewController).a2
        let a3 = (sender.source as! RegistroViewController).a3
        let a4 = (sender.source as! RegistroViewController).a4
        let a5 = (sender.source as! RegistroViewController).a5
        let a6 = (sender.source as! RegistroViewController).a6
        
        let ejex = (sender.source as! RegistroViewController).ejex
        let ejey = (sender.source as! RegistroViewController).ejey

		self.anadirRegistro(a1: a1, a2: a2, a3: a3, a4: a4, a5: a5, a6: a6, ejex: Double(ejex),ejey: Double(ejey))
	}
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "verRegistro" {
			let selectedRow = tableView.indexPath(for: sender as! RegistroTableViewCell)?.row
			let viewDestiny = segue.destination as! RegistroViewController
			viewDestiny.registro = registros?[selectedRow!]
			viewDestiny.edicion = true
		}
    }
	
	override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
		if identifier == "crearRegistro" {
			
			//Es el unwind, es decir, cuando se va a crear o actualizar un registro
			let alert = UIAlertController(title: "Ingresa el nombre del registro", message: nil, preferredStyle: .alert)
			alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
			
			
			let okAction = UIAlertAction(title: "Crear", style: .default) { (_) in
				// Print "OK Tapped" to the screen when the user taps OK
				self.nombreRegistroCreado = (alert.textFields?.first?.text)!
				self.performSegue(withIdentifier: "crearRegistro", sender: nil)
			}
			okAction.isEnabled = false
			// Add the OK Button to the Alert Controller
			alert.addAction(okAction)
			
			alert.addTextField { (textField) in
				
				// Observe the UITextFieldTextDidChange notification to be notified in the below block when text is changed
				NotificationCenter.default.addObserver(forName: UITextField.textDidChangeNotification, object: textField, queue: OperationQueue.main, using:
					{_ in
						// Being in this block means that something fired the UITextFieldTextDidChange notification.
						textField.placeholder = "Nombre"
						// Access the textField object from alertController.addTextField(configurationHandler:) above and get the character count of its non whitespace characters
						let textCount = textField.text?.trimmingCharacters(in: .whitespacesAndNewlines).count ?? 0
						let textIsNotEmpty = textCount > 0
						
						// If the text contains non whitespace characters, enable the OK Button
						okAction.isEnabled = textIsNotEmpty
						
				})
				
			}
			
			self.present(alert, animated: true)
		}
		return true
	}
}
