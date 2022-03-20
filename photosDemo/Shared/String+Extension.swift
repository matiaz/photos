//
//  String+Extension.swift
//  photosDemo
//
//  Created by dmatiaz on 14/3/22.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}
