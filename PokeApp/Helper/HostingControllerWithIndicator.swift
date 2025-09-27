//
//  HostingControllerWithIndicator.swift
//  PokeApp
//
//  Created by rifqi triginandri on 27/09/25.
//

import SwiftUI
import XLPagerTabStrip

// MARK: - Wrapper UIHostingController agar conform ke IndicatorInfoProvider
final class HostingControllerWithIndicator<Content: View>: UIHostingController<Content>, IndicatorInfoProvider {
    private let indicatorTitle: String

    init(title: String, rootView: Content) {
        self.indicatorTitle = title
        super.init(rootView: rootView)
    }

    @MainActor required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: indicatorTitle)
    }
}
