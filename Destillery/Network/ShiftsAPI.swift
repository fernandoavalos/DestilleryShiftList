//
//  ShiftsAPI.swift
//  Destillery
//
//  Created by Fernando Avalos on 10/02/22.
//

import Foundation

class ShiftsAPI {
    static var shared = ShiftsAPI()
    
    // For this demo we can load the data simulating the API call
    func loadShifts(completion: @escaping (Result<APIResult, Error>) -> Void) {
        DispatchQueue.global().asyncAfter(deadline: .now() + 0.75) {
            let json = """
            {
                "shifts": [
                 {
                    "role": "Waiter",
                    "name": "Anna",
                    "start_date": "2018-04-20 9:00:00 -08:00",
                    "end_date": "2018-4-20 12:00:00 -08:00",
                    "color": "red"
                 },
                 {
                    "role": "Prep",
                    "name": "Anton",
                    "start_date": "2018-04-20 9:00:00 -08:00",
                    "end_date": "2018-4-20 12:00:00 -08:00",
                    "color": "blue"
                 },
                 {
                    "role": "Front of House",
                    "name": "Eugene",
                    "start_date": "2018-04-20 12:00:00 -08:00",
                    "end_date": "2018-4-20 22:00:00 -08:00",
                    "color": "red"
                 },
                 {
                    "role": "Cook",
                    "name": "Keyvan",
                    "start_date": "2018-04-21 7:00:00 -08:00",
                    "end_date": "2018-4-21 12:00:00 -08:00",
                    "color": "green"
                 },
                  {
                    "role": "Waiter",
                    "name": "Anna",
                    "start_date": "2018-04-21 9:00:00 -08:00",
                    "end_date": "2018-4-21 14:00:00 -08:00",
                    "color": "red"
                 },
                  {
                    "role": "Prep",
                    "name": "Anton",
                    "start_date": "2018-04-21 7:00:00 -08:00",
                    "end_date": "2018-4-21 12:00:00 -08:00",
                    "color": "blue"
                 },
                 {
                    "role":"Front of House",
                    "name": "Eugene",
                    "start_date": "2018-04-21 12:00:00 -08:00",
                    "end_date": "2018-4-21 22:00:00 -08:00",
                    "color": "red"
                 },
                 {
                    "role":"Cook",
                    "name": "Keyvan",
                    "start_date": "2018-04-22 7:00:00 -08:00",
                    "end_date": "2018-4-22 12:00:00 -08:00",
                    "color": "green"
                 },
                 {
                    "role": "Waiter",
                    "name": "Anna",
                    "start_date": "2018-04-22 9:00:00 -08:00",
                    "end_date": "2018-4-22 14:00:00 -08:00",
                    "color": "red"
                 },
                  {
                    "role":"Prep",
                    "name": "Anton",
                    "start_date": "2018-04-22 7:00:00 -08:00",
                    "end_date": "2018-4-22 12:00:00 -08:00",
                    "color": "blue"
                 },
                 {
                    "role": "Front of House",
                    "name": "Eugene",
                    "start_date": "2018-04-22 12:00:00 -08:00",
                    "end_date": "2018-4-22 22:00:00 -08:00",
                    "color": "red"
                 }
                ]
            }
            """
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss ZZZZZ"
            
            let jsonData = json.data(using: .utf8)!
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .formatted(formatter)
            let apiResult: APIResult = try! decoder.decode(APIResult.self, from: jsonData)
            completion(.success(apiResult))
        }
    }
}
