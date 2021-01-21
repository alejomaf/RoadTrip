//
//  RegistrarseViewController.swift
//  roadtrip
//
//  Created by Alejo Martín Arias Filippo on 01/12/2020.
//  Copyright © 2020 ual. All rights reserved.
//

import UIKit
import CoreData

class RegistrarseViewController: UIViewController {

    
    @IBOutlet weak var usuarioL: UITextField!
    @IBOutlet weak var correoElectronicoL: UITextField!
    @IBOutlet weak var contrasenaL1: UITextField!
    @IBOutlet weak var contrasenaL2: UITextField!
    @IBOutlet weak var crearCuenta: UIButton!
    @IBOutlet weak var ubicacion: UIButton!
	
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
	
    //Los usuarios se cargan al inicializarse la vista, se utilizan para comprobar que no se repitan ni los correos ni los nombres de usuario
    var usuarios:[Usuario]?
    var correoValido: Bool = false
    var nombreValido: Bool = false
    var ejex: Float = 0
    var ejey: Float = 0
    
    override func viewDidLoad() {
        crearCuenta.isEnabled=false
        super.viewDidLoad()
    }
    
    
    //Compruebo que el nombre no existe en nuestra base de datos
    func checkNombre(nombre:String) -> Bool{
        if (usuarios?.count==0) {return true}
        for usuario in usuarios!{
            if(usuario.nombre==nombre){
				showAlert(titulo: "Usuario existente", texto: "El usuario que ha intentado ingresar ya existe")
                return false
            }
        }
        return true
    }
    
    //Compruebo que el correo no existe en nuestra base de datos
    func checkCorreo(correo:String) -> Bool{
        if (usuarios?.count==0) {return true}
        for usuario in usuarios!{
            if(usuario.correo==correo){
				showAlert(titulo: "Correo electrónico registrado", texto: "El correo electrónico que ha intentado ingresar ya ha sido registrado")
                return false
            }
        }
        return true
    }

    @IBAction func actualizaNombre(_ sender: Any) {
        nombreValido = checkNombre(nombre: usuarioL.text!)
        actualizarBoton()
    }
    @IBAction func actualizaCorreo(_ sender: Any) {
        correoValido = checkCorreo(correo: correoElectronicoL.text!)
        actualizarBoton()
    }
    @IBAction func actualizaContrasena1(_ sender: Any) {
        actualizarBoton()
    }
    @IBAction func actualizazContrasena2(_ sender: Any) {
        actualizarBoton()
    }
    
    @IBAction func guardarUbicacionPredeterminada(sender: UIStoryboardSegue) {
        ejex = (sender.source as! CrearUbicacionViewController).x
        ejey = (sender.source as! CrearUbicacionViewController).y
        
        ubicacion.setTitle("\(ejex) | \(ejey)", for: .normal)
        
        actualizarBoton()
    }
    
    func actualizarBoton(){
        crearCuenta.isEnabled = !(usuarioL.text=="" || correoElectronicoL.text==""||contrasenaL1.text=="" || contrasenaL1.text != contrasenaL2.text || !correoValido || !nombreValido || (ejex == 0 && ejey == 0))
    }
    
     
    
    @IBAction func salir(sender: UIStoryboardSegue) {
        dismiss(animated: true, completion: nil)
    }
    
    //Configuro los botones de crear ubicación para que el unwind esté bien programado
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.identifier == "crearUbicacionPredeterminada" {
            let viewDestiny = segue.destination as! CrearUbicacionViewController
            viewDestiny.isCreacion = false
            viewDestiny.x = ejex
            viewDestiny.y = ejey
        }
    }
	
	func showAlert(titulo:String,texto:String){
		let alert = UIAlertController(title: titulo, message: texto, preferredStyle: .alert)
		
		alert.addAction(UIAlertAction(title: "Aceptar", style: .cancel, handler: nil))
		
		self.present(alert, animated: true)
	}
    
    
	@IBAction func registrarse() {
		let nuevoUsuario = Usuario(context: context)
		
		nuevoUsuario.nombre = usuarioL.text
		nuevoUsuario.contrasena = contrasenaL1.text
		nuevoUsuario.correo = correoElectronicoL.text
		nuevoUsuario.ejex = ejex
		nuevoUsuario.ejey = ejey
		
		do {
			context.insert(nuevoUsuario)
			try context.save()
		} catch {
			print("Error al guardar el usuario")
		}
		
		dismiss(animated: true, completion: nil)
	}
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func verPass1(_ sender: Any) {
        if(contrasenaL1.isSecureTextEntry == true){
            contrasenaL1.isSecureTextEntry = false
        }else{
            contrasenaL1.isSecureTextEntry = true
        }
    }
    @IBAction func verPass2(_ sender: Any) {
        if(contrasenaL2.isSecureTextEntry == true){
            contrasenaL2.isSecureTextEntry = false
        }else{
            contrasenaL2.isSecureTextEntry = true
        }
    }
}
