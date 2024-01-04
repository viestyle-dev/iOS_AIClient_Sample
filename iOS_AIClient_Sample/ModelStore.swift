//
//  ModelStore.swift
//  iOS_AIClient_Sample
//
//  Created by miokato on 2023/12/22.
//

import SwiftUI

final class ModelStore: ObservableObject {
    @Published var inferenceResponse: InferenceResponse?
    @Published var trainingResponse: TrainingResponse?
    
    func train(userId: String, data: EEGTrainingData) {
        Task {
            do {
                let body = TrainingRequest(
                    userId: userId,
                    mode: 0,
                    modelName: "iOS_AIClient_Sample",
                    rawDataCollectionId: 1,
                    data: data
                )
                trainingResponse = try await API.shared.training(body)
            } catch {
                log("error : \(error)")
            }
        }
    }
    
    func inference(modelId: Int, userId: String, data: EEGData) {
        Task {
            do {
                let body = InferenceRequest(
                    userId: userId,
                    mode: 0,
                    baseLine: 0.5,
                    data: data
                )
                inferenceResponse = try await API.shared.inference(modelId: modelId, body: body)
            } catch {
                log("error : \(error)")
            }
        }
    }
}
