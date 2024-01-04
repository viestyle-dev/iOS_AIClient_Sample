//
//  API.swift
//  iOS_AIClient_Sample
//
//  Created by miokato on 2023/12/22.
//

import Foundation

enum ClientError: Error {
    case responseError(Int)
    case apiError(String)
}

final class API {
    static var shared = API()
}

extension API {
    func request<T: Codable>(_ request: URLRequest) async throws -> T {
        let (data, res) = try await URLSession.shared.data(for: request)
        if let httpResponse = res as? HTTPURLResponse {
            let statusCode: Int = httpResponse.statusCode
            switch statusCode {
            case 200..<300:
                log("👍 API Success StatusCode: \(statusCode)")
            case 400..<500:
                log("Error status: \(statusCode)", with: .warning)
                throw ClientError.responseError(400)
            case 500..<600:
                log("Error status: \(statusCode)", with: .warning)
                throw ClientError.responseError(500)
            default:
                break
            }
        }
        let container: Container<T> = try JSONDecoder().decode(Container.self, from: data)
        log("☁️ Response : \(container.data)")
        return container.data
    }
}

extension API {
    enum Path {
        static let training = "/api/v3/train_by_mode"
        static let inference = "/api/v3/model/%@/inference"
    }
}

extension API {
    enum HTTPMethod: String {
        case get = "GET"
        case post = "POST"
    }
    
    struct BasicAuth {
        let username: String
        let password: String
        
        var value: String? {
            guard let credentialData = "\(username):\(password)".data(using: .utf8) else {
                return nil
            }
            let credential = credentialData.base64EncodedString(options: [])
            return "Basic \(credential)"
        }
    }
}

extension API {
    func training(_ body: TrainingRequest) async throws -> TrainingResponse {
        guard let url = URL(string: Constants.host + API.Path.training) else {
            throw ClientError.apiError("API Error")
        }
        
        let basicAuth = API.BasicAuth(
            username: Constants.basicUser,
            password: Constants.basicPass
        ).value
        
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.post.rawValue
        request.httpBody = try JSONEncoder().encode(body)
        request.setValue(basicAuth, forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        return try await API.shared.request(request)
    }
}

extension API {
    func inference(modelId: Int, body: InferenceRequest) async throws -> InferenceResponse {
        let path = String(format: API.Path.inference, "\(modelId)")
        guard let url = URL(string: Constants.host + path) else {
            throw ClientError.apiError("API Error")
        }
        
        let basicAuth = API.BasicAuth(
            username: Constants.basicUser,
            password: Constants.basicPass
        ).value
        
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.post.rawValue
        request.httpBody = try JSONEncoder().encode(body)
        request.setValue(basicAuth, forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        return try await API.shared.request(request)
    }
}
