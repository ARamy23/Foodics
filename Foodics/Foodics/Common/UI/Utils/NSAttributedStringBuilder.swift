//
//  NSAttributedStringBuilder.swift
//  Foodics
//
//  Created by Ahmed Ramy on 10/2/20.
//  Copyright © 2020 Foodics. All rights reserved.
//

import UIKit

public class NSAttributedStringBuilder {
    private var attributedString = NSMutableAttributedString()
    
    private func wholeString() -> NSRange {
        .init(location: 0, length: attributedString.string.count)
    }
    
    @discardableResult
    public func add(text: String)-> NSAttributedStringBuilder {
        attributedString.append(NSAttributedString(string: text))
        return self
    }
    
    @discardableResult
    public func add(foregroundColor: UIColor)-> NSAttributedStringBuilder {
        attributedString.addAttribute(.foregroundColor, value: foregroundColor, range: wholeString())
        return self
    }
    
    @discardableResult
    public func add(foregroundColor: UIColor, for string: String)-> NSAttributedStringBuilder {
        guard let substringRange = attributedString.string.range(of: string) else { return self }
        let range = NSRange(substringRange, in: attributedString.string)
        attributedString.addAttribute(.foregroundColor, value: foregroundColor, range: range)
        return self
    }
    
    @discardableResult
    public func add(font: UIFont, for string: String)-> NSAttributedStringBuilder {
        guard let substringRange = attributedString.string.range(of: string) else { return self }
        let range = NSRange(substringRange, in: attributedString.string)
        attributedString.addAttribute(.font, value: font, range: range)
        return self
    }
    
    @discardableResult
    public func add(font: UIFont)-> NSAttributedStringBuilder {
        attributedString.addAttribute(.font, value: font, range: wholeString())
        return self
    }
    
    @discardableResult
    public func add(underlineFor string: String)-> NSAttributedStringBuilder {
        guard let substringRange = attributedString.string.range(of: string) else { return self }
        let range = NSRange(substringRange, in: attributedString.string)
        attributedString.addAttribute(.underlineStyle, value: NSUnderlineStyle.single, range: range)
        return self
    }
    
    public func build() -> NSAttributedString {
        attributedString.attributedSubstring(from: wholeString())
    }
}
