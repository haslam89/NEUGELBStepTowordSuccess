//
//  NetworkMonitor.swift
//  MovieDB
//
//  Created by Hassan Jaffri on 16/11/2025.
//
import Network
import Combine

final class NetworkMonitor: ObservableObject {
    
    static let shared = NetworkMonitor()
    
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "NetworkMonitor")
    
    @Published private(set) var isConnected: Bool = true
    
    private init() {
        monitor.pathUpdateHandler = { [weak self] path in
            DispatchQueue.main.async {
                self?.isConnected = path.status == .satisfied
            }
        }
        monitor.start(queue: queue)
    }
    
    // Optional: helper for async checks
    func checkConnection() async -> Bool {
        return isConnected
    }
}
