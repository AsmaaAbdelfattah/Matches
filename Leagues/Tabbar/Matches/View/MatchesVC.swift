//
//  ViewController.swift
//  Leagues
//
//  Created by Asmaa_Abdelfattah on 28/01/1403 AP.
//

import UIKit
import NVActivityIndicatorView

class MatchesVC: UIViewController {

    @IBOutlet weak var matchesTB: UITableView!{
        didSet{
            matchesTB.register(UINib(nibName: "MatchTVCell", bundle: nil), forCellReuseIdentifier: "MatchTVCell")
            matchesTB.delegate = self
            matchesTB.dataSource = self
            matchesTB.rowHeight = UITableView.automaticDimension
        }
    }
    @IBOutlet weak var favouriteBtn: UIButton!{
        didSet{
            favouriteBtn.layer.cornerRadius = favouriteBtn.frame.height / 2
            favouriteBtn.layer.shadowColor = UIColor.lightGray.cgColor
            favouriteBtn.layer.shadowOffset = CGSize(width: 0, height: 2)
            favouriteBtn.layer.shadowOpacity = 0.5
            favouriteBtn.layer.shadowRadius = 4
            favouriteBtn.clipsToBounds = false
            favouriteBtn.setTitle("", for: .normal)
        }
    }
    
    @IBOutlet weak var indicator: NVActivityIndicatorView!
    

    var viewModel = MatchesViewModel()
    var dates:[String] = []
    var matches:[Match] = []
    var sectionedMatches: [String: [Match]] = [:]
    var coreData : CoreDataManager = CoreDataManager.getInstance()
    override func viewDidLoad() {
        super.viewDidLoad()
        getMatches()
   
    }
    func getMatches(){
        self.indicator.showIndicator(start: true)
        viewModel.getMatches(url: Networking.matches.fullPath)
        viewModel.bindMatches = {() in
            self.indicator.showIndicator(start: false)
            if self.viewModel.matches.count > 0 {
               // self.sectionedMatches =   self.sectionDataByDates(matches: self.viewModel.matches)
             //   print("section \(self.sectionedMatches.count)")
                // self.matches = self.viewModel.matches
                self.matchesTB.reloadData()
            }
        }
    }
   
    func sectionDataByDates(matches:[Match]) -> [String: [Match]]{
//        let today = getDateOfToday()
//        var matchesOfToday:[Match] = []
//        var remainMatches:[Match] = []
//
//        //Checke if there matches today
//        for match in matches {
//            if extractDateFromISOString(match.lastUpdated) == today {
//                matchesOfToday.append(match)
//            }
//            else {
//                remainMatches.append(match)
//            }
//        }
//        
//        //handle if there matched today or not
//        if matchesOfToday.count != 0 {
//            dates.insert(today, at: 0)
//            sectionedMatches.insert(matchesOfToday, at: 0)
//            sortMatches(remainMatches: remainMatches)
//        }else{
//            sortMatches(remainMatches: remainMatches)
//        }
        var sections: [String: [Match]] = [:]

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"

        for match in matches {
            if let date = dateFormatter.date(from: match.lastUpdated) {
                let sectionKey = dateFormatter.string(from: date)
                if sections[sectionKey] == nil {
                    sections[sectionKey] = [match]
                } else {
                    sections[sectionKey]?.append(match)
                }
            }
        }
     
        return sections

      
    }
    
    
    
    func getDateOfToday() -> String{
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let today = dateFormatter.string(from: currentDate)
        return today
    }
    
    func extractDateFromISOString(_ dateString: String) -> String? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        if let date = dateString.components(separatedBy: "T").first {
            if  let dated = formatter.date(from: date){
                return formatter.string(from: dated)
            }
        }
        return nil
    }
   
}

extension MatchesVC:UITableViewDelegate,UITableViewDataSource {
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return sectionedMatches.count
//    }
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return sectionedMatches.keys.first
//    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return matches.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MatchTVCell", for: indexPath) as? MatchTVCell else{return UITableViewCell()}
        cell.match = matches[indexPath.row]
        cell.delegate = self
        cell.matchName.text = (matches[indexPath.row].awayTeam.name) + " - " + (matches[indexPath.row].homeTeam.name ?? "" )
      
        if matches[indexPath.row].status == "FINISHED"{
            if let away = matches[indexPath.row].score.fullTime.awayTeam , let home = matches[indexPath.row].score.fullTime.homeTeam {
                cell.status.text = "\(away)" + " - " +  "\(home)"
            }
        }else{
            cell.status.text = matches[indexPath.row].season.startDate
        }
        if matches[indexPath.row].isFav ?? false {
            cell.favBtn.tintColor = .red
        }else{
            cell.favBtn.tintColor = .blue
        }
        return cell
    }
}
extension MatchesVC:FavouriteProtocol {
    func setFavourite(match: Match) {
        let favourites = coreData.fetchFromCoreData()
        for idx in favourites {
            let comparedId = (idx.value(forKey: "id") as! Int)
            if match.id == comparedId{
                coreData.deleteFromCoreData(leagueKey: comparedId)
            }else{
                coreData.saveToCoreData(league: match)
            }
        }
    }
}
