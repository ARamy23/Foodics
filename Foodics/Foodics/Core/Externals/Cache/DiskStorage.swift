//
//  DiskStorage.swift
//  Foodics
//
//  Created by Ahmed Ramy on 11/16/20.
//  Copyright © 2020 Ahmed Ramy. All rights reserved.
//

import Foundation

public final class DiskStorage {
  private let queue: DispatchQueue
  private let fileManager: FileManager
  private let path: URL
  
  public init(
    queue: DispatchQueue = .global(qos: DispatchQoS.QoSClass.default),
    fileManager: FileManager = .default,
    path: URL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]) {
    self.queue = queue
    self.fileManager = fileManager
    self.path = path
  }
}

extension DiskStorage: WritableStorage {
  public func save(value: Data, for key: StorageKey) throws {
    let url = path.appendingPathComponent(key.key)
    do {
      try self.createFolders(in: url)
      try value.write(to: url, options: .atomic)
    } catch {
      throw StorageError.cantWrite(error)
    }
  }
  
  public func save(value: Data, for key: StorageKey, handler: @escaping Handler<Data>) {
    queue.async {
      do {
        try self.save(value: value, for: key)
        handler(.success(value))
      } catch {
        handler(.failure(error))
      }
    }
  }
}

extension DiskStorage {
  private func createFolders(in url: URL) throws {
    let folderUrl = url.deletingLastPathComponent()
    if !fileManager.fileExists(atPath: folderUrl.path) {
      try fileManager.createDirectory(
        at: folderUrl,
        withIntermediateDirectories: true,
        attributes: nil
      )
    }
  }
}

extension DiskStorage: ReadableStorage {
  public func fetchValue(for key: StorageKey) throws -> Data {
    let url = path.appendingPathComponent(key.key)
    guard let data = fileManager.contents(atPath: url.path) else {
      throw StorageError.notFound
    }
    return data
  }
  
  public func fetchValue(for key: StorageKey, handler: @escaping Handler<Data>) {
    queue.async {
      handler(Result { try self.fetchValue(for: key) })
    }
  }
}
