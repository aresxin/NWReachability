//
//  NWReachability+Combine.swift
//  NWReachability
//
//  Created by owen on 2022/3/1.
//

import Foundation
import Combine

// MARK: - NWPathMonitor Publisher
internal extension NWReachability {
    class NetworkStatusSubscription<S: Subscriber>: Subscription where S.Input == NWReachability {
        
        private var subscriber: S?
        private var connectivity: NWReachability?
        private var token: Any?
        
        init(_ subscriber: S, _ connectivity: NWReachability) {
            self.subscriber = subscriber
            self.connectivity = connectivity
        }
        
        func request(_ demand: Subscribers.Demand) {
            guard let connectivity = connectivity else { return }
            token = connectivity.addObserver(queue: .main) { [weak self] connectivity in
                _ = self?.subscriber?.receive(connectivity)
            }
        }
        
        func cancel() {
            NotificationCenter.default.removeObserver(token as Any)
            subscriber = nil
            connectivity = nil
        }
        
        deinit {}
    }
    
    
    struct NetworkStatusPublisher: Publisher {
        typealias Output = NWReachability
        typealias Failure = Never
        
        private let connectivity: NWReachability
        init(_ connectivity: NWReachability) {
            self.connectivity = connectivity
        }
        
        func receive<S>(subscriber: S) where S : Subscriber, Never == S.Failure, NWReachability == S.Input {
            let subscription = NetworkStatusSubscription(subscriber, connectivity)
            subscriber.receive(subscription: subscription)
        }
    }
}
