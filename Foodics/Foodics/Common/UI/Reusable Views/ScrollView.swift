//
//  ScrollView.swift
//  Foodics
//
//  Created by Ahmed Ramy on 10/13/20.
//  Copyright © 2020 Foodics. All rights reserved.
//

import UIKit

final class ScrollView: UIScrollView {
  
  var shouldDisableTopBounce: Bool = false
  
  let scrollableContentView = UIView().then {
    $0.clipsToBounds = false
    $0.backgroundColor = .clear
  }
  
  public override init(frame: CGRect) {
    super.init(frame: frame)
    initialize()
  }
  
  public required init?(coder: NSCoder) {
    super.init(coder: coder)
    initialize()
  }
}

extension ScrollView {
  func initialize() {
    self.clipsToBounds = false
    self.delegate = self
    
    self.addSubview(scrollableContentView)
    
    scrollableContentView.snp.makeConstraints { (make) in
      make.top.leading.trailing.centerX.equalToSuperview()
      make.bottom.centerY.equalToSuperview().priority(250)
      make.height.equalToSuperview().priority(250)
      make.width.equalToSuperview()
    }
  }
}

extension ScrollView: UIScrollViewDelegate {
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    guard shouldDisableTopBounce else { return }
    if scrollView.contentOffset.y > scrollView.contentSize.height - scrollView.bounds.height {
        scrollView.contentOffset.y = scrollView.contentSize.height - scrollView.bounds.height
    }
  }
}
