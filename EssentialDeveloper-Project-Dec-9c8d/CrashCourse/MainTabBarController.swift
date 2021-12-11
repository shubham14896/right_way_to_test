//	
// Copyright © Essential Developer. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
	
	convenience init() {
		self.init(nibName: nil, bundle: nil)
		self.setupViewController()
	}

	private func setupViewController() {
		viewControllers = [
			makeNav(for: makeFriendsList(), title: "Friends", icon: "person.2.fill"),
			makeTransfersList(),
			makeNav(for: makeCardsList(), title: "Cards", icon: "creditcard.fill")
		]
	}
	
	private func makeNav(for vc: UIViewController, title: String, icon: String) -> UIViewController {
		vc.navigationItem.largeTitleDisplayMode = .always
		
		let nav = UINavigationController(rootViewController: vc)
		nav.tabBarItem.image = UIImage(
			systemName: icon,
			withConfiguration: UIImage.SymbolConfiguration(scale: .large)
		)
		nav.tabBarItem.title = title
		nav.navigationBar.prefersLargeTitles = true
		return nav
	}
	
	private func makeTransfersList() -> UIViewController {
		let sent = makeSentTransfersList()
		sent.navigationItem.title = "Sent"
		sent.navigationItem.largeTitleDisplayMode = .always
		
		let received = makeReceivedTransfersList()
		received.navigationItem.title = "Received"
		received.navigationItem.largeTitleDisplayMode = .always
		
		let vc = SegmentNavigationViewController(first: sent, second: received)
		vc.tabBarItem.image = UIImage(
			systemName: "arrow.left.arrow.right",
			withConfiguration: UIImage.SymbolConfiguration(scale: .large)
		)
		vc.title = "Transfers"
		vc.navigationBar.prefersLargeTitles = true
		return vc
	}
	
	private func makeFriendsList() -> ListViewController {
		let vc = ListViewController()
		vc.fromFriendsScreen = true
		vc.title = "Friends"
		vc.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: vc, action: #selector(addFriend))

		return vc
	}
	
	private func makeSentTransfersList() -> ListViewController {
		let vc = ListViewController()
		vc.fromSentTransfersScreen = true
		vc.navigationItem.title = "Sent"
		vc.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Send", style: .done, target: vc, action: #selector(sendMoney))

		return vc
	}
	
	private func makeReceivedTransfersList() -> ListViewController {
		let vc = ListViewController()
		vc.fromReceivedTransfersScreen = true
		vc.navigationItem.title = "Received"
		vc.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Request", style: .done, target: vc, action: #selector(requestMoney))
		return vc
	}
	
	private func makeCardsList() -> ListViewController {
		let vc = ListViewController()
		vc.fromCardsScreen = true
		vc.title = "Cards"
		vc.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: vc, action: #selector(addCard))

		return vc
	}
	
}
