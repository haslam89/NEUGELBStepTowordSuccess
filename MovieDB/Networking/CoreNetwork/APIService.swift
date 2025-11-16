//
//  APIService.swift
//  MovieDB
//
//  Created by Hassan Jaffri on 13/11/2025.
//
//
import Foundation
import os

private let logger = Logger(subsystem: "com.MovieDB", category: "network")

fileprivate struct AnyEncodable: Encodable {
    private let _encode: (Encoder) throws -> Void
    init(_ encodable: any Encodable) {
        self._encode = encodable.encode
    }
    func encode(to encoder: Encoder) throws { try _encode(encoder) }
}

final class APIService {
    static let shared = APIService()
    private init() {}
    
    func request<T: Codable>(
        _ endpoint: Endpoint,
        responseType: T.Type
    ) async throws -> T {
        
        var url = endpoint.baseURL.appendingPathComponent(endpoint.path)
        if let queryItems = endpoint.queryItems {
            var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
            components?.queryItems = queryItems
            guard let finalURL = components?.url else {
                throw APIError.invalidURL
            }
            url = finalURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.allHTTPHeaderFields = endpoint.headers
        
        logger.info("🚀 Request: \(request.httpMethod ?? "") \(url.absoluteString)")
        if let headers = request.allHTTPHeaderFields {
            logger.debug("Headers: \(headers)")
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw APIError.serverError(statusCode: -1, message: "Invalid response format")
            }
        
            switch httpResponse.statusCode {
            case 200..<300:
                break // OK
            case 401:
                throw APIError.unauthorized
            case 404:
                throw APIError.invalidURL
            default:
                let message = String(data: data, encoding: .utf8)
                throw APIError.serverError(statusCode: httpResponse.statusCode, message: message)
            }
            
            guard !data.isEmpty else {
                throw APIError.emptyResponse
            }
            
            if let responseString = String(data: data, encoding: .utf8) {
                logger.debug("🔵 Response: \(responseString)")
            }
            
            do {
                let decoded = try JSONDecoder().decode(T.self, from: data)
                return decoded
            } catch let decodeError {
                throw APIError.decodingError(decodeError)
            }
            
        } catch let apiError as APIError {
            logger.error("❌ API Error: \(apiError.localizedDescription)")
            throw apiError
        } catch {
            logger.error("❌ Unexpected Error: \(error.localizedDescription)")
            throw APIError.requestFailed(error)
        }
    }
}
