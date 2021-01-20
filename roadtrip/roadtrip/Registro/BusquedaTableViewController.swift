import UIKit
import CoreData

class BusquedaTableViewController: UITableViewController {

	let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
	var registros: [Registro]?
	var nombreRegistroCreado : String = ""
	
    override func viewDidLoad() {
        super.viewDidLoad()
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
		print(registros!.count)
		
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

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}