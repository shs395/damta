//
//  WatchViewModel.swift
//  watch WatchKit Extension
//
//  Created by 신현석 on 2022/03/06.
//

import Foundation
import WatchConnectivity

class WatchViewModel: NSObject, ObservableObject {
    var session: WCSession
    @Published var isStopSmoking = false
    @Published var todaySmokingCount = 0;
    @Published var stopSmokingDays = 0;
    
    // Add more cases if you have more receive method
    enum WatchReceiveMethod: String {
        case sendIsStopSmokingToNative
        case sendTodaySmokingCountToNative
        case sendStopSmokingDaysToNative
        // case sendUpdateToNative
    }
    
    // Add more cases if you have more sending method
    enum WatchSendMethod: String {
        case addSmokingRecordToFlutter
        case requestUpdateToFlutter
    }
    
    init(session: WCSession = .default) {
        self.session = session
        super.init()
        self.session.delegate = self
        session.activate()
    }
    
    func sendDataMessage(for method: WatchSendMethod, data: [String: Any] = [:]) {
        sendMessage(for: method.rawValue, data: data)
    }
    
}

extension WatchViewModel: WCSessionDelegate {
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
    }
    
    // Receive message From AppDelegate.swift that send from iOS devices
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        DispatchQueue.main.async {
            guard let method = message["method"] as? String, let enumMethod = WatchReceiveMethod(rawValue: method) else {
                return
            }
            
            switch enumMethod {
            case .sendIsStopSmokingToNative:
                self.isStopSmoking = (message["data"] as? Bool) ?? false

            case .sendTodaySmokingCountToNative:
                self.todaySmokingCount = (message["data"] as? Int) ?? 0

            case .sendStopSmokingDaysToNative:
                self.stopSmokingDays = (message["data"] as? Int) ?? 0

            // case .sendUpdateToNative:
            //     self.isStopSmoking = (message["isStopSmoking"] as? Bool) ?? false
            //     self.todaySmokingCount = (message["todaySmokingCount"] as? Int) ?? 0
            //     self.stopSmokingDays = (message["stopSmokingDays"] as? Int) ?? 0

            }

            
        }
    }
    
    func sendMessage(for method: String, data: [String: Any] = [:]) {
        guard session.isReachable else {
            return
        }
        let messageData: [String: Any] = ["method": method, "data": data]
        session.sendMessage(messageData, replyHandler: nil, errorHandler: nil)
    }
    
}


