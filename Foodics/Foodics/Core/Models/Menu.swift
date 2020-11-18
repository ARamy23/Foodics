//
//  Menu.swift
//  Foodics
//
//  Created by Ahmed Ramy on 11/16/20.
//  Copyright © 2020 Ahmed Ramy. All rights reserved.
//

import Foundation

// MARK: - MenuCategoriesResponse
public struct MenuCategoriesResponse: Codable {
  public var data: [Data]?
  public var links: Links?
  public var meta: Meta?
  
  enum CodingKeys: String, CodingKey {
    case data = "data"
    case links = "links"
    case meta = "meta"
  }
}

public extension MenuCategoriesResponse {
  // MARK: - Data
  final class Data: Codable, Equatable, Then  {
    public static func == (lhs: MenuCategoriesResponse.Data, rhs: MenuCategoriesResponse.Data) -> Bool {
      lhs.id ?? "-1" == rhs.id ?? "0"
    }
    
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
    public var cost: Cost?
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
  struct Category: Codable {
    public var id: String?
    public var name: String?
    public var nameLocalized: String?
    public var reference: String?
    public var image: String?
    public var createdAt: String?
    public var updatedAt: String?
    public var deletedAt: String?
    
    enum CodingKeys: String, CodingKey {
      case id = "id"
      case name = "name"
      case nameLocalized = "name_localized"
      case reference = "reference"
      case image = "image"
      case createdAt = "created_at"
      case updatedAt = "updated_at"
      case deletedAt = "deleted_at"
    }
  }
  
  enum Cost: Codable {
    case double(Double)
    case string(String)
    case null
    
    public init(from decoder: Decoder) throws {
      let container = try decoder.singleValueContainer()
      if let x = try? container.decode(Double.self) {
        self = .double(x)
        return
      }
      if let x = try? container.decode(String.self) {
        self = .string(x)
        return
      }
      if container.decodeNil() {
        self = .null
        return
      }
      throw DecodingError.typeMismatch(Cost.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Cost"))
    }
    
    public func encode(to encoder: Encoder) throws {
      var container = encoder.singleValueContainer()
      switch self {
      case .double(let x):
        try container.encode(x)
      case .string(let x):
        try container.encode(x)
      case .null:
        try container.encodeNil()
      }
    }
  }
  
  // MARK: - Links
  struct Links: Codable {
    public var first: String?
    public var last: String?
    public var prev: String?
    public var next: String?
    
    enum CodingKeys: String, CodingKey {
      case first = "first"
      case last = "last"
      case prev = "prev"
      case next = "next"
    }
  }
  
  // MARK: - Meta
  struct Meta: Codable {
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
