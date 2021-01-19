//
//  RegistrarseViewController.swift
//  roadtrip
//
//  Created by Alejo Martín Arias Filippo on 01/12/2020.
//  Copyright © 2020 ual. All rights reserved.
//

import UIKit

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

        // Do any additional setup after loading the view.
    }
    
    
    //Compruebo que el nombre no existe en nuestra base de datos
    func checkNombre(nombre:String) -> Bool{
        if (usuarios?.count==0) {return true}
        for usuario in usuarios!{
            if(usuario.nombre==nombre){
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
        crearCuenta.isEnabled = !(usuarioL.text=="" || correoElectronicoL.text==""||contrasenaL1.text=="" || contrasenaL1.text != contrasenaL2.text || !correoValido || !nombreValido)
    }
    
     @IBAction func registrarse(sender: UIStoryboardSegue) {
        let nuevoUsuario = Usuario(context: context)
        nuevoUsuario.nombre = usuarioL.text
        nuevoUsuario.contrasena = contrasenaL1.text
        nuevoUsuario.correo = correoElectronicoL.text
        nuevoUsuario.ubicacion = nil
        
        do {
            context.insert(nuevoUsuario)
            try context.save()
        } catch {
            print("Error al guardar el usuario")
        }
		
		print("Usuario registrado.")
    }
    
    //Configuro los botones de crear ubicación para que el unwind esté bien programado
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.identifier == "crearUbicacionPredeterminada" {
            let viewDestiny = segue.destination as! CrearUbicacionViewController
            viewDestiny.isCreacion = true
            viewDestiny.x = ejex
            viewDestiny.y = ejey
        }
    }
    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
