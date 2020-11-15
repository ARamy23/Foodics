//
//  Aliases.swift
//  Foodics
//
//  Created by Ahmed Ramy on 9/30/20.
//  Copyright © 2020 Foodics. All rights reserved.
//

import Foundation

public typealias Handler<T> = (Result<T, Error>) -> Void
public typealias Callback<T> = (_: T) -> Void
public typealias VoidCallback = () -> Void
