//
//  API.swift
//  Leagues
//
//  Created by Asmaa_Abdelfattah on 28/01/1403 AP.
//

import Foundation
enum Networking{
    
    private var baseURL: String { return  "https://api.football-data.org/" }
    
    case matches
}
extension Networking{
    
    var fullPath :String {
        var endPoint: String
        switch self {
        case .matches:
            endPoint = "v2/competitions/2021/matches"
        }
        return baseURL + endPoint
    }
}
