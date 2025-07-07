//
//  TriviaQuestionService.swift
//  Trivia
//
//  Created by Sehr Abrar on 7/6/25.
//

import Foundation

class TriviaQuestionService {
    
    func fetchQuestions(completion: @escaping ([TriviaQuestion]?) -> Void) {
        // You can adjust amount, type, category, difficulty here
        let urlString = "https://opentdb.com/api.php?amount=10"
        guard let url = URL(string: urlString) else {
            print("❌ Invalid URL")
            completion(nil)
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("❌ Network error:", error)
                completion(nil)
                return
            }
            
            guard let data = data else {
                print("❌ No data returned")
                completion(nil)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let triviaResponse = try decoder.decode(TriviaResponse.self, from: data)
                completion(triviaResponse.results)
            } catch {
                print("❌ JSON decoding error:", error)
                completion(nil)
            }
        }
        
        task.resume()
    }
}

