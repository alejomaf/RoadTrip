//
//  IniciarSesionViewController.swift
//  roadtrip
//
//  Created by Alejo Martín Arias Filippo on 01/12/2020.
//  Copyright © 2020 ual. All rights reserved.
//

import UIKit
import CoreData

class IniciarSesionViewController: UIViewController, UIGestureRecognizerDelegate {
	@IBOutlet weak var nombre: UITextField!
	@IBOutlet weak var contrasena: UITextField!
    @IBOutlet weak var olvidadolbl: UILabel!
    
	let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
	var usuarios:[Usuario]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cogerUsuarios()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self, action: #selector(recordar))
        
        olvidadolbl.addGestureRecognizer(tap)
        
        tap.delegate = self
		
		let nombreAux = UserDefaults.standard.string(forKey: "username")
		let contrasenaAux = UserDefaults.standard.string(forKey: "password")
		
		for usuarioB in usuarios! {
			if(usuarioB.nombre == nombreAux) {
				if(usuarioB.contrasena == contrasenaAux) {
					performSegue(withIdentifier: "iniciarSesion", sender: nil)
				}
			}
		}
		
    }
	
    
    @objc func recordar(sender: UITapGestureRecognizer)
    {
        let alert = UIAlertController(title: "Recordar contraseña", message: "Introduzca su usuario para poder recuperar su contraseña.", preferredStyle: .alert)
		
        alert.addTextField { (textField) in
            textField.placeholder = "Usuario"
        }
        
        alert.addAction(UIAlertAction(title: "Atrás", style: .destructive))
        
        alert.addAction(UIAlertAction(title: "Enviar", style: .default, handler: { [weak alert] (_) in
            let textField = alert!.textFields![0]
            print("Usuario: \(textField.text ?? "Ninguno")")
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
	
	func cogerUsuarios() {
		let request : NSFetchRequest<Usuario> = Usuario.fetchRequest()
		do{
			self.usuarios = try context.fetch(request)
		}catch{
			print("Error cargando los usuarios")
		}
	}
	
	func iniciarSesion(nombre: String, contrasena: String) -> Bool {
        cogerUsuarios()
        
        if(usuarios?.count==0){
            print("Error: No hay usuarios.")
            return false
        }

		for usuario in usuarios! {
			if(usuario.nombre == nombre) {
				if(usuario.contrasena == contrasena) {
					UserDefaults.standard.set(usuario.nombre, forKey:"username");
					UserDefaults.standard.set(usuario.contrasena, forKey:"password");
					UserDefaults.standard.synchronize();
					
                    MainTabBarController.sesion = usuario
					
                    print("El usuario ha iniciado sesión.")
					
					self.nombre.text = ""
					self.contrasena.text = ""
					return true
				}
			}
		}
        
        print("El usuario no ha iniciado sesión.")
        
		return false
	}
	
	//Segue para cuando va a registrarse el usuario o consigue iniciar sesión
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "registrarse" {
			let viewDestiny = segue.destination as! RegistrarseViewController
			viewDestiny.usuarios = usuarios
		} else if segue.identifier == "iniciarSesion" {
            
			//let viewDestiny = segue.destination as! RegistroTableViewController
		}
	}

	override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        
        //Si alguno de los campos de texto se encuentran vacíos no se inicia la comprobación del usuario
		if identifier == "iniciarSesion" {
            if(nombre.text == "" || contrasena.text == ""){
                return false
            }
            else{
                //Realiza la comprobación del usuario
                return iniciarSesion(nombre: nombre.text!, contrasena: contrasena.text!)}
		}
		return true
	}
	
    @IBAction func showPass(_ sender: Any) {
		if(contrasena.isSecureTextEntry == true){
			contrasena.isSecureTextEntry = false
		}else{
			contrasena.isSecureTextEntry = true
		}
    }
    
}
