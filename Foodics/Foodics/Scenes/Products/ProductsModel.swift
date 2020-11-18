//
//  ProductsModel.swift
//  Foodics
//
//  Created by Ahmed Ramy on 11/18/20.
//  Copyright © 2020 Ahmed Ramy. All rights reserved.
//

import Foundation

public final class ProductModel: BaseModel {
  var page: Int = 1
  var limit: Int = Configurations.MenuConfiguration.productsPageLimit
  var lastPage: Int?
  
  public func fetchProducts(onFetch: @escaping Handler<[CategoryProductsResponse.Data]>) {
    network.call(api: CategoriesEndpoint.products(page, limit), model: CategoryProductsResponse.self) { [weak self] (result) in
      guard let self = self else { return }
      switch result {
      case .success(let response):
        self.lastPage = response.meta?.lastPage
        let productsData = response.data ?? []
        onFetch(.success(productsData))
        self.page += 1
      case .failure(let error):
        onFetch(.failure(error))
      }
    }
  }
  
  public func fetchPreviousPage(onFetch: @escaping Handler<[CategoryProductsResponse.Data]>) {
    guard page > 1 else { return }
    page -= 1
    fetchProducts(onFetch: onFetch)
  }
  
  public func refreshProducts(onFetch: @escaping Handler<[CategoryProductsResponse.Data]>) {
    network.call(api: CategoriesEndpoint.categories(page, limit), model: CategoryProductsResponse.self) { [weak self] (result) in
      guard let self = self else { return }
      switch result {
      case .success(let response):
        self.lastPage = response.meta?.lastPage
        let productsData = response.data ?? []
        onFetch(.success(productsData))
      case .failure(let error):
        onFetch(.failure(error))
      }
    }
  }
}
