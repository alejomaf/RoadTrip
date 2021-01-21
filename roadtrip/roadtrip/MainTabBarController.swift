//
//  MainTabBarController.swift
//  roadtrip
//
//  Created by Aula11 on 20/1/21.
//  Copyright © 2021 ual. All rights reserved.
//

import UIKit
import CoreData

class MainTabBarController: UITabBarController {
	
	static var sesion: Usuario?

	let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
	
    override func viewDidLoad() {
		super.viewDidLoad()
		
		if(UserDefaults.standard.string(forKey: "username")!.count > 0) {
			let request : NSFetchRequest<Usuario> = Usuario.fetchRequest()
			let nombreAux = UserDefaults.standard.string(forKey: "username")
			let contrasenaAux = UserDefaults.standard.string(forKey: "password")
			
			do{
				for usuario in try context.fetch(request) {
					if(usuario.nombre == nombreAux) {
						if(usuario.contrasena == contrasenaAux) {
							MainTabBarController.sesion = usuario
							print(usuario.ejex)
							print(usuario.ejey)
						}
					}
				}
			}catch{
				print("Error cargando las páginas")
			}
		}
		
		#if imaginRoad
			viewControllers?.remove(at: 2)
		#endif
    }

}
