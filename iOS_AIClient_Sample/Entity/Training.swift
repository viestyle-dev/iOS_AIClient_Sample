//
//  Training.swift
//  iOS_AIClient_Sample
//
//  Created by miokato on 2023/12/22.
//

import Foundation

struct TrainingRequest: Codable {
    let userId: String
    let mode: Int
    let modelName: String
    let rawDataCollectionId: Int
    let data: EEGTrainingData
    
    enum CodingKeys: String, CodingKey {
        case userId = "user_id"
        case mode
        case modelName = "model_name"
        case rawDataCollectionId = "raw_data_collection_id"
        case data
    }
}

struct TrainingResponse: Codable {
    let modeLevel: Double
    let decoderLevel: Double
    let trainingLevel: Int
    let selectedModel: Int
    let rawDataCollectionId: Int
    
    enum CodingKeys: String, CodingKey {
        case modeLevel = "mode_level"
        case decoderLevel = "decoder_level"
        case trainingLevel = "training_level"
        case selectedModel = "selected_model"
        case rawDataCollectionId = "raw_data_collection_id"
    }
}
