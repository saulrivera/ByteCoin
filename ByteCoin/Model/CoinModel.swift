//
//  CoinModel.swift
//  ByteCoin
//
//  Created by Saul Rivera on 15/03/20.
//  Copyright © 2020 The App Brewery. All rights reserved.
//

import Foundation

struct CoinModel {
    let rate: Double
    let assetQuote: String
    
    var formattedRate: String {
        String(format: "%.2f", rate)
    }
}
