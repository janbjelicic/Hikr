//
//  Logger.swift
//  HikrNetworking
//
//  Created by Jan Bjelicic on 05/02/2021.
//

import Foundation
import OSLog

public enum Logger {
    case ui
    case business
    case network
    case storage
    
    public func log(_ message: String,
                    osLogType: OSLogType,
                    file: String = #file,
                    line: Int = #line,
                    function: String = #function) {
        let printMessage = "[\(file):\(line)] \(function) - \(message)"
        os_log("%{public}@", log: self.log, type: osLogType, printMessage)
    }
    
    private var log: OSLog {
        switch self {
        case .ui:
            return Logger.uiLog
        case .business:
            return Logger.businessLog
        case .network:
            return Logger.networkLog
        case .storage:
            return Logger.storageLog
        }
    }
    
    private static let uiLog = OSLog(subsystem: Bundle.main.bundleIdentifier!, category: "UI")
    private static let businessLog = OSLog(subsystem: Bundle.main.bundleIdentifier!, category: "Business")
    private static let networkLog = OSLog(subsystem: Bundle.main.bundleIdentifier!, category: "Network")
    private static let storageLog = OSLog(subsystem: Bundle.main.bundleIdentifier!, category: "Storage")
    
}
