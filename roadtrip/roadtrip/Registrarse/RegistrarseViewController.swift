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
    
    
    //Los usuarios se cargan al inicializarse la vista, se utilizan para comprobar que no se repitan ni los correos ni los nombres de usuario
    var usuarios:[Usuario]?
    var nombre: String?
    var contrasena: String?
    var correo: String?
    var correoValido: Bool = false
    var nombreValido: Bool = false
    
    override func viewDidLoad() {
        crearCuenta.isEnabled=false
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func checkNombre(nombre:String) -> Bool{
        if (usuarios?.count==0) {return true}
        for usuario in usuarios!{
            if(usuario.nombre==nombre){
                return false
            }
        }
        return true
    }
    
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
    
    func actualizarBoton(){
        if(usuarioL.text==""||correoElectronicoL.text==""||contrasenaL1.text==""||contrasenaL2.text==""||correoValido==false||nombreValido==false){
            crearCuenta.isEnabled = false
        }else{
            crearCuenta.isEnabled = true
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
