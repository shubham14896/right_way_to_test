//	
// Copyright © Essential Developer. All rights reserved.
//

import Foundation

struct CurrencyExchanger {
	private let rates: [CurrencyPair: Decimal]
	
	init(rates: [CurrencyPair: Decimal]) {
		self.rates = rates
	}
	
	struct UnknownExchangeRate: Error {
		let from: Currency
		let to: Currency
	}
	
	func exchange(amount: Amount, toCurrency: Currency) throws -> Amount {
		guard amount.currency != toCurrency else {
			return amount
		}
		
		guard let rate = rates[.init(from: amount.currency, to: toCurrency)] else {
			throw UnknownExchangeRate(from: amount.currency, to: toCurrency)
		}
		
		return Amount(value: amount.value * rate, currency: toCurrency)
	}
}
