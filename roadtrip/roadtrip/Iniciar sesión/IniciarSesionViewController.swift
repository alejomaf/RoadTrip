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
    
	func saveData() {
		do {
			try context.save()
		} catch {
			print("Error al guardar el usuario")
		}
		cogerUsuarios()
	}
	
	func cogerUsuarios() {
		let request : NSFetchRequest<Usuario> = Usuario.fetchRequest()
		do{
			self.usuarios = try context.fetch(request)
		}catch{
			print("Error cargando las páginas")
		}
	}
	
	func iniciarSesion(nombre: String, contrasena: String) -> Bool {
        if(usuarios?.count==0){
            print("mal")
            return false}

		for usuario in usuarios! {
			if(usuario.nombre == nombre) {
				if(usuario.contrasena == contrasena) {
					UserDefaults.standard.set(usuario.nombre, forKey:"username");
					UserDefaults.standard.set(usuario.contrasena, forKey:"password");
					UserDefaults.standard.synchronize();
					// Con esto se carga el usuario let user = UserDefaults.standard.array(forKey: "user")as? [Usuario]
					return true
				}
			}
		}
		return false
	}
	
	func registrarse(nombre: String, contrasena: String, correo:String) {
		let nuevoUsuario = Usuario(context: self.context)
		nuevoUsuario.nombre = nombre
		nuevoUsuario.contrasena = contrasena
		nuevoUsuario.correo = correo
		nuevoUsuario.ubicacion = nil
		
		self.usuarios?.append(nuevoUsuario)
		self.saveData()
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
                return false}
            else{
                //Realiza la comprobación del usuario
                return iniciarSesion(nombre: nombre.text!, contrasena: contrasena.text!)}
		}
		return true
	}
	
	@IBAction func guardarNota(sender: UIStoryboardSegue) {
		let nombre = (sender.source as! RegistrarseViewController).usuarioL.text
		let correo = (sender.source as! RegistrarseViewController).correoElectronicoL.text
		let contrasena = (sender.source as! RegistrarseViewController).contrasenaL1.text
		
		registrarse(nombre: nombre!, contrasena: correo!, correo: contrasena!)
	}

}
