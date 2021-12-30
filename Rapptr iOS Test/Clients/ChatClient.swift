//
//  ChatClient.swift
//  Rapptr iOS Test
//
//  Created by Ethan Humphrey on 8/11/21.
//

import Foundation
import Network

/**
 * =========================================================================================
 * INSTRUCTIONS
 * =========================================================================================
 * 1) Make a request to fetch chat data used in this app. --C
 *
 * 2) Using the following endpoint, make a request to fetch data --C
 *    URL: http://dev.rapptrlabs.com/Tests/scripts/chat_log.php
 *
 */
//

//MARK: - API Protocol
protocol chatAPIManagerProtocol {
    
    func fetchChatData(completion: @escaping (Result<[Messages], Error>) -> Void)
}

//MARK: - Struct to Fetch API Chat Data
struct ChatClient {
    
    func fetchChatData(completion: @escaping (Result<[Messages], Error>) -> Void) {
        
        // check URL String format
        guard let url = URL(string: "http://dev.rapptrlabs.com/Tests/scripts/chat_log.php") else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        // Perform Tasks and check for Errors down the line
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let _ = error {
                completion(.failure(NetworkError.invalidURL))
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200
            else {
                completion(.failure(NetworkError.HTTPURLError))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.emptyData))
                
                return
            }
            
            // Decoding JSON Data for Custom Type from Message Model
            
            guard let list = try? JSONDecoder().decode(messageData.self, from: data) else {
                completion(.failure(NetworkError.emptyData))
                return
            }
            
            completion(.success(list.data))
        }
        
        task.resume()
        
    }
}

