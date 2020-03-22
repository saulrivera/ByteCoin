//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Saul Rivera on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

protocol CoinManagerDelegate {
    func didUpdatePrice(_ coin: CoinModel)
    func didFailedPriceWithError(_ error: Error)
}

struct CoinManager {
    var delegate: CoinManagerDelegate?
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "869CF23A-1D21-45FB-A361-9C43D2E9FE9B"
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]

    func getCoinPrice(for currency: String) {
        let urlString = "\(baseURL)/\(currency)"
        fetchPrice(from: urlString)
    }
    
    private func fetchPrice(from urlString: String) {
        if let url = URL(string: urlString) {
            var urlRequest = URLRequest(url: url)
            urlRequest.setValue(apiKey, forHTTPHeaderField: "X-CoinAPI-Key")
            
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: urlRequest) { (data, response, error) in
                if let error = error {
                    self.delegate?.didFailedPriceWithError(error)
                    return
                }
                
                if let data = data {
                    if let coin = self.parseJSON(data) {
                        self.delegate?.didUpdatePrice(coin)
                    }
                }
            }
            task.resume()
        }
    }
    
    private func parseJSON(_ data: Data) -> CoinModel? {
        let decoder = JSONDecoder()
        do {
            let decoderData = try decoder.decode(CoinData.self, from: data)
            let rate = decoderData.rate
            let assetQuote = decoderData.asset_id_quote
            let coinModel = CoinModel(rate: rate, assetQuote: assetQuote)
            return coinModel
        } catch {
            return nil
        }
    }
}
