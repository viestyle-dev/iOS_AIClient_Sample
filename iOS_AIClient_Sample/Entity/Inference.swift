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
    
    enum CodingKeys: String, CodingKey {
        case predictions
        case meanPrediction = "mean_prediction"
        case sessionScore = "session_score"
    }
}
