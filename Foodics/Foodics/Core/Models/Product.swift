//
//  Product.swift
//  Foodics
//
//  Created by Ahmed Ramy on 11/18/20.
//  Copyright © 2020 Ahmed Ramy. All rights reserved.
//

import Foundation

// MARK: - MenuCategoriesResponse
public struct CategoryProductsResponse: Codable {
    public var data: [Data]?
    public var links: Links?
    public var meta: Meta?
  
  // MARK: - Datum
  public struct Data: Codable {
      public var category: Category?
      public var id: String?
      public var sku: String?
      public var barcode: String?
      public var name: String?
      public var nameLocalized: String?
      public var description: String?
      public var descriptionLocalized: String?
      public var image: String?
      public var isActive: Bool?
      public var isStockProduct: Bool?
      public var isReady: Bool?
      public var pricingMethod: Int?
      public var sellingMethod: Int?
      public var costingMethod: Int?
      public var preparationTime: Int?
      public var price: Int?
      public var cost: Double?
      public var calories: Int?
      public var createdAt: String?
      public var updatedAt: String?
      public var deletedAt: String?

      enum CodingKeys: String, CodingKey {
          case category = "category"
          case id = "id"
          case sku = "sku"
          case barcode = "barcode"
          case name = "name"
          case nameLocalized = "name_localized"
          case description = "description"
          case descriptionLocalized = "description_localized"
          case image = "image"
          case isActive = "is_active"
          case isStockProduct = "is_stock_product"
          case isReady = "is_ready"
          case pricingMethod = "pricing_method"
          case sellingMethod = "selling_method"
          case costingMethod = "costing_method"
          case preparationTime = "preparation_time"
          case price = "price"
          case cost = "cost"
          case calories = "calories"
          case createdAt = "created_at"
          case updatedAt = "updated_at"
          case deletedAt = "deleted_at"
      }
  }

  // MARK: - Category
  public struct Category: Codable {
      public var id: String?
      public var name: String?
      public var nameLocalized: String?
      public var reference: String?
      public var image: String?
      public var createdAt: String?
      public var updatedAt: String?
      public var deletedAt: String?
  }

  // MARK: - Links
  public struct Links: Codable {
      public var first: String?
      public var last: String?
      public var prev: String?
      public var next: String?
  }

  // MARK: - Meta
  public struct Meta: Codable {
      public var currentPage: Int?
      public var from: Int?
      public var lastPage: Int?
      public var path: String?
      public var perPage: Int?
      public var to: Int?
      public var total: Int?
    
    enum CodingKeys: String, CodingKey {
        case currentPage = "current_page"
        case from = "from"
        case lastPage = "last_page"
        case path = "path"
        case perPage = "per_page"
        case to = "to"
        case total = "total"
    }
  }
}
