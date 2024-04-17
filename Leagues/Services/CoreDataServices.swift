//
//  CoreDataServices.swift
//  Leagues
//
//  Created by Asmaa_Abdelfattah on 29/01/1403 AP.
//

import Foundation
import CoreData
import UIKit
protocol CoreDataHandler{
    func saveToCoreData(league: Match )
    func isFavourite(matchId : Int) -> Bool
    func deleteFromCoreData(leagueKey : Int)
    func fetchFromCoreData() -> [NSManagedObject]
}
class CoreDataManager: CoreDataHandler{
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let managedContext : NSManagedObjectContext!
    let entity : NSEntityDescription!
    
    private static var sharedInstance : CoreDataManager?
    
    public static func getInstance()->CoreDataManager{
        
        if sharedInstance == nil {
            sharedInstance = CoreDataManager()
        }
        
        return sharedInstance!
            
    }
    private init(){
        managedContext = appDelegate.persistentContainer.viewContext
        entity = NSEntityDescription.entity(forEntityName: "Favouirtes", in: self.managedContext)
    }
    
    func saveToCoreData(league: Match ) {
        
        let leagues = NSManagedObject(entity: entity!, insertInto: managedContext)
        
        leagues.setValue(league.score.fullTime.awayTeam, forKey: "awayScore")
        leagues.setValue(league.awayTeam, forKey: "awayTeam")
        leagues.setValue(league.lastUpdated, forKey: "date")
        leagues.setValue(league.score.fullTime.homeTeam, forKey: "homeScore")
        leagues.setValue(league.homeTeam, forKey: "homeTeam")
        leagues.setValue(true, forKey: "isFavourite")
        leagues.setValue(league.id, forKey: "id")
        leagues.setValue(league.status, forKey: "status")
        do{
            try managedContext.save()
        }catch let error {
            print (error)
        }
    }
    
    func deleteFromCoreData(leagueKey : Int) {
        let fetchLeagues = fetchFromCoreData()
        
        for item in fetchLeagues {
            if item.value(forKey: "id") as! Int == leagueKey {
                managedContext.delete(item)
            }
        }
        do {
            try managedContext.save()
        } catch let error {
            print (error)
        }
    }
    
    func fetchFromCoreData() -> [NSManagedObject] {
        
        var leagueFromCoreData : [NSManagedObject]!
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Favouirtes")
        
        do{
             leagueFromCoreData = try self.managedContext.fetch(fetchRequest)
           
        } catch let error {
            print (error)
        }
        
        return leagueFromCoreData
    }
    
    func isFavourite(matchId : Int) -> Bool {
        
        let fetchLeagues = fetchFromCoreData()
        
        for item in fetchLeagues {
            if item.value(forKey: "id") as! Int == matchId {
               return true
            }
        }
        return false
    }
}
