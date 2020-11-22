//
//  ProductsViewModel.swift
//  Foodics
//
//  Created by Ahmed Ramy on 11/18/20.
//  Copyright © 2020 Ahmed Ramy. All rights reserved.
//

import Carbon

public protocol ProductsViewModelProtocol {
  var sections: Dynamic<[Section]> { get set }
  func refreshProducts()
}

public final class ProductsViewModel: ListableViewModel, ProductsViewModelProtocol {
  private let model: ProductModel
  private let category: MenuCategoriesResponse.Data
  public var sections = Dynamic<[Section]>([])
  
  
  init(router: RouterProtocol,
       model: ProductModel = ProductModel(),
       category: MenuCategoriesResponse.Data
  ) {
    self.model = model
    self.category = category
    super.init(router: router)
  }
  
  public func viewWillAppear() {
    fetchProducts()
  }
  
  public func refreshProducts() {
    model.refreshProducts(onFetch: handleFetchedProducts())
  }
}

// MARK: - UI Building
private extension ProductsViewModel {
  func buildUI(_ products: [CategoryProductsResponse.Data]) -> [Section] {
    let section = makeSection(id: "products", items: products.isEmpty ? getEmptyStateView() : getProductsSection(products))
    return [section]
  }
  
  func getProductsSection(_ products: [CategoryProductsResponse.Data]) -> [CellNode] {
    var cells = products.map { product -> [CellNode] in
      return [
        SpacingComponent(24).toCellNode(),
        ProductItemComponent(id: product.id ?? "", viewModel: ProductItemViewModel(image: product.image ?? "", name: product.name ?? "", onTapAction: {
          // TODO: - Move product to MenuViewController
          })).toCellNode(),
        SpacingComponent(24).toCellNode(),
        SeparatorComponent(leading: false).toCellNode()
      ]
    }.flatMap { $0 }
    
    if model.page > 1 {
      cells.insert(ButtonComponent(type: .text("Load Previous Page", style: PrimaryButtonStyle()), height: 45, backgroundColor: .clear, isEnabled: true, onTap: {
      self.fetchPreviousProductsPage()
      }).toCellNode(), at: 0)
    }
    
    if model.lastPage != model.page {
      cells.append(ButtonComponent(type: .text("Load Next Page", style: PrimaryButtonStyle()), height: 45, backgroundColor: .clear, isEnabled: true, onTap: {
        self.fetchProducts()
        }).toCellNode())
    }
    
    return cells
  }
  
  func getEmptyStateView() -> [CellNode] {
    [
      EmptyStateComponent(with: .noProducts, buttonOnTap: refreshProducts).toCellNode()
    ]
  }
}

// MARK: - Logic
private extension ProductsViewModel {
  func handleFetchedProducts() -> Handler<[CategoryProductsResponse.Data]> {
    return { [weak self] result in
      guard let self = self else { return }
      switch result {
      case .success(let products):
        self.sections.value = self.buildUI(products)
      case .failure(let error):
        self.router.alert(error: error)
      }
    }
  }
  
  func fetchProducts() {
    model.fetchProducts(onFetch: handleFetchedProducts())
  }
  
  func fetchPreviousProductsPage() {
    model.fetchPreviousPage(onFetch: handleFetchedProducts())
  }
}
