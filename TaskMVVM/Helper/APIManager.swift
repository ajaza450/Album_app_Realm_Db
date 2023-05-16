//
//  APIManager.swift
//  TaskMVVM
//
//  Created by EZAZ AHAMD on 28/01/23.
//

import Foundation

typealias Handler<T> = (Result<T, DataError>) -> Void

enum DataError: Error {
    case invalidResponse
    case invalidURL
    case invalidData
    case network(Error?)
}

final class APIManager{
    
    static let shared = APIManager()
    private init(){
        
    }
    
    
    func request<T: Codable>(strUrl: String, modelType : T.Type, completion: @escaping Handler<T>){
        
        guard let url  = URL(string: strUrl)else {
            completion(.failure(.invalidURL))
            return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
          
            guard let response = response as? HTTPURLResponse,
            200 ... 299 ~= response.statusCode else {
                completion(.failure(.invalidResponse))
              return
            }

            do{
                let json =  try JSONDecoder().decode(modelType.self, from: data)
                completion(.success(json))
            }catch {
                completion(.failure(.network(error)))
            }
            

        }.resume()
        
    }
    
}
