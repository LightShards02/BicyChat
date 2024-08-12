//
//  GPTManager.swift
//  FinalProject
//
//  Created by Kevin on 5/1/24.
//

import Foundation

let key = "KEY HERE"
let prompt = "what is openai?"

struct GPTResponseData {
    let good: Bool
    let error: String?
    let response: String?
    
    init(response: String) {
        self.good = true
        self.error = nil
        self.response = response
    }
    
    init(error: String) {
        self.good = false
        self.error = error
        self.response = nil
    }
}


func extractResponseContent(from jsonData: Data, good getMessage: Bool) -> String? {
    if (getMessage) {
        do {
            if let jsonObject = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any],
               let choices = jsonObject["choices"] as? [[String: Any]] {
                for choice in choices {
                    if let message = choice["message"] as? [String: Any], let content = message["content"] as? String {
                        print("content: \(content)")
                        return content
                    }
                }
            }
        } catch {
            print("Failed to decode JSON: \(error)")
            return nil
        }
    } else {
        do {
            if let jsonObject = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any],
               let error = jsonObject["error"] as? [String: Any],
               let message = error["message"] as? String {
                print("error: \(message)")
                return message
            }
        } catch {
            print("Failed to decode JSON: \(error)")
            return nil
        }
    }
    return nil
}

func fetchResponse(forChat isChatModel: Bool, message: String) async -> GPTResponseData {
    guard let url = URL(string: "https://api.openai.com/v1/chat/completions") else {
        return GPTResponseData(error: "Incorrect URL")
    }
    
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.addValue("Bearer \(key)", forHTTPHeaderField: "Authorization")
    
    let prompts = isChatModel ? chatPrompts : priceValuatorPrompts
    let maxToken = isChatModel ? 100 : 30
    let temperature = isChatModel ? 0.3 : 0.0
    
    
    let jsonText = isChatModel ? """
        {
            "model": "gpt-4",
            "max_tokens": \(maxToken),
            "temperature": \(temperature),
            "messages": [
              {
                "role": "system",
                "content": "\(prompts["system"]!)"
              },
              {
                "role": "user",
                "content": "\(message)"
              }
            ]
        }
        """
        :"""
        {
            "model": "gpt-4",
            "max_tokens": \(maxToken),
            "temperature": \(temperature),
            "messages": [
              {
                "role": "system",
                "content": "\(prompts["system"]!)"
              },
              {
                "role": "user",
                "content": "\(prompts["user"]!)"
              },
              {
                "role": "assistant",
                "content": "\(prompts["assistant"]!)"
              },
              {
                "role": "user",
                "content": "\(message)"
              }
            ]
        }
        """
    print(jsonText)
    let jsonData = jsonText.data(using: .utf8)!
    
    request.httpBody = jsonData
    
    do {
        let (data, response) = try await URLSession.shared.upload(for: request, from: jsonData)
        
        var statusCode: Int = 418
        if let httpResponse = response as? HTTPURLResponse {
            statusCode = httpResponse.statusCode
            print("Status Code: \(statusCode)")
        }
        
        let responseString = String(decoding: data, as: UTF8.self)
        print("Response Data: \(responseString)")
        
        if (statusCode == 200) {
            if let content = extractResponseContent(from: data, good: true) {
                return GPTResponseData(response: content)
            } else {
                return GPTResponseData(error: "JSON Decode Error")
            }
        } else {
            if let content = extractResponseContent(from: data, good: false) {
                return GPTResponseData(error: "\(statusCode): \(content)")
            } else {
                return GPTResponseData(error: "JSON Decode Error")
            }
        }
    } catch {
        print("Request failed with error: \(error)")
        return GPTResponseData(error: "Request Failed")
    }
}

