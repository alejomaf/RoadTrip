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
    
    
    //Los usuarios se cargan al inicializarse la vista, se utilizan para comprobar que no se repitan ni los correos ni los nombres de usuario
    var usuarios:[Usuario]?
    var nombre: String?
    var contrasena: String?
    var correo: String?
    
    override func viewDidLoad() {
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
