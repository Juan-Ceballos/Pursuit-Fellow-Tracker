//
//  NSTextAttachment+.swift
//  CodeWarsTracker
//
//  Created by Bienbenido Angeles on 9/22/21.
//

import UIKit

extension NSTextAttachment {
    //str to identify image
    func setUUID(_ str: String) {
        self.accessibilityValue = str
    }
}
