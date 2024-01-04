//
//  EEGData.swift
//  iOS_AIClient_Sample
//
//  Created by miokato on 2023/12/22.
//

import Foundation

struct EEGData: Codable {
    let leftSamples: [Float]
    let rightSamples: [Float]
    
    enum CodingKeys: String, CodingKey {
        case leftSamples = "left"
        case rightSamples = "right"
    }
}
