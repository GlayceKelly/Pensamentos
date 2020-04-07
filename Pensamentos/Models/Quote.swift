//
//  Quote.swift
//  Pensamentos
//
//  Created by Glayce on 06/04/20.
//  Copyright © 2020 Glayce. All rights reserved.
//

import Foundation

struct Quote: Codable {
    let quote: String
    let author: String
    let image: String
    
    var quoteFormatted: String {
        return "“" + quote + "”"
    }
    
    var authorFormatted: String {
        return "- " + author + " -"
    }
}
