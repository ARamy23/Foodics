//
//  MenuViewModel.swift
//  Foodics
//
//  Created by Ahmed Ramy on 11/16/20.
//  Copyright © 2020 Ahmed Ramy. All rights reserved.
//

import Foundation
import Carbon

public protocol MenuViewModelProtocol: LifecycleAware {
  var state: Dynamic<MenuViewModel.State> { get set }
  func refreshMenu()
}

public final class MenuViewModel: ListableViewModel, MenuViewModelProtocol {
  
  private let model: MenuModel
  public var state = Dynamic<MenuViewModel.State>(.initial)
  
  public init(router: RouterProtocol, model: MenuModel = MenuModel()) {
    self.model = model
    super.init(router: router)
  }
  
  public func viewWillAppear() {
    fetchMenu()
  }
  
  public func refreshMenu() {
    model.refreshMenu(onFetch: handleFetchedMenu())
  }
}

public extension MenuViewModel {
  enum State {
    case initial
    case render(_ sections: [Section])
    case showPopup(_ product: CategoryProductsResponse.Data)
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
      self.fetchPreviousMenuPage()
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
        self.state.value = .render(self.buildUI(categories))
      case .failure(let error):
        self.router.alert(error: error)
      }
    }
  }
  
  func fetchMenu() {
    model.fetchMenu(onFetch: handleFetchedMenu())
  }
  
  func fetchPreviousMenuPage() {
    model.fetchPreviousPage(onFetch: handleFetchedMenu())
  }
  
  func handleSelectingCategory(_ category: MenuCategoriesResponse.Data) {
    let vc = ProductsViewController()
    let viewMdoel = ProductsViewModel(router: self.router, category: category) { [weak self] product in
      self?.state.value = .showPopup(product)
    }
    vc.bind(to: viewMdoel)
    
    router.push(vc)
  }
}
