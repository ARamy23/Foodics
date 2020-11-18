//
//  MenuModel.swift
//  Foodics
//
//  Created by Ahmed Ramy on 11/18/20.
//  Copyright © 2020 Ahmed Ramy. All rights reserved.
//

import Foundation

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
