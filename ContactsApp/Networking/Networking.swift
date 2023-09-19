//
//  Networking.swift
//  ContactsApp
//
//  Created by Daniel Fratila on 9/14/23.
//

import Foundation

protocol NetworkingType {
    func fetchData<T: Decodable>(at urlString: String, completion: @escaping (Result<T, Error>) -> Void)
}

final class Networking: NetworkingType {
    
    func fetchData<T: Decodable>(at urlString: String, completion: @escaping (Result<T, Error>) -> Void) {
        guard let url = URL(string: urlString) else{
            return
        }
        
        let task = URLSession.shared.dataTask(with: url){
            data, response, error in
            
            if let data = data {
                do {
                  let contacts = try JSONDecoder().decode(T.self, from: data)
                  completion(.success(contacts))
                } catch let decoderError {
                  completion(.failure(decoderError))
                }
            }
        }
        
        task.resume()
    }
}

public enum NetworkingURLStrings{
    static let contacts = "https://gorest.co.in/public/v2/users"
}
