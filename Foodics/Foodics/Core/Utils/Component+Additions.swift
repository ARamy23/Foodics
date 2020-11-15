//
//  Component+Additions.swift
//  Foodics
//
//  Created by Ahmed Ramy on 11/16/20.
//  Copyright © 2020 Ahmed Ramy. All rights reserved.
//

import Carbon

public extension IdentifiableComponent {
  var id: String { return reuseIdentifier }

  func toCellNode() -> CellNode {
    return CellNode(self)
  }

  func toViewNode() -> ViewNode {
    return ViewNode(self)
  }
}
