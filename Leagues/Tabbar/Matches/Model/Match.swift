//
//  Match.swift
//  Leagues
//
//  Created by Asmaa_Abdelfattah on 28/01/1403 AP.
//

import Foundation
struct Matchs: Decodable {
    var count: Int
     var filters: Filter
    var competition: Compition
    var matches: [Match]
    
}
struct Match:Decodable {
    var id:Int
    var season: Seasons
    var utcDate: String
    var status: String
    var matchday: Int
    var stage: String
    var group: String?
    var lastUpdated: String
    var odds: OOD
    var score: Score
    var homeTeam: AwayTeam
    var awayTeam: AwayTeam
    var referees: [Refeers]
    var isFav:Bool?
}

struct Filter:Decodable{
//        var dateFrom:String
//         var dateTo: String
//         var permission: String
//         var limit: Int
}
struct Compition:Decodable{
    var id: Int
    var area: AwayTeam
    var name: String
    var code: String
    var plan: String
    var lastUpdated: String
}

struct AwayTeam:Decodable {
    var id: Int
    var name: String
}
struct Score:Decodable {
    var winner: String?
    var duration: String
    var fullTime: TimeScore
    var halfTime: TimeScore
    var extraTime: TimeScore
    var penalties: TimeScore
}
struct TimeScore:Decodable {
    var homeTeam: Int?
    var awayTeam: Int?
}
struct Seasons:Decodable {
    var id: Int
    var startDate: String
    var endDate: String
    var currentMatchday: Int
}
struct OOD:Decodable {
    var msg: String
}
struct Refeers:Decodable {
    var id: Int
    var name: String
    var role: String
    var nationality: String
}
