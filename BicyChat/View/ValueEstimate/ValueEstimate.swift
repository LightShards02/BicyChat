//
//  ValueEstimate.swift
//  FinalProject
//
//  Created by Kevin on 5/2/24.
//

import Foundation

func generatePrompt(selectedOptions info: [String]) -> String {
    var brand = info[0], model = info[1], year = info[2], condition = info[3].lowercased(), scratches = info[4].lowercased()
    let prompt = "What is the estimated price range for a \(brand) \(model) bike, produced in \(year), with \(condition) condition and \(scratches)?"
    return prompt
}
