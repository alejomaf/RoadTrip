//
//  RegistroViewController.swift
//  roadtrip
//
//  Created by Alejo Martín Arias Filippo on 01/12/2020.
//  Copyright © 2020 ual. All rights reserved.
//

import UIKit

class RegistroViewController: UIViewController {
    
    @IBOutlet weak var textoA1: UITextField!
    @IBOutlet weak var textoA2: UITextField!
    @IBOutlet weak var textoA3: UITextField!
    @IBOutlet weak var textoA4: UITextField!
    @IBOutlet weak var textoA5: UITextField!
    @IBOutlet weak var textoA6: UITextField!
	
    @IBOutlet weak var sliderA1: UISlider!
    @IBOutlet weak var sliderA2: UISlider!
    @IBOutlet weak var sliderA3: UISlider!
    @IBOutlet weak var sliderA4: UISlider!
    @IBOutlet weak var sliderA5: UISlider!
    @IBOutlet weak var sliderA6: UISlider!
	
    @IBOutlet weak var botonNo: UIButton!
    @IBOutlet weak var botonSi: UIButton!
	
    @IBOutlet weak var pointer: UIImageView!
    @IBOutlet weak var mapa: UIImageView!
	
	// Registro que se va a editar
    var registro: Registro? = nil
	
	// False = Se está creando el registro | True = Se está creando
    var edicion: Bool = false
	
	
	// 0 = Salida no seleccionada | 1 = No hay satélite | 2 = Hay satélite
	var salida: Int = 0
	
	// Atributos inicializados a cero
    var a1 : Float = 0.0
    var a2 : Float = 0.0
    var a3 : Float = 0.0
    var a4 : Float = 0.0
    var a5 : Float = 0.0
    var a6 : Float = 0.0
    
    //Algoritmo activado o desactivado
    var ALGORITMO: Bool = true
    
    var ejex: Float = 0
    var ejey: Float = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if(ALGORITMO){
			// Se deshabilitan los botones porque no se puede usar
            botonNo.isEnabled = false
            botonSi.isEnabled = false
        }
        
        if(edicion){
            actualizarAtributo(boton: sliderA1, texto: textoA1, valor: a1)
            actualizarAtributo(boton: sliderA2, texto: textoA2, valor: a2)
            actualizarAtributo(boton: sliderA3, texto: textoA3, valor: a3)
            actualizarAtributo(boton: sliderA4, texto: textoA4, valor: a4)
            actualizarAtributo(boton: sliderA5, texto: textoA5, valor: a5)
            actualizarAtributo(boton: sliderA6, texto: textoA6, valor: a6)
        }
		
		//Ubico el puntero del mapa en la ubicación predeterminada del usuario previamente cargada en el segue
		pointer.center.x = CGFloat(ejex)
		pointer.center.y = CGFloat(ejey-30.0)+88
    }
    
    @IBAction func editarTexto(_ sender: Any) {
		editarTextoSlider(boton: sliderA1, texto: textoA1, atributo: &a1)
    }
    @IBAction func editarTextoA2(_ sender: Any) {
        editarTextoSlider(boton: sliderA2, texto: textoA2, atributo: &a2)
    }
    @IBAction func editarTextoA3(_ sender: Any) {
        editarTextoSlider(boton: sliderA3, texto: textoA3, atributo: &a3)
    }
    @IBAction func editarTextoA4(_ sender: Any) {
        editarTextoSlider(boton: sliderA4, texto: textoA4, atributo: &a4)
    }
    @IBAction func editarTextoA5(_ sender: Any) {
        editarTextoSlider(boton: sliderA5, texto: textoA5, atributo: &a5)
    }
    @IBAction func editarTextoA6(_ sender: Any) {
        editarTextoSlider(boton: sliderA6, texto: textoA6, atributo: &a6)
    }
    
    @IBAction func terminarEditarTexto(_ sender: Any) {
        terminarEditarTextoSlider(boton: sliderA1, texto: textoA1, atributo: a1)
    }
    @IBAction func terminarEditarTextoA2(_ sender: Any) {
        terminarEditarTextoSlider(boton: sliderA2, texto: textoA2, atributo: a2)
    }
    @IBAction func terminarEditarTextoA3(_ sender: Any) {
        terminarEditarTextoSlider(boton: sliderA3, texto: textoA3, atributo: a3)
    }
    @IBAction func terminarEditarTextoA4(_ sender: Any) {
        terminarEditarTextoSlider(boton: sliderA4, texto: textoA4, atributo: a4)
    }
    @IBAction func terminarEditarTextoA5(_ sender: Any) {
        terminarEditarTextoSlider(boton: sliderA5, texto: textoA5, atributo: a5)
    }
    @IBAction func terminarEditarTextoA6(_ sender: Any) {
        terminarEditarTextoSlider(boton: sliderA6, texto: textoA6, atributo: a6)
    }
    
    func terminarEditarTextoSlider( boton: UISlider, texto: UITextField, atributo: Float ){
        let valor = texto.text
        if(valor!.isEmpty) {
            texto.text="0"
            boton.setValue(0, animated: true)
        }
		actualizarYAlgoritmo()
    }
    
    func editarTextoSlider( boton: UISlider, texto: UITextField, atributo: inout Float ){
        let valor = texto.text
		
		if(valor!.isEmpty) {return;}
		
		//Esta estructura sirve para saber si el casteo del botón se está realizando de forma incorrecta, si no se están añadiendo letras
        do {
            let b = try getFloat(valor!)
            boton.setValue(Float(b), animated: true)
        } catch MyError.conversionError {
            boton.setValue(Float(0), animated: true)
            texto.text = "\(0.0)"
            atributo = 0.0
        } catch{
            boton.setValue(Float(0), animated: true)
            texto.text = "\(0.0)"
            atributo = 0.0
        }
    }
    
    func actualizarAtributo(boton: UISlider, texto: UITextField, valor: Float){
        boton.setValue(valor, animated: true)
        texto.text = "\(valor)"
    }
    
    enum MyError : Error {
        case conversionError
    }
    
    func getFloat(_ data:String) throws -> Float
    {
        guard let result = Float(data) else { throw MyError.conversionError }
        return result
        
    }
    
    @IBAction func guardarUbicacionRegistro(sender: UIStoryboardSegue) {
        ejex = ((sender.source as! CrearUbicacionViewController).ejex.text! as NSString).floatValue
        ejey = ((sender.source as! CrearUbicacionViewController).ejey.text! as NSString).floatValue
		
		pointer.center.x = CGFloat(ejex)
		pointer.center.y = CGFloat(ejey-30.0)+88
		
        actualizarRegistro()
    }
    
   
    
    @IBAction func pulsarBotonSi(_ sender: Any) {
        botonNo.isSelected = false
        botonSi.isSelected = true
		salida=2
    }
    @IBAction func pulsaBotonNo(_ sender: Any) {
        botonNo.isSelected = true
        botonSi.isSelected = false
		salida=1
    }
    
    
    //Compruebo que el registro es creado correctamente y habilito o deshabilito el botón de creación
    func actualizarRegistro(){
        
    }
    
    @IBAction func crearOModificarRegistro(_ sender: Any) {
        if(edicion){
            registro?.ubicacion?.horizontal = Double(ejex)
            registro?.ubicacion?.vertical = Double(ejey)
            registro?.a01 = Float(textoA1.text!)!
            /*registro?.a02 = Float(textoA2.text!)!
            registro?.a03 = Float(textoA3.text!)!
            registro?.a04 = Float(textoA4.text!)!
            registro?.a05 = Float(textoA5.text!)!
            registro?.a06 = Float(textoA6.text!)!*/
        }else{
            a1 = Float(textoA1.text!)!
            /*a2 = Float(textoA2.text!)!
            a3 = Float(textoA3.text!)!
            a4 = Float(textoA4.text!)!
            a5 = Float(textoA5.text!)!
            a6 = Float(textoA6.text!)!*/
        }
        
    
    }
    
	func actualizarYAlgoritmo(){
		//Ejecutar algoritmo
		
		//Actualizar botones según resultado
	}
    
    func algoritmo(){
		
    }
	
	override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
		if (!(identifier=="crearUbicacionRegistro"||identifier=="crearRegistro"||identifier=="verRegistro")) {
			//Es el unwind, es decir, cuando se va a crear o actualizar un registro
			if(salida==0){
				showAlert(titulo: "Selecciona si hay satélite",texto: "Seleccion 'Si' o 'No' para saber si hay satélite")
				//return false; ACTIVAR CUANDO ESTÉN LAS VISTAS CONFIGURADAS
			}
		}
		return true
	}

	func showAlert(titulo:String,texto:String){
		let alert = UIAlertController(title: titulo, message: texto, preferredStyle: .alert)
		
		alert.addAction(UIAlertAction(title: "Aceptar", style: .cancel, handler: nil))
		
		self.present(alert, animated: true)
	}
	
	
	@IBAction func atras(_ sender: UIBarButtonItem) {
		self.dismiss(animated: true, completion: nil)
	}
	
}
