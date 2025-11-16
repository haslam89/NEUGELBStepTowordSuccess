//
//  HTTPRequest.swift
//  MovieDB
//
//  Created by Hassan Jaffri on 13/11/2025.
//
import Foundation

enum HTTPMethod: String {
    case GET, POST, PUT, DELETE
}
protocol Endpoint {
    var baseURL: URL { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String]? { get }
    var parameters: [String: Any]? { get }
    var queryItems: [URLQueryItem]? { get }
}

