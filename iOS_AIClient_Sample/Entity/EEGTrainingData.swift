//
//  EEGTrainingData.swift
//  iOS_AIClient_Sample
//
//  Created by miokato on 2023/12/22.
//

import Foundation

struct EEGTrainingData: Codable {
    let base: EEGData
    let target: EEGData
    
    enum CodingKeys: String, CodingKey {
        case base
        case target
    }
}
