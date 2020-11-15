//
//  NSAttributedStringBuilder.swift
//  Foodics
//
//  Created by Ahmed Ramy on 10/2/20.
//  Copyright © 2020 Foodics. All rights reserved.
//

import UIKit

class AttributedStringBuilder {
    private var attributedString = NSMutableAttributedString()
    
    private func wholeString() -> NSRange {
        .init(location: 0, length: attributedString.string.count)
    }
    
    @discardableResult
    func add(text: String)-> AttributedStringBuilder {
        attributedString.append(NSAttributedString(string: text))
        return self
    }
    
    @discardableResult
    func add(foregroundColor: UIColor)-> AttributedStringBuilder {
        attributedString.addAttribute(.foregroundColor, value: foregroundColor, range: wholeString())
        return self
    }
    
    @discardableResult
    func add(foregroundColor: UIColor, for string: String)-> AttributedStringBuilder {
        guard let substringRange = attributedString.string.range(of: string) else { return self }
        let range = NSRange(substringRange, in: attributedString.string)
        attributedString.addAttribute(.foregroundColor, value: foregroundColor, range: range)
        return self
    }
    
    @discardableResult
    func add(font: UIFont, for string: String)-> AttributedStringBuilder {
        guard let substringRange = attributedString.string.range(of: string) else { return self }
        let range = NSRange(substringRange, in: attributedString.string)
        attributedString.addAttribute(.font, value: font, range: range)
        return self
    }
    
    @discardableResult
    func add(font: UIFont)-> AttributedStringBuilder {
        attributedString.addAttribute(.font, value: font, range: wholeString())
        return self
    }
    
    @discardableResult
    func add(underlineFor string: String)-> AttributedStringBuilder {
        guard let substringRange = attributedString.string.range(of: string) else { return self }
        let range = NSRange(substringRange, in: attributedString.string)
        attributedString.addAttribute(.underlineStyle, value: NSUnderlineStyle.single, range: range)
        return self
    }
    
    func build() -> NSAttributedString {
        attributedString.attributedSubstring(from: wholeString())
    }
}
