//
//  ContentView.swift
//  iOS_AIClient_Sample
//
//  Created by miokato on 2023/12/22.
//

import SwiftUI

/// ランダムな値を生成し、ダミーの脳波データを作成する
func getRandomEEGData(count: Int) -> EEGData {
    let left = (1...count).map { _ in Float.random(in: -100...100) }
    let right = (1...count).map { _ in Float.random(in: -100...100) }
    return .init(leftSamples: left, rightSamples: right)
}

struct ContentView: View {
    
    @StateObject var modelStore = ModelStore()
    
    /// モデルID : モデルIDは学習によりモデルを作成することで取得できます
    let modelId: Int = 612
    
    /// 学習 (モデル作成)
    private func train() {
        // 600Hz x 80秒 = 48000のダミーデータ
        let base = getRandomEEGData(count: 48000)
        let target = getRandomEEGData(count: 48000)
        let data = EEGTrainingData(base: base,
                                   target: target)
        modelStore.train(userId: Constants.userId, 
                         data: data)
    }
    
    /// 推論 (モデルを利用して推論)
    private func inference() {
        // 600Hz x 4秒 = 2400のダミーデータ
        let data = getRandomEEGData(count: 2400)
        
        modelStore.inference(modelId: modelId,
                             userId: Constants.userId,
                             data: data)
    }
    
    var body: some View {
        HStack {
            Button("学習") {
                train()
            }
            .buttonStyle(.borderedProminent)
            .padding()
            
            Button("推論") {
                inference()
            }
            .buttonStyle(.borderedProminent)
            .padding()
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
