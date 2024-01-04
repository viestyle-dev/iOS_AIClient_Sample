//
//  Container.swift
//  iOS_AIClient_Sample
//
//  Created by miokato on 2023/12/22.
//

import Foundation

struct Container<T: Codable>: Codable {
    let data: T
}
