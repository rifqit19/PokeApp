//
//  String+Extension.swift
//  PokeApp
//
//  Created by rifqi triginandri on 27/09/25.
//

import Foundation
import UIKit

extension String {
    var capitalizedFirst: String { prefix(1).capitalized + dropFirst() }
}
