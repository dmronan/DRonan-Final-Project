//
//  GetLyricsTests.swift
//  GetLyricsTests
//
//  Created by Dom Ronan on 4/29/17.
//  Copyright © 2017 Dom Ronan. All rights reserved.
//

import XCTest
@testable import GetLyrics

class GetLyricsTests: XCTestCase {
    
    func testInitializationSucceeds() {
        
        let firstSong = Song.init(name: "Zero", artist: "Bieber", lyrics: "penis")
        XCTAssertNotNil(firstSong)
        
        let lastSong = Song.init(name: "Five", artist: "Drake", lyrics: "asshole")
        
    }
    
}
