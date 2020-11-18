//
//  MenuViewModel.swift
//  Foodics
//
//  Created by Ahmed Ramy on 11/16/20.
//  Copyright © 2020 Ahmed Ramy. All rights reserved.
//

import Foundation
import Carbon

public protocol MenuViewModelProtocol {
  var sections: Dynamic<[Section]> { get set }
}

public final class MenuViewModel: ListableViewModel, MenuViewModelProtocol {
  
  private let model: MenuModel
  public var sections = Dynamic<[Section]>([])
  
  init(router: RouterProtocol, model: MenuModel = MenuModel()) {
    self.model = model
    super.init(router: router)
  }
  
  func viewWillAppear() {
    fetchMenu()
  }
}

// MARK: - UI Building

private extension MenuViewModel {
  func buildUI(_ categories: [MenuCategoriesResponse.Data]) -> [Section] {
    let section = makeSection(id: "categories", items: categories.isEmpty ? getEmptyStateView() : getCategoriesSection(categories))
    return [section]
  }
  
  func getCategoriesSection(_ categories: [MenuCategoriesResponse.Data]) -> [CellNode] {
    
    var cells = categories.map { category -> [CellNode] in
      return [
        SpacingComponent(24).toCellNode(),
        ButtonComponent(type: .text(getCategoryText(from: category), style: PrimaryButtonStyle()), height: 60, backgroundColor: .clear, isEnabled: true, onTap: {
          self.handleSelectingCategory(category)
          }).toCellNode(),
        SpacingComponent(24).toCellNode(),
        SeparatorComponent(leading: true).toCellNode()
      ]
    }.flatMap { $0 }
    
    if model.page > 1 {
      cells.insert(ButtonComponent(type: .text("Load Previous Page", style: PrimaryButtonStyle()), height: 45, backgroundColor: .clear, isEnabled: true, onTap: {
      self.fetchMenu()
      }).toCellNode(), at: 0)
    }
    
    if model.lastPage != model.page {
      cells.append(ButtonComponent(type: .text("Load Next Page", style: PrimaryButtonStyle()), height: 45, backgroundColor: .clear, isEnabled: true, onTap: {
        self.fetchMenu()
        }).toCellNode())
    }
    
    return cells
  }
  
  func getEmptyStateView() -> [CellNode] {
    [
      EmptyStateComponent(with: .noCategories, buttonOnTap: { [weak self] in self?.refreshMenu() }).toCellNode()
    ]
  }
  
  func getCategoryText(from category: MenuCategoriesResponse.Data) -> String {
    let name = (UILocalization.shared.isRTLLanguage ? category.nameLocalized : category.name) ?? .empty
    let description = (UILocalization.shared.isRTLLanguage ? category.descriptionLocalized : category.description) ?? .empty
    
    return """
    \(R.string.localizables.category_name(name))
    \(R.string.localizables.category_description(description))
    \(R.string.localizables.category_calories((category.calories ?? .zero).string))
    """
  }
}

// MARK: - Logic

private extension MenuViewModel {
  
  func handleFetchedMenu() -> Handler<[MenuCategoriesResponse.Data]> {
    return { [weak self] result in
      guard let self = self else { return }
      switch result {
      case .success(let categories):
        self.sections.value = self.buildUI(categories)
      case .failure(let error):
        self.router.alert(error: error)
      }
    }
  }
  
  func fetchMenu() {
    model.fetchMenu(onFetch: handleFetchedMenu())
  }
  
  func refreshMenu() {
    model.refreshMenu(onFetch: handleFetchedMenu())
  }
  
  func fetchPreviousMenuPage() {
    model.fetchPreviousPage(onFetch: handleFetchedMenu())
  }
  
  func handleSelectingCategory(_ category: MenuCategoriesResponse.Data) {
    // Navigate to Products Screen
  }
}
