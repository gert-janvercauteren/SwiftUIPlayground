import XCTest
import SwiftUI
import UIKit

import SnapshotTesting

@testable import search

class EmptyViewTests: XCTestCase {
    
    func test_emptyFavoritesView() {
        // Given
        let sut = EmptyView.emptyFavorites
        let host: UIView = UIHostingController(rootView: sut).view
        
        assertSnapshot(matching: host, as: .image(size: host.intrinsicContentSize))
    }
    
    func test_emptyFavoritesView_darkMode() {
        // Given
        let sut = EmptyView.emptyFavorites
        let host: UIView = UIHostingController(rootView: sut).view
        
        let traitDarkMode = UITraitCollection(userInterfaceStyle: .dark)
        assertSnapshot(matching: host, as: .image(size: host.intrinsicContentSize, traits: traitDarkMode))
    }
}
