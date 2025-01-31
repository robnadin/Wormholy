//
//  WormholyTests.swift
//  Wormholy
//
//  Created by Paolo Musolino on 9/01/2018.
//  Copyright © 2018 Wormholy. All rights reserved.
//

import Foundation
import Testing

@testable import WormholySwift

@Suite(.serialized)
final class WormholyTests {
    
    deinit {
        Wormholy.ignoredHosts = []
        Wormholy.ignoredSchemes = []
    }
    
    @Test
    func ignoredSchemes() {
        Wormholy.ignoredSchemes = ["foo", "bar"]
        #expect(CustomHTTPProtocol.ignoredSchemes == ["foo", "bar"])
    }
    
    @Test
    func ignoredHosts() {
        Wormholy.ignoredHosts = ["foo.bar", "baz.qux"]
        #expect(CustomHTTPProtocol.ignoredHosts == ["foo.bar", "baz.qux"])
    }
}
