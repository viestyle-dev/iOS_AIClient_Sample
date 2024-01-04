//
//  Log.swift
//  iOS_AIClient_Sample
//
//  Created by miokato on 2023/12/22.
//

import Foundation

enum LogType: String {
    case error = "ERROR"
    case warning = "WARN"
    case info = "INFO"
    case debug = "DEBUG"
}

func log(_ message: String, with logType: LogType = .info) {
    #if DEBUG
        print("[\(logType.rawValue)] \(message)")
    #endif
}
