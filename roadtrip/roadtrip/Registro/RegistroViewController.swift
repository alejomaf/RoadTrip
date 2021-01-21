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
    @IBOutlet weak var guardarBtn: UIBarButtonItem!
    
	
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
    var ALGORITMO: Bool = false
    
    var ejex: Float = 0
    var ejey: Float = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

		#if TripTok
            ALGORITMO=true
            guardarBtn?.isEnabled = false
            guardarBtn?.tintColor = UIColor(white: 0, alpha: 0)
		#endif
		
        if(ALGORITMO){
			// Se deshabilitan los botones porque no se puede usar
            botonNo.isEnabled = false
            botonSi.isEnabled = false
            ejex = (MainTabBarController.sesion?.ejex)!
            ejey = (MainTabBarController.sesion?.ejey)!
        }
        
        if(edicion){
			actualizarAtributo(boton: sliderA1, texto: textoA1, valor: (registro?.a01)!)
			actualizarAtributo(boton: sliderA2, texto: textoA2, valor: (registro?.a02)!)
			actualizarAtributo(boton: sliderA3, texto: textoA3, valor: (registro?.a03)!)
			actualizarAtributo(boton: sliderA4, texto: textoA4, valor: (registro?.a04)!)
			actualizarAtributo(boton: sliderA5, texto: textoA5, valor: (registro?.a05)!)
			actualizarAtributo(boton: sliderA6, texto: textoA6, valor: (registro?.a06)!)
			
			if ((registro?.satelite)!){
                botonSi.backgroundColor = UIColor.init(red: 0.3, green: 0.8, blue: 0.3, alpha: 1)
                botonNo.backgroundColor = UIColor.gray
                
				salida = 2
			}else{
                botonSi.backgroundColor = UIColor.gray
                botonNo.backgroundColor = UIColor.init(red: 0.8, green: 0.3, blue: 0.3, alpha: 1)
                
				salida = 1
			}
			print("se actualizan los valores")
        }
		
		//Ubico el puntero del mapa en la ubicación predeterminada del usuario previamente cargada en el segue
		pointer.center.x = CGFloat(ejex)
		pointer.center.y = CGFloat(ejey-19.0)+88
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
    
    @IBAction func moverSlider1(_ sender: Any) {
        moverSlider(barra: sliderA1, texto: textoA1, atributo: &a1)
    }
    @IBAction func moverSlider2(_ sender: Any) {
        moverSlider(barra: sliderA2, texto: textoA2, atributo: &a2)
    }
    @IBAction func moverSlider3(_ sender: Any) {
        moverSlider(barra: sliderA3, texto: textoA3, atributo: &a3)
    }
    @IBAction func moverSlider4(_ sender: Any) {
        moverSlider(barra: sliderA4, texto: textoA4, atributo: &a3)
    }
    @IBAction func moverSlider5(_ sender: Any) {
        moverSlider(barra: sliderA5, texto: textoA5, atributo: &a4)
    }
    @IBAction func moverSlider6(_ sender: Any) {
        moverSlider(barra: sliderA6, texto: textoA6, atributo: &a5)
    }
    
    func moverSlider(barra: UISlider, texto: UITextField, atributo: inout Float){
		texto.text = "\(barra.value)".prefix(barra.value < 0 ? 7 : 6).description
		
		
        atributo = barra.value
        registro?.a01 = Float(textoA1.text!)!
        registro?.a02 = Float(textoA2.text!)!
        registro?.a03 = Float(textoA3.text!)!
        registro?.a04 = Float(textoA4.text!)!
        registro?.a05 = Float(textoA5.text!)!
        registro?.a06 = Float(textoA6.text!)!
    }
    
    @IBAction func terminarEditarTexto(_ sender: Any) {
        terminarEditarTextoSlider(boton: sliderA1, texto: textoA1, atributo: a1)
		if(edicion){
			registro?.a01 = Float(textoA1.text!)!
		}else{
			a1 = Float(textoA1.text!)!
		}
    }
    @IBAction func terminarEditarTextoA2(_ sender: Any) {
        terminarEditarTextoSlider(boton: sliderA2, texto: textoA2, atributo: a2)
		if(edicion){
			registro?.a02 = Float(textoA2.text!)!
		}else{
			a2 = Float(textoA2.text!)!
		}
    }
    @IBAction func terminarEditarTextoA3(_ sender: Any) {
        terminarEditarTextoSlider(boton: sliderA3, texto: textoA3, atributo: a3)
		if(edicion){
			registro?.a03 = Float(textoA3.text!)!
		}else{
			a3 = Float(textoA3.text!)!
		}
    }
    @IBAction func terminarEditarTextoA4(_ sender: Any) {
        terminarEditarTextoSlider(boton: sliderA4, texto: textoA4, atributo: a4)
		if(edicion){
			registro?.a04 = Float(textoA4.text!)!
		}else{
			a4 = Float(textoA4.text!)!
		}
    }
    @IBAction func terminarEditarTextoA5(_ sender: Any) {
        terminarEditarTextoSlider(boton: sliderA5, texto: textoA5, atributo: a5)
		if(edicion){
			registro?.a05 = Float(textoA5.text!)!
		}else{
			a5 = Float(textoA5.text!)!
		}
    }
    @IBAction func terminarEditarTextoA6(_ sender: Any) {
        terminarEditarTextoSlider(boton: sliderA6, texto: textoA6, atributo: a6)
		if(edicion){
			registro?.a06 = Float(textoA6.text!)!
		}else{
			a6 = Float(textoA6.text!)!
		}
    }
    
    func terminarEditarTextoSlider( boton: UISlider, texto: UITextField, atributo: Float ){
        let valor = texto.text
        
        if(valor!.isEmpty || valor!=="-") {
            texto.text="0"
            boton.setValue(0, animated: true)
        }
    }
    
    func editarTextoSlider( boton: UISlider, texto: UITextField, atributo: inout Float ){
        let valor = texto.text
        
        if(valor!.isEmpty||valor!=="-") {
            do {
                boton.setValue(Float(try getFloat(valor!)), animated: true)
                atributo = Float(boton.value)
            } catch MyError.conversionError {
                boton.setValue(0.0, animated: true)
                texto.text = "\(0.0)"
                atributo = 0.0
            } catch{
                boton.setValue(0.0, animated: true)
                texto.text = "\(0.0)"
                atributo = 0.0
            }
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
		pointer.center.y = CGFloat(ejey - 19) + 88
    }
    
    @IBAction func pulsarBotonSi(_ sender: Any) {
        registro?.satelite = edicion
		botonSi.backgroundColor = UIColor.init(red: 0.3, green: 0.8, blue: 0.3, alpha: 1)
        botonNo.backgroundColor = UIColor.gray
        
		salida = 2
    }
    
    @IBAction func pulsaBotonNo(_ sender: Any) {
		registro?.satelite = !edicion
		botonSi.backgroundColor = UIColor.gray
        botonNo.backgroundColor = UIColor.init(red: 0.8, green: 0.3, blue: 0.3, alpha: 1)
		
		salida = 1
    }
    
    @IBAction func crearOModificarRegistro(_ sender: Any) {
        if(edicion){
            registro?.ejex = ejex
            registro?.ejey = ejey
            registro?.a01 = Float(textoA1.text!)!
            registro?.a02 = Float(textoA2.text!)!
            registro?.a03 = Float(textoA3.text!)!
            registro?.a04 = Float(textoA4.text!)!
            registro?.a05 = Float(textoA5.text!)!
            registro?.a06 = Float(textoA6.text!)!
        }else{
            a1 = Float(textoA1.text!)!
            a2 = Float(textoA2.text!)!
            a3 = Float(textoA3.text!)!
            a4 = Float(textoA4.text!)!
            a5 = Float(textoA5.text!)!
            a6 = Float(textoA6.text!)!
        }
        
    
    }
    
    @IBAction func calcular(_ sender: Any) {
		//Ejecutar algoritmo
		let salidaAlgoritmo = algoritmo(a03: a3, a04: a4, a05: a5, a06: a6)
        
		//Actualizar botones según resultado
        if(salidaAlgoritmo){
            botonSi.backgroundColor = UIColor.init(red: 0.3, green: 0.8, blue: 0.3, alpha: 1)
            botonNo.backgroundColor = UIColor.gray
            
            if(edicion){
                registro?.satelite = true
            }else{
                salida = 2
            }
            
        }else{
            botonSi.backgroundColor = UIColor.gray
            botonNo.backgroundColor = UIColor.init(red: 0.8, green: 0.3, blue: 0.3, alpha: 1)
            
            if(edicion){
                registro?.satelite = false
            }else{
                salida = 1
            }
        }
	}
    
    func algoritmo(a03: Float, a04: Float, a05: Float, a06: Float) -> Bool {
        if (a05 <= 0.0409) {
            return false
        } else {
            if (a03 <= 0.25316) {
                return !(a03 <= 0.10135)
            } else {
                if (a06 <= -0.22703) {
                    if(a06 <= -1) {
                        return false
                    } else {
                        return !(a05 <= 0.95455)
                    }
                } else {
                    if (a04 <= -0.38293) {
                        if (a06 <= 0.85388) {
                            return !(a04 <= -0.86701)
                        } else {
                            return false
                        }
                    } else {
                        return true
                    }
                }
            }
        }
    }
	
	override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
		if (!(identifier=="crearUbicacionRegistro"||identifier=="crearRegistro"||identifier=="verRegistro")) {
			//Es el unwind, es decir, cuando se va a crear o actualizar un registro
			if(salida==0){
				showAlert(titulo: "Selecciona si hay satélite",texto: "Seleccion 'Si' o 'No' para saber si hay satélite")
				return false;
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
	
	//Configuro los botones de crear ubicación para que el unwind esté bien programado
	override func prepare(for segue: UIStoryboardSegue, sender: Any?){
		if segue.identifier == "crearUbicacionRegistro" {
			let viewDestiny = segue.destination as! CrearUbicacionViewController
			viewDestiny.isCreacion = true
			viewDestiny.x = ejex
			viewDestiny.y = ejey
		}
	}
	
}
