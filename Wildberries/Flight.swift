//
//  Model.swift
//  Wildberries
//
//  Created by Tatyana Sidoryuk on 02.06.2022.
//

import Foundation

public struct Flight: Codable {
    let startCity: String
    let startCityCode: String
    let endCity: String
    let endCityCode: String
    let startDate: String
    let endDate: String
    let price: Int
    let searchToken: String
}

struct Flights: Codable {
    var data: [Flight]
}
