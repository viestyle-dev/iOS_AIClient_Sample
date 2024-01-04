//
//  Inference.swift
//  iOS_AIClient_Sample
//
//  Created by miokato on 2023/12/22.
//

import Foundation

struct InferenceRequest: Codable {
    let userId: String
    let mode: Int
    let baseLine: Float
    let data: EEGData
    
    enum CodingKeys: String, CodingKey {
        case userId = "user_id"
        case mode
        case baseLine = "baseline"
        case data
    }
}

struct InferenceResponse: Codable {
    var predictions: [Float]
    var meanPrediction: Float
    var sessionScore: Float
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        predictions = try container.decode([Float].self, forKey: .predictions)
        meanPrediction = try container.decode(Float.self, forKey: .meanPrediction)
        sessionScore = try container.decode(Float.self, forKey: .sessionScore)
    }
    
    enum CodingKeys: String, CodingKey {
        case predictions
        case meanPrediction = "mean_prediction"
        case sessionScore = "session_score"
    }
}
