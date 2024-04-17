//
//  UserDefaults.swift
//  Leagues
//
//  Created by Asmaa_Abdelfattah on 28/01/1403 AP.
//

import Foundation
enum UserDefaultsKey: String{
        case ApiKey
        
    }
extension UserDefaults{
 
    func setKey(value: String){
        setValue(value, forKey: UserDefaultsKey.ApiKey.rawValue)
    }
    func getKey() -> String{
        return string(forKey: UserDefaultsKey.ApiKey.rawValue) ?? "en"
    }
}
