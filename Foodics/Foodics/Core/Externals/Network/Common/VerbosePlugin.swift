//
//  VerbosePlugin.swift
//  Foodics
//
//  Created by Ahmed Ramy on 10/24/20.
//  Copyright © 2020 Foodics. All rights reserved.
//

import Moya

struct VerbosePlugin: PluginType {
  func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
    #if DEBUG
    if let body = request.httpBody,
      let str = String(data: body, encoding: .utf8),
      let httpMethod = request.method,
      let headers = request.allHTTPHeaderFields
    {
      print("[Request Start]")
      print("HTTP Method: \(httpMethod.rawValue)")
      print("Headers:\n\(headers)")
      print("Parameters:\n\(str)")
      print("[Request End]")
    }
    #endif
    return request
  }
  
  func didReceive(_ result: Result<Response, MoyaError>, target: TargetType) {
    #if DEBUG
    print("[Response Start]")
    switch result {
    case .success(let body):
      
      if let json = try? JSONSerialization.jsonObject(with: body.data, options: .mutableContainers) {
        print(json)
      } else {
        let response = String(data: body.data, encoding: .utf8)!
        print(response)
      }
    case .failure(let error):
      print(error)
    }
    print("[Response End]")
    #endif
  }
}
