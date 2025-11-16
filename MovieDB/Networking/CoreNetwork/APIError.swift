//
//  APIError.swift
//  MovieDB
//
//  Created by Hassan Jaffri on 13/11/2025.
//
import Foundation

enum APIError: LocalizedError {
    case invalidURL
    case requestFailed(Error)
    case serverError(statusCode: Int, message: String?)
    case emptyResponse
    case decodingError(Error)
    case unauthorized
    case unknown
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "The request URL is invalid."
        case .requestFailed(let error):
            return "Network request failed: \(error.localizedDescription)"
        case .serverError(let statusCode, let message):
            return "Server returned an error (\(statusCode)): \(message ?? "Unknown message")"
        case .emptyResponse:
            return "No data received from the server."
        case .decodingError(let error):
            return "Failed to decode server response: \(error.localizedDescription)"
        case .unauthorized:
            return "Your session has expired. Please log in again."
        case .unknown:
            return "An unknown error occurred."
        }
    }
}
