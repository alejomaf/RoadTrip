//
//  IniciarSesionViewController.swift
//  roadtrip
//
//  Created by Alejo Martín Arias Filippo on 01/12/2020.
//  Copyright © 2020 ual. All rights reserved.
//

import UIKit
import CoreData

class IniciarSesionViewController: UIViewController {
    @IBOutlet weak var nombre: UITextField!
    @IBOutlet weak var contrasena: UITextField!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var usuarios:[Usuario]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cogerUsuarios()
    }
    
    func saveData(){
        do{
            try context.save()
        }catch{
            print("Error al guardar el usuario")
        }
        cogerUsuarios()
    }
    
    func cogerUsuarios(){
        let request : NSFetchRequest<Usuario> = Usuario.fetchRequest()
        do{
            self.usuarios = try context.fetch(request)
        }catch{
            print("Error cargando las páginas")
        }
    }
    
    func iniciarSesion(nombre: String, contrasena: String) -> Bool{
        if(usuarios?.count==0) {return false}
        for usuario in usuarios!{
            if(usuario.nombre==nombre){
                if(usuario.contrasena==contrasena){
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
    
    func registrarse(nombre: String, contrasena: String, correo:String){
        let nuevoUsuario = Usuario(context: self.context)
        nuevoUsuario.nombre = nombre
        nuevoUsuario.contrasena = contrasena
        nuevoUsuario.correo = correo
        nuevoUsuario.ubicacion = nil
        
        self.usuarios?.append(nuevoUsuario)
        self.saveData()
    }
    
    
    
    //Segue para cuando va a registrarse el usuario o consigue iniciar sesión
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.identifier == "registrarse"{
            let viewDestiny = segue.destination as! RegistrarseViewController
            viewDestiny.usuarios = usuarios
        }else if segue.identifier == "iniciarSesion"{
            
            //let viewDestiny = segue.destination as! RegistroTableViewController
        }
    }
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "iniciarSesion"{
            if(nombre.text==""||contrasena.text==""){return false}
            return iniciarSesion(nombre: nombre.text!, contrasena: contrasena.text!)
        }
        return true
    }
    
    @IBAction func guardarNota(sender: UIStoryboardSegue){
        let nombre=(sender.source as! RegistrarseViewController).usuarioL.text
        let correo=(sender.source as! RegistrarseViewController).correoElectronicoL.text
        let contrasena=(sender.source as! RegistrarseViewController).contrasenaL1.text
        
        registrarse(nombre: nombre!, contrasena: correo!, correo: contrasena!)
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
