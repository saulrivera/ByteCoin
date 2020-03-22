//
//  CoinModel.swift
//  ByteCoin
//
//  Created by Saul Rivera on 15/03/20.
//  Copyright © 2020 The App Brewery. All rights reserved.
//

import Foundation

struct CoinData: Decodable {
    let time: String
    let rate: Double
    let asset_id_base: String
    let asset_id_quote: String
}
