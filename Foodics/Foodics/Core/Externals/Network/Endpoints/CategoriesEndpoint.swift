//
//  CategoriesEndpoint.swift
//  Foodics
//
//  Created by Ahmed Ramy on 11/16/20.
//  Copyright © 2020 Ahmed Ramy. All rights reserved.
//

import Moya

enum CategoriesEndpoint {
  case categories(_ page: Int, _ limit: Int)
}

extension CategoriesEndpoint: Endpoint {
  var path: String {
    switch self {
    case .categories:
      return "categories"
    }
  }
  
  var task: Moya.Task {
    switch self {
    case let .categories(page, limit):
      return .requestParameters(
        parameters: ["page": page,
                     "limit": limit], // TODO: - Change limit key to the correct key after Foodics Reply
        encoding: URLEncoding.default
      )
    }
  }
  
  var method: Method {
    switch self {
    case .categories:
      return .get
    }
  }
}
