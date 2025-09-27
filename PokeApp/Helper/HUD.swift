//
//  HUD.swift
//  PokeApp
//
//  Created by rifqi triginandri on 27/09/25.
//

import MBProgressHUD
import UIKit

final class HUD {
    static func show(_ text: String? = nil, mode: MBProgressHUDMode = .indeterminate) {
        guard let window = UIApplication.shared.connectedScenes
            .compactMap({ ($0 as? UIWindowScene)?.keyWindow }).first else { return }
        
        let hud = MBProgressHUD.showAdded(to: window, animated: true)
        hud.mode = mode
        hud.label.text = text
        hud.isUserInteractionEnabled = false 
    }
    
    static func hide() {
        guard let window = UIApplication.shared.connectedScenes
            .compactMap({ ($0 as? UIWindowScene)?.keyWindow }).first else { return }
        
        MBProgressHUD.hide(for: window, animated: true)
    }
}
