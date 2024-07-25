//
//  Network.swift
//  app724
//
//  Created by Dias Atudinov on 25.07.2024.
//

import Foundation

protocol SecondEndpoint {
    
    var theMainURL: String { get }
    var method: String { get }
    var body: [String: Any] { get }
}

class NetworkService {
    
    func sendRequest(endpoint: SecondEndpoint, completion: @escaping (Result<Bool, Error>) -> Void) {
        
        guard let url = URL(string: endpoint.theMainURL) else {
            
            completion(.failure(URLError(.badURL)))
            
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let error = error {
                
                DispatchQueue.main.async { completion(.failure(error)) }
                
                return
            }
            
            guard let data = data else {
                
                DispatchQueue.main.async { completion(.failure(URLError(.cannotParseResponse))) }
                
                return
            }
            
            DispatchQueue.main.async {
                
                do {
                    
                    if let jsonObject = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                        
                        fetchData { server1_0, landing_request, codeTech, error in
                            
                            if let error = error {
                                
                                print("Ошибка: \(error.localizedDescription)")
                                
                            } else {
                                
                                if let codeTech = codeTech {
                                    
                                    if let reloadableValue = jsonObject[codeTech] as? Bool {
                                        
                                        completion(.success(reloadableValue))
                                        
                                    } else if let responseString = String(data: data, encoding: .utf8), self.isBlockValue(responseString) {
                                        
                                        completion(.success(true))
                                        
                                    } else {
                                        
                                        completion(.success(false))
                                    }
                                    
                                } else {
                                    
                                    print("Ключ 'url' не найден в JSON.")
                                }
                            }
                        }
                        
                    } else {
                        
                        completion(.failure(URLError(.cannotParseResponse)))
                    }
                    
                } catch {
                    
                    completion(.failure(error))
                }
            }
            
        }
        .resume()
    }

    func isBlockValue(_ value: String) -> Bool {
        
        return value == "1"
    }
}

func fetchData(completion: @escaping (String?, String?, String?, Error?) -> Void) {
    
    guard let url = URL(string: DataManager().storage_domain) else {
        completion(nil, nil, nil, NSError(domain: "Invalid URL", code: 0, userInfo: nil))
        return
    }
    
    let task = URLSession.shared.dataTask(with: url) { data, response, error in
        if let error = error {
            completion(nil, nil, nil, error)
            return
        }
        
        guard let data = data else {
            completion(nil, nil, nil, NSError(domain: "No data", code: 0, userInfo: nil))
            return
        }
        
        do {
            if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                
                let server1_0 = json["server1_0"] as? String
                let landing_request = json["landing_request"] as? String
                let codeTech = json["codeTech"] as? String
                
                completion(server1_0, landing_request, codeTech, nil)
                
            } else {
                
                completion(nil, nil, nil, NSError(domain: "Invalid JSON format", code: 0, userInfo: nil))
            }
            
        } catch {
            
            completion(nil, nil, nil, error)
        }
    }
    
    task.resume()
}
