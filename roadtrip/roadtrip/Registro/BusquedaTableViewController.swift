import UIKit
import CoreData

class BusquedaTableViewController: UITableViewController, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
	var registros: [Registro]?
	
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(true)
		
		self.registros = MainTabBarController.sesion?.registros?.array as? [Registro]
		tableView.reloadData()
	}
	
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return registros?.count ?? 0
    }
	
	

	
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "RegistroTableViewCell", for: indexPath) as! RegistroTableViewCell
		let row = registros?[indexPath.row]
		
		let dateFormatter = DateFormatter()
		
		//Configuro el tipo de formato de texto para cargarlo en la celda
		dateFormatter.dateFormat = "dd/MM/yyyy - HH:mm"
		dateFormatter.locale = Locale(identifier: "es")
		
		//Añado los atributos que se han generado en la tabla
		cell.titleLbl.text = row?.value(forKey: "nombre") as? String ?? "Sin nombre"
		cell.dateLbl.text = dateFormatter.string(from: (row?.value(forKey: "fecha") as! Date))
		cell.validationBorder.backgroundColor = RegistroTableViewController.validationColor(row?.value(forKey: "satelite") as! Bool?)
		
		return cell
    }

	
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return false
    }
	
	// In a storyboard-based application, you will often want to do a little preparation before navigation
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "verRegistro" {
			let selectedRow = tableView.indexPath(for: sender as! RegistroTableViewCell)?.row
			let viewDestiny = segue.destination as! RegistroViewController
			viewDestiny.registro = registros?[selectedRow!]
			viewDestiny.edicion = true
			viewDestiny.ejex = (registros?[selectedRow!].ejex)!
			viewDestiny.ejey = (registros?[selectedRow!].ejey)!
		}
	}
	
	func saveData() {
		do {
			try context.save()
		} catch {
			print("Error al guardar el usuario")
		}
	}
	
	
	func modificarRegistro(registro: Registro, fila: Int){
		let registro = registros![fila]
		
		self.registros?[fila] = registro
		MainTabBarController.sesion?.replaceRegistros(at: fila, with: registro)
		self.saveData()
		tableView.reloadData()
	}
	
	@IBAction func guardarRegistro(sender: UIStoryboardSegue) {
		//Compruebo si el RegistroViewController estaba editando un atributo o no
		let creacionOModificacion = (sender.source as! RegistroViewController).edicion
		
		if(creacionOModificacion){
			//Modifico el registro
			let filaSeleccionada = tableView.indexPathForSelectedRow?.row
			self.modificarRegistro(registro: (sender.source as! RegistroViewController).registro!, fila: filaSeleccionada!)
			
		}
	}
	
	
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
		var i = 0
		
		self.registros = MainTabBarController.sesion?.registros?.array as? [Registro]
		
		if(searchBar.text?.count ?? 0 > 0) {
			for registro in registros! {
				if(registro.nombre!.uppercased().range(of:searchBar.text?.uppercased() ?? "") == nil) {
					registros!.remove(at: i)
				} else{
					i += 1
				}
			}
		}
        tableView.reloadData()
	}

}
