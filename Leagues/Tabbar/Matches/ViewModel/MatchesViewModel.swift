//
//  MatchesViewModel.swift
//  Leagues
//
//  Created by Asmaa_Abdelfattah on 28/01/1403 AP.
//

import Foundation
class MatchesViewModel {
    let networkService = NetworkServiceManager.getInstance()
    var matches:[Match]!{
        didSet{
            bindMatches()
        }
    }
    var bindMatches: (() -> ()) = {}
    
    func getMatches(url:String){
        networkService.fetchAuthData(url: url) { (response:Result<Matchs,Error>) in
            switch response {
            case .success(let data):
                self.matches = data.matches
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
