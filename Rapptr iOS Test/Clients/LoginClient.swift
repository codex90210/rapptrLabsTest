//
//  LoginClient.swift
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
 * 1) Make a request here to login. -- C
 *
 * 2) Using the following endpoint, make a request to login -- C
 *    URL: http://dev.rapptrlabs.com/Tests/scripts/login.php
 *
 * 3) Don't forget, the endpoint takes two parameters 'email' and 'password' -- C
 *
 * 4) email - info@rapptrlabs.com
 *   password - Test123
 */

//MARK: - Protocol Setup
protocol logInAPIManagerProtocol {
    
    func loginData(email: String, password: String, completion: @escaping (Result<String, Error>) -> Void)
    
    func testConnection(completion: @escaping(Result<String, Error>) -> Void)
}

//MARK: - Network Error with String and Error Associated Types

enum NetworkError: String, Error {
    
    case invalidURL = "Invalid URL"
    case invalidLogIn = "Invalid log in credentials"
    case HTTPURLError = "HTTP Response Not Ok"
    case deviceNetworkError = "Check Network Connection"
    case emptyData = "Empty Data"
}

//MARK: - Check Wifi Connection
struct checkDeviceWifi {
    
    func testConnection(completion: @escaping(Result<String, Error>) -> Void) {
        
        let monitor = NWPathMonitor()
        
        monitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                completion(.success("Internet Good"))
            } else {
                completion(.failure(NetworkError.deviceNetworkError))
            }
        }
        let queue = DispatchQueue(label: "Network Monitor")
        monitor.start(queue: queue)
        monitor.cancel()
    }
}

//MARK: - User Log In Check
struct checkLogin {
        
    func loginData(email: String, password: String, completion: @escaping (Result<String, Error>) -> Void) {

        let urlRequest = NSMutableURLRequest(url:  NSURL(string: "http://dev.rapptrlabs.com/Tests/scripts/login.php")! as URL)
        
        // Post Method for sending Email & Password
        urlRequest.httpMethod = "POST"
    
        let postURL = "email=\(email)&password=\(password)"

        urlRequest.httpBody = postURL.data(using: String.Encoding.utf8)!

        // set task and check for errors down the line
        
        let task = URLSession.shared.dataTask(with: urlRequest as URLRequest) { data, response, error in

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

            let results = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
            print("result: \(String(describing: results))")
            
            // process JSON serialization to obtain data
            guard let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? NSDictionary else {

                completion(.failure(NetworkError.emptyData))
                return
            }
            
            // pass result to completion handler
            let result = json["message"] as? String
            completion(.success(result! as String))
        }

        task.resume()
    }
}
