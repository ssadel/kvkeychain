import Foundation
import Security

/// Encapsulate Keychain functionality in a class similar to UserDefaults
public final class KVKeychain {
    /// Returns the standard keychain object.
    static let standard: KVKeychain = .init()
    
    internal init() {
        // no op
    }
    
    /// Sets the value of the specified default key.
    public func set<T: Codable>(_ value: T?, forKey: String) throws {
        if value == nil {
            try self.delete(forKey: forKey)
            return
        }
        
        let data: Data
        do {
            data = try JSONEncoder().encode(value)
        } catch {
            throw Self.KVKeychainError.failedToEncodeValue(error)
        }
        
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: forKey,
            kSecValueData as String: data
        ]
        let status = SecItemAdd(query as CFDictionary, nil)
        if status == errSecDuplicateItem {
            print("🔑 KVKeychain: Value exists, attempting to update...")
            try self.update(data, forKey: forKey)
            return
        }
        guard status == errSecSuccess else {
            throw Self.KVKeychainError.unknown(status)
        }
    }
    
    /// Gets the value for the given key. Returns nil if no value is found for the key
    public func getValue<T: Decodable>(forKey: String) throws -> T? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: forKey,
            kSecMatchLimit as String: kSecMatchLimitOne,
            kSecReturnAttributes as String: true,
            kSecReturnData as String: true,
        ]
        var item: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        
        guard status == noErr else {
            return nil
        }
        guard let existingItem = item as? [String: Any],
              let data = existingItem[kSecValueData as String] as? Data else {
            return nil
        }
        
        do {
            let value = try JSONDecoder().decode(T.self, from: data)
            return value
        } catch {
            throw Self.KVKeychainError.failedToDecodeValue(error)
        }
    }
    
    public func update(_ value: Data, forKey: String) throws {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: forKey
        ]
        let attributes: [String: Any] = [kSecValueData as String: value]
        let status = SecItemUpdate(query as CFDictionary, attributes as CFDictionary)
        guard status == noErr else {
            throw Self.KVKeychainError.failedToUpdateValue(status)
        }
    }
    
    internal func delete(forKey: String) throws {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: forKey
        ]
        let status = SecItemDelete(query as CFDictionary)
        guard status == noErr else {
            throw Self.KVKeychainError.failedToDeleteValue(status)
        }
    }
}
