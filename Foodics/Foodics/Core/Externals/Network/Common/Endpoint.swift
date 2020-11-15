//
//  Endpoint.swift
//  Foodics
//
//  Created by Ahmed Ramy on 10/1/20.
//  Copyright © 2020 Foodics. All rights reserved.
//

import Moya

public protocol Endpoint: TargetType {}

extension Endpoint {
  var baseURL: URL {
    #if DEBUG
    return URL(string: "https://api.foodics.dev/v5/")!
    #elseif RELEASE
    return URL(string: "https://api.foodics.dev/v5/")! // TODO: - Change BaseURL to the production BaseURL
    #endif
  }
  
  var headers: [String : String]? {
    let authorization: String = Secrets.staticToken
    let jsonHeaderValue = "application/json"
    let headers = [
      "Content-type": jsonHeaderValue,
      "Accept": jsonHeaderValue,
      "Authorization": "Bearer \(authorization)"
    ]
    
    return headers
  }
  
  var sampleData: Data {
    Data()
  }
}

fileprivate enum Secrets {
  static let staticToken = "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6ImZkZmVkODk0M2U2OWUwYzQ1OTNlYTFkNTZjZjczYjcxYmNjMzM2ZWQzZDJlYjcyYTBhYTNkZGJmNzI1ZmY5YzU5Nzg0OGEzMjc2ODdhYTM2In0.eyJhdWQiOiI4Zjc4NjY2NC0wNTg5LTQ3MTgtODBkMS1lMTY4M2FmYmM3MjQiLCJqdGkiOiJmZGZlZDg5NDNlNjllMGM0NTkzZWExZDU2Y2Y3M2I3MWJjYzMzNmVkM2QyZWI3MmEwYWEzZGRiZjcyNWZmOWM1OTc4NDhhMzI3Njg3YWEzNiIsImlhdCI6MTYwNTQzMzE0MywibmJmIjoxNjA1NDMzMTQzLCJleHAiOjE2MzY5NjkxNDMsInN1YiI6IjhmN2I2NmYwLWE1MjctNGNkNC05MjNkLTYyODM3MDQ1Yjk5NSIsInNjb3BlcyI6WyJnZW5lcmFsLnJlYWQiXSwiYnVzaW5lc3MiOiI4ZjdiNjZmMC1hNTUxLTRlNmYtODU5Mi0wMmRhZjBjNTUzODYiLCJyZWZlcmVuY2UiOiIxMDAwMDAifQ.EbXt1iHjJ9MOsf6Aav-klCVSfeMrOqdRUVEvNTNUts_0NXOU7JgJlfTHAxgCngTAo3v1G1T1747Nxzam9H_i4urDRKKHD_a-mWtHsmy1FCgoKkzropi9a0D2S8UOQa5a9nc_pt5ewTl4E86DJVpAIQ221IsvuR8fZxhW0EZ26lG9dOfmUT10E34q146MRAcFkcDSAm_19cDLFcgiL0WTBbVf2wGxEylMI1ZzScTdptUuBbb9iJveGmvR1Hvwp0Rs7Mr7E4sitcG_T15DzXHwjJtAQUbp2iOL0wIS3xlvPTkXHgv-L5DCfdNZZNjq7iW4YdlQdHJnqq7Td6a579BIUghUXVtA1_977XwU6IJv_a_jkvtdTHDvGXklg4k_bSFRxcJZdc2CgIidIqkwpK1ZbjkB1Pv6l9BeEpyN69xnDv8T74zQiJl_EdGhmarf5qc62MgDNxRBZ6CpIZTVJ0sZV77APWoOUrXwmXpJ25-VCQl5aOXwXDjAnFGZNNurqGlFstuc95oJiQu0v1veyjhf9hTZesvfxgsfNYk_HeZv5llsNWO2nB1Y0j0iSZQ3Sx0G5nkaA2ScERATZlS8ANW6HLzGpn-3FgaGxP69G1DMeEOhajAvNSNEh9O4T7pkOcRAuiYQknHZHxgoB9EKxj4ejtciC40sKnZ4hGwuwnN4MiE"
}
