//
//  KeychainStorage.swift
//  HikrNetworking
//
//  Created by Jan Bjelicic on 05/02/2021.
//

import Foundation
import KeychainAccess

public protocol KeychainStorageProtocol: class {
    func initializeStorage(identifier: String)
    func getFromKeychain(key: String) -> String
    func getFromKeychain(key: String) -> Data?
    func saveInKeychain(key: String, value: String) -> Bool
    func saveInKeychain(key: String, value: Data) -> Bool
    func deleteFromKeychain(key: String) -> Bool
    func clearKeychain()
}

public class KeychainStorage: KeychainStorageProtocol {
    
    private var keychain: Keychain?
    
    public func initializeStorage(identifier: String) {
        keychain = Keychain(service: identifier)
    }
    
    public func getFromKeychain(key: String) -> String {
        guard let keychain = self.keychain else {
            return ""
        }
        do {
            let data = try keychain.getString(key)
            return data ?? ""
        } catch let error {
            Logger.storage.log("\(error)", osLogType: .error)
            return ""
        }
    }
    
    public func getFromKeychain(key: String) -> Data? {
        guard let keychain = self.keychain else {
            return nil
        }
        do {
            let data = try keychain.getData(key)
            return data
        } catch let error {
            Logger.storage.log("\(error)", osLogType: .error)
            return nil
        }
    }
    
    public func saveInKeychain(key: String, value: String) -> Bool {
        guard let keychain = self.keychain else {
            return false
        }
        do {
            try keychain.set(value, key: key)
            return true
        } catch let error {
            Logger.storage.log("\(error)", osLogType: .error)
            return false
        }
    }
    
    public func saveInKeychain(key: String, value: Data) -> Bool {
        guard let keychain = self.keychain else {
            return false
        }
        do {
            try keychain.set(value, key: key)
            return true
        } catch let error {
            Logger.storage.log("\(error)", osLogType: .error)
            return false
        }
    }
    
    public func deleteFromKeychain(key: String) -> Bool {
        guard let keychain = self.keychain else {
            return false
        }
        do {
            try keychain.remove(key)
            return true
        } catch let error {
            Logger.storage.log("\(error)", osLogType: .error)
            return false
        }
    }
    
    public func clearKeychain() {
        guard let keychain = self.keychain else {
            return
        }
        do {
            try keychain.removeAll()
        } catch let error {
            Logger.storage.log("\(error)", osLogType: .error)
        }
    }
    
}
