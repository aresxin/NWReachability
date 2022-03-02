//
//  ViewController.swift
//  NWReachability
//
//  Created by owen on 2022/3/2.
//

import UIKit
import Combine

class ViewController: UIViewController {
    // MARK: - Properties
    @IBOutlet private  weak var textLabel: UILabel!
    @IBOutlet private  weak var combineTextLabel: UILabel!
    
    private var cancellables = Set<AnyCancellable>()
    private var token: Any?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        observeNetworkStatus()
        
        NWReachability.default.startMonitoring()
    }

    deinit {
        NotificationCenter.default.removeObserver(token as Any)
        NWReachability.default.stopMonitoring()
    }
    
    // MARK: - Network Status
    private func observeNetworkStatus() {
        // MARK: - Observation
        token = NWReachability.default.addObserver { [weak self] connectivity in
            self?.textLabel.text = connectivity.isConnected ?
                "Connection is OK" : "Connection lost"
        }
        
        // MARK: - Combine
        NWReachability.default.publisher.sink {  [weak self] connectivity in
            self?.combineTextLabel.text = connectivity.isConnected ?
                "Connection is OK" : "Connection lost"
        }.store(in: &cancellables)
    }

}

extension ViewController {
    // MARK: - Observation Cancel
    @IBAction private func actionCancelObserver() {
        NotificationCenter.default.removeObserver(token as Any)
    }
    
    // MARK: - Combine Cancel
    @IBAction private func actionCancelCombine() {
        cancellables.removeAll()
    }
}

