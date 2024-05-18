//
//  KVKeychain+Error.swift
//
//
//  Created by Sidney Sadel on 5/18/24.
//

import Foundation

public extension KVKeychain {
    enum KVKeychainError: Error {
        case failedToEncodeValue(Error)
        case failedToDecodeValue(Error)
        case failedToUpdateValue(OSStatus)
        case failedToDeleteValue(OSStatus)
        case unknown(OSStatus)
    }
}
