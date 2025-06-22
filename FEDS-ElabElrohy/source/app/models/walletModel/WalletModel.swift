//
//  WalletModel.swift
//  FEDS-Center-Dev-IOS
//
//  Created by Omar Pakr on 14/03/2024.
//

import Foundation

// MARK: - PaymentModel
struct WalletModel : Codable {
    var status: Int?
    var msg: String?
    var executionTimeMilliseconds: Int?
    var paymentUrl: String?
}
