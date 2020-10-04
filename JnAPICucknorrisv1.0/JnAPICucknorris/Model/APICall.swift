//
//  APICall.swift
//  JnAPICucknorris
//
//  Created by Jonatan on 03/10/2020.
//

import Foundation
import UIKit

class APICall {
    
    // MARK: - Variables And Properties
    //
    static private let urlAPI = "https://api.chucknorris.io/jokes/"

    //
    // MARK: - Class Methods
    //
    class func fetchCategoriesJSON(completion : @escaping (Result<[String], Error>) -> ()){
        let urlCategories = urlAPI + "categories"
        guard let url = URL(string: urlCategories) else {return}
        
        URLSession.shared.dataTask(with: url){(data,resp,err) in
            
            if let err = err{
                completion(.failure(err))
                return
            }
            
            //successful
            do{
                let categories = try JSONDecoder().decode([String].self, from: data!)
                completion(.success(categories))
            }catch let jsonError {
                completion(.failure(jsonError))
            }
        
        }.resume()
        
    }
    
    class func fetchRandomWithCagetorieJSON(typecateg: String?,namecustom: String?,completion : @escaping (Result<CuckNJokes, Error>) -> ()){
        
        let categorie = typecateg
        var urlRandomwithCategorie = ""
        if namecustom != ""{
            urlRandomwithCategorie = urlAPI + "random?name="+namecustom!+"&category=" + categorie!
        }else { urlRandomwithCategorie = urlAPI + "random?category=" + categorie!}
        
        print(urlRandomwithCategorie)
        guard let url = URL(string: urlRandomwithCategorie) else {return}
        
        URLSession.shared.dataTask(with: url){(data,resp,err) in
            
            if let err = err{
                completion(.failure(err))
                return
            }
            
            //successful
            do{
                let jokers = try JSONDecoder().decode(CuckNJokes.self, from: data!)
                completion(.success(jokers))
            }catch let jsonError {
                completion(.failure(jsonError))
            }
   
        }.resume()
        
    }
    
}
