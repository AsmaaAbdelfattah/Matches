//
//  FavouritesVC.swift
//  Leagues
//
//  Created by Asmaa_Abdelfattah on 29/01/1403 AP.
//

import UIKit
import CoreData

class FavouritesVC: UIViewController {

    @IBOutlet weak var favouriteTB: UITableView!
    
    @IBOutlet weak var noData: UILabel!
    var managedContext : NSManagedObjectContext!
    var Favourites : Array<NSManagedObject>!
    var coreData : CoreDataManager = CoreDataManager.getInstance()
    override func viewDidLoad() {
        super.viewDidLoad()
        noData.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.Favourites = coreData.fetchFromCoreData()
        if Favourites.count > 0 {
            self.favouriteTB.isHidden = false
            self.noData.isHidden = true
            favouriteTB.reloadData()
        }else{
            self.favouriteTB.isHidden = true
            self.noData.isHidden = false
        }
    }
   

}
extension FavouritesVC:UITableViewDelegate,UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Favourites.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MatchTVCell", for: indexPath) as? MatchTVCell else{return UITableViewCell()}
 
        cell.matchName.text = ((Favourites[indexPath.row].value(forKey: "awayTeam")) as! String) + " - " + ((Favourites[indexPath.row].value(forKey: "homeTeam") ) as! String)
      
        if Favourites[indexPath.row].value(forKey: "status") as! String == "FINISHED"{
            if let away = Favourites[indexPath.row].value(forKey: "awayScore") , let home = Favourites[indexPath.row].value(forKey: "homeScore") {
                cell.status.text = "\(away)" + " - " +  "\(home)"
            }
        }else{
            cell.status.text = (Favourites[indexPath.row].value(forKey: "date") as! String)
        }
        cell.favBtn.isHidden = true
        return cell
    }
}
