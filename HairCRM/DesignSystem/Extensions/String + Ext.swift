//
//  String + Ext.swift
//  HairCRM
//
//  Created by Келлер Дмитрий on 18.07.2026.
//

import Foundation

extension String {
    var htmlToString: String {
        guard let data = data(using: .utf8) else { return self }
        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]
        if let attributed = try? NSAttributedString(data: data, options: options, documentAttributes: nil) {
            return attributed.string
        }
        return self
    }
}

extension String {
    var localized: String {
        NSLocalizedString(self, comment: "")
    }
}
