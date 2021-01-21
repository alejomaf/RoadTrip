import UIKit
import CoreData

class BusquedaTableViewController: RegistroTableViewController, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    
    /*let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
	var registros: [Registro]?*/
	
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }
	/*
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
		
		cell.titleLbl.text = row?.value(forKey: "nombre") as? String ?? "Sin nombre"
		cell.dateLbl.text = (row?.value(forKey: "ubicacion") as? Ubicacion)?.description
		cell.validationBorder.backgroundColor = RegistroTableViewController.validationColor(row?.value(forKey: "satelite") as? Bool)
		
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
		}
	}
	*/
	
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
