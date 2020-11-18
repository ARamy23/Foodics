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
  
  private func buildUI(_ categories: [MenuCategoriesResponse.Data]) -> [Section] {
    let section = makeSection(id: "categories", items: categories.isEmpty ? getEmptyStateView() : getCategoriesSection(categories))
    return [section]
  }
}

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
  
  func getCategoriesSection(_ categories: [MenuCategoriesResponse.Data]) -> [CellNode] {
    
    var cells = categories.map { category -> [CellNode] in
      
      let name = (UILocalization.shared.isRTLLanguage ? category.nameLocalized : category.name) ?? .empty
      let description = (UILocalization.shared.isRTLLanguage ? category.descriptionLocalized : category.description) ?? .empty
      
      return [
        SpacingComponent(24).toCellNode(),
        LabelComponent(text: R.string.localizables.category_name(name), color: .black, font: TextStyles.title1, isCentered: true, backgroundColor: .clear).toCellNode(),
        LabelComponent(text: R.string.localizables.category_description(description), color: .black, font: TextStyles.body, isCentered: true, backgroundColor: .clear).toCellNode(),
        LabelComponent(text: R.string.localizables.category_calories((category.calories ?? .zero).string), color: .black, font: TextStyles.button, isCentered: true, backgroundColor: .clear).toCellNode(),
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
}

public final class MenuModel: BaseModel {
  var page: Int = 1
  let limit: Int = Configurations.MenuConfiguration.categoriesPageLimit
  var lastPage: Int?
  
  public func fetchMenu(onFetch: @escaping Handler<[MenuCategoriesResponse.Data]>) {
    if page == 1, let cachedCategories = try? self.cache.fetch([MenuCategoriesResponse.Data].self, for: .menu) {
      onFetch(.success(cachedCategories))
    } else {
      network.call(api: CategoriesEndpoint.categories(page, limit), model: MenuCategoriesResponse.self) { [weak self] (result) in
        guard let self = self else { return }
        switch result {
        case .success(let response):
          self.lastPage = response.meta?.lastPage
          let categoriesData = response.data ?? []
          try? self.cache.save(categoriesData, for: .menu)
          onFetch(.success(categoriesData))
          self.page += 1
        case .failure(let error):
          onFetch(.failure(error))
        }
      }
    }
  }
  
  public func fetchPreviousPage(onFetch: @escaping Handler<[MenuCategoriesResponse.Data]>) {
    guard page > 1 else { return }
    page -= 1
    fetchMenu(onFetch: onFetch)
  }
  
  public func refreshMenu(onFetch: @escaping Handler<[MenuCategoriesResponse.Data]>) {
    network.call(api: CategoriesEndpoint.categories(page, limit), model: MenuCategoriesResponse.self) { [weak self] (result) in
      guard let self = self else { return }
      switch result {
      case .success(let response):
        let categoriesData = response.data ?? []
        try? self.cache.save(categoriesData, for: .menu)
        onFetch(.success(categoriesData))
      case .failure(let error):
        onFetch(.failure(error))
      }
    }
  }
}
