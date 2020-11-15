//
//  ListableViewModel.swift
//  Foodics
//
//  Created by Ahmed Ramy on 11/16/20.
//  Copyright © 2020 Ahmed Ramy. All rights reserved.
//

import Carbon

protocol ListableViewModelProtocol {
  func makeSection(id: String,
                   header: ViewNode?,
                   items: [CellNode],
                   footer: ViewNode?,
                   topSpacing: Bool,
                   bottomSpacing: Bool,
                   spacing: CGFloat) -> Section
  func makeSection(id: Int,
                   header: ViewNode?,
                   items: [CellNode],
                   footer: ViewNode?,
                   topSpacing: Bool,
                   bottomSpacing: Bool,
                   spacing: CGFloat) -> Section
}

extension ListableViewModelProtocol {
  func makeSection(id: String,
                            header: ViewNode? = nil,
                            items: [CellNode],
                            footer: ViewNode? = nil,
                            topSpacing: Bool = false,
                            bottomSpacing: Bool = false,
                            spacing: CGFloat = 20) -> Section {
    let spacingIdentifier = "spacing"
    var cells: [CellNode] = []
    
    if topSpacing {
      cells.append(SpacingComponent(spacing).identified(by: spacingIdentifier).toCellNode())
    }
    
    cells.append(contentsOf: items)
    
    if bottomSpacing {
      cells.append(SpacingComponent(spacing).identified(by: spacingIdentifier).toCellNode())
    }
    
    return Section(id: id, header: header, cells: cells, footer: footer)
  }

  func makeSection(id: Int,
                   header: ViewNode? = nil,
                   items: [CellNode],
                   footer: ViewNode? = nil,
                   topSpacing: Bool = false,
                   bottomSpacing: Bool = false,
                   spacing: CGFloat = 20) -> Section {
    return makeSection(id: id.description, header: header,
                       items: items, footer: footer,
                       topSpacing: topSpacing, bottomSpacing: bottomSpacing, spacing: spacing)
  }
}

open class ListableViewModel: BaseViewModel, ListableViewModelProtocol {

}

