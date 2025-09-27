//
//  LandingView.swift
//  PokeApp
//
//  Created by rifqi triginandri on 27/09/25.
//

import SwiftUI
import XLPagerTabStrip

struct LandingView: View {
    @EnvironmentObject var session: SessionManager

    var body: some View {
        PagerTabWrapper()
            .ignoresSafeArea()
    }
}

// MARK: - SwiftUI wrapper
struct PagerTabWrapper: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> PagerTabController {
        return PagerTabController()
    }

    func updateUIViewController(_ uiViewController: PagerTabController, context: Context) {}
}

// MARK: - UIKit PagerTabController
final class PagerTabController: ButtonBarPagerTabStripViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        settings.style.buttonBarBackgroundColor = .systemBackground
        settings.style.buttonBarItemBackgroundColor = .clear
        settings.style.selectedBarBackgroundColor = .systemBlue
        settings.style.buttonBarItemFont = .systemFont(ofSize: 14, weight: .medium)
        settings.style.buttonBarItemTitleColor = .secondaryLabel
        settings.style.selectedBarHeight = 0
        buttonBarView.selectedBar.backgroundColor = .clear
        buttonBarView.selectedBar.isHidden = true
        settings.style.buttonBarItemsShouldFillAvailableWidth = true
        buttonBarView.backgroundColor = UIColor.systemGray6.withAlphaComponent(0.9)
        buttonBarView.clipsToBounds = true

        changeCurrentIndexProgressive = { oldCell, newCell, _, changeCurrentIndex, _ in
            guard changeCurrentIndex else { return }
            oldCell?.label.textColor = .secondaryLabel
            newCell?.label.textColor = .systemBlue
        }

        buttonBarView.translatesAutoresizingMaskIntoConstraints = false
        if let barSuperview = buttonBarView.superview {
            NSLayoutConstraint.deactivate(buttonBarView.constraints)
            buttonBarView.removeFromSuperview()
            barSuperview.addSubview(buttonBarView)

            NSLayoutConstraint.activate([
                buttonBarView.leadingAnchor.constraint(equalTo: barSuperview.leadingAnchor),
                buttonBarView.trailingAnchor.constraint(equalTo: barSuperview.trailingAnchor),
                buttonBarView.bottomAnchor.constraint(equalTo: barSuperview.safeAreaLayoutGuide.bottomAnchor),
                buttonBarView.heightAnchor.constraint(equalToConstant: 50)
            ])
        }
        
        NotificationCenter.default.addObserver(forName: .toggleTabBar, object: nil, queue: .main) { notif in
            if let show = notif.object as? Bool {
                self.buttonBarView.isHidden = !show
            }
        }

    }


    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        let home = HostingControllerWithIndicator(
            title: "Home",
            rootView: NavigationView { HomeView() }
        )
        let profile = HostingControllerWithIndicator(
            title: "Profile",
            rootView: NavigationView { ProfileView().environmentObject(SessionManager.shared) }
        )
        return [home, profile]
    }
}

extension Notification.Name {
    static let toggleTabBar = Notification.Name("toggleTabBar")
}
