# KVKeychain

[![Swift](https://img.shields.io/badge/Swift-5.10-orange.svg?style=flat)](https://developer.apple.com/swift/)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)

A Swift package for managing key-value pairs securely using the Keychain, similar to UserDefaults.

## Features

- Store, retrieve, and delete key-value pairs securely in the Keychain
- Supports `Codable` types for easy encoding and decoding

## Installation

### Swift Package Manager

To integrate `KVKeychain` into your project using Swift Package Manager, add it to the dependencies in your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/ssadel/KVKeychain.git", from: "1.0.0")
]

