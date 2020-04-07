//
//  QuotesManager.swift
//  Pensamentos
//
//  Created by Glayce on 06/04/20.
//  Copyright © 2020 Glayce. All rights reserved.
//

import Foundation

class QuotesManager {
    let quotes: [Quote]
    
    init() {
        //Obtem o caminho do arquivo
        let fileURL = Bundle.main.url(forResource: "quotes", withExtension: "json")!
        
        //Obtem o conteudo do arquivo
        let jsonData = try! Data(contentsOf: fileURL)
        
        //Decodifica o json para o tipo quotes
        let jsonDecoder = JSONDecoder()
        quotes = try! jsonDecoder.decode([Quote].self, from: jsonData)
    }
    
    func getRandomQuote() -> Quote {
        let index = Int(arc4random_uniform(UInt32(quotes.count)))
        
        return quotes[index]
    }
}
