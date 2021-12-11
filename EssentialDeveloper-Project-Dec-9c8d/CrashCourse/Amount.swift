//	
// Copyright © Essential Developer. All rights reserved.
//

import Foundation

struct Currency: Hashable {
	let code: String
}

struct CurrencyPair: Hashable {
	let from: Currency
	let to: Currency
}

struct Amount: Hashable {
	let value: Decimal
	let currency: Currency
}
