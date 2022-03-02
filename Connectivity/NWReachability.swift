//
//  NWReachability.swift
//  NWReachability
//
//  Created by owen on 2022/3/1.
//

import Foundation
import Network
import Combine

extension Notification.Name {
    fileprivate static let connectivityStatus = Notification.Name(rawValue: "connectivityStatusChanged")
}

extension NWInterface.InterfaceType: CaseIterable {
    public static var allCases: [NWInterface.InterfaceType] = [
        .other,
        .wifi,
        .cellular,
        .loopback,
        .wiredEthernet
    ]
}

final public class NWReachability {
    public enum NetworkConnectivityStatus {
        case unknown
        case notReachable
        case reachable(ConnectionType)
        
        public enum ConnectionType {
            case ethernetOrWiFi
            case cellular
        }
    }

    // MARK: - Public Properties
    public static let `default` = NWReachability()
    
    public var status: NetworkConnectivityStatus {
        switch isConnected {
        case true where currentConnectionType == .cellular:
            return .reachable(.cellular)
        case true:
            return .reachable(.ethernetOrWiFi)
        case false:
            return .notReachable
        }
    }
    public private(set) var isConnected = false
    public private(set) var isExpensive = false
    
    // MARK: - Private Properties
    private let queue = DispatchQueue(label: "Network.Connectivity.Monitor")
    private let monitor: NWPathMonitor
    private var currentConnectionType: NWInterface.InterfaceType = .other
    private var nwStatus: NWPath.Status = .unsatisfied


    // MARK: - Public func
    public init() {
        monitor = NWPathMonitor()
    }

    public func startMonitoring() {
        monitor.pathUpdateHandler = { [weak self] path in
            self?.isConnected = path.status != .unsatisfied
            self?.isExpensive = path.isExpensive
            self?.currentConnectionType = NWInterface.InterfaceType.allCases.filter { path.usesInterfaceType($0) }.first ?? .other
            self?.nwStatus = path.status
            NotificationCenter.default.post(name: .connectivityStatus, object: self)
        }
        monitor.start(queue: queue)
    }

    public func stopMonitoring() {
        monitor.cancel()
    }
    
    
    public func addObserver(queue: OperationQueue = .main, onUpdatePerforming subscriber: @escaping (NWReachability) -> Void) -> NSObjectProtocol {
        return NotificationCenter.default.addObserver(forName: .connectivityStatus, object: self, queue: queue) { [weak self] notification in
            guard let `self` = self else { return }
            subscriber(self)
        }
    }
    
    // MARK: - Public func
    public lazy var publisher: AnyPublisher<NWReachability, Never> = {
        return NetworkStatusPublisher(self).eraseToAnyPublisher()
    }()
}

