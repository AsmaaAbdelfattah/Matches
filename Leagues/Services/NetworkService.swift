//
//  NetworkService.swift
//  Leagues
//
//  Created by Asmaa_Abdelfattah on 28/01/1403 AP.
//

import Foundation
import Alamofire
class NetworkServiceManager{
    private static var networkService : NetworkServiceManager?
 
    public static func getInstance()->NetworkServiceManager{
        if networkService == nil {
            networkService = NetworkServiceManager()
        }
        return networkService!
    }
    
    
    func fetchAuthData<T>(url: String, compiletionHandler: @escaping (Result<T, Error>) -> Void) where T : Decodable {
        
        let Auth_header: HTTPHeaders  = [ HTTPHeader(name: "X-Auth-Token", value: "\(UserDefaults.standard.getKey())")]
        print("auth header \(Auth_header)")
        let request = AF.request(url , method: .get ,headers: Auth_header)
        request.responseDecodable(of:T.self) { (response) in
           switch response.result {
           case .success(let items):
               compiletionHandler(.success(items))
           case .failure(let error):
               compiletionHandler(.failure(error))
            }        }
    }
    
}
