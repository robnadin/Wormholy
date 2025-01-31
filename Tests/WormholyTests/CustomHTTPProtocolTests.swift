//
//  CustomHTTPProtocolTests.swift
//  Wormholy
//
//  Created by Rob Nadin on 31/01/2025.
//  Copyright © 2018 Wormholy. All rights reserved.
//

import Foundation
import Testing

@testable import WormholySwift

@Suite(.serialized)
final class CustomHTTPProtocolTests {
    
    deinit {
        CustomHTTPProtocol.ignoredHosts = []
        CustomHTTPProtocol.ignoredSchemes = []
    }
    
    @Test
    func registerProtocol() {
        #expect(URLProtocol.registerClass(CustomHTTPProtocol.self))
        URLProtocol.unregisterClass(CustomHTTPProtocol.self)
    }
    
    @Test(arguments: .testSchemes)
    func ignoredSchemes(_ scheme: String) throws {
        let url = try #require(URL(string: "\(scheme)://wormholy.xyz"))
        let request = URLRequest(url: url)
        CustomHTTPProtocol.ignoredSchemes = .testSchemes
        #expect(!CustomHTTPProtocol.canInit(with: request))
    }
    
    @Test(arguments: .testHosts)
    func ignoredHosts(_ host: String) throws {
        let url = try #require(URL(string: "https://\(host)"))
        let request = URLRequest(url: url)
        CustomHTTPProtocol.ignoredHosts = .testHosts
        #expect(!CustomHTTPProtocol.canInit(with: request))
    }
}

private extension Sequence where Self == [String] {
    
    static var testSchemes: Self {
        ["http", "https", "ftp", "file", "ws", "wss"]
    }
    
    static var testHosts: Self {
        ["example.com", "www.google.com", "uk.news.yahoo.com"]
    }
}
