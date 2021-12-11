//	
// Copyright © Essential Developer. All rights reserved.
//

import UIKit

enum Formatters {
	static var date = DateFormatter()
	static var number = NumberFormatter()
}

extension UIViewController {
	func show(_ error: Error) {
		let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
		alert.addAction(UIAlertAction(title: "Ok", style: .default))
		present(alert, animated: true)
	}

	@objc func addFriend() {
		navigationController?.pushViewController(AddFriendViewController(), animated: true)
	}

	func show(_ friend: Friend) {
		let vc = FriendDetailsViewController()
		vc.friend = friend
		navigationController?.pushViewController(vc, animated: true)
	}
	
	@objc func addCard() {
		navigationController?.pushViewController(AddCardViewController(), animated: true)
	}
		
	@objc func sendMoney() {
		navigationController?.pushViewController(SendMoneyViewController(), animated: true)
	}
	
	@objc func requestMoney() {
		navigationController?.pushViewController(RequestMoneyViewController(), animated: true)
	}
}
