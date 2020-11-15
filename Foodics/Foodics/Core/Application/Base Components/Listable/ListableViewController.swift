//
//  ListableViewController.swift
//  Foodics
//
//  Created by Ahmed Ramy on 11/16/20.
//  Copyright © 2020 Ahmed Ramy. All rights reserved.
//

import SnapKit
import UIKit
import Carbon

open class ListableViewController: BaseViewController {

  var tableViewStyle: UITableView.Style {
    return .grouped
  }
  
  var tableView: ContentSizedTableView!

  let renderer = Renderer(
    adapter: UITableViewCustomAdapter(),
    updater: UITableViewUpdater()
  )

  open override func viewDidLoad() {
    super.viewDidLoad()
    initialize()
  }
  
  public override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)

    toggleNavigationBar(show: true)
  }
}

private extension ListableViewController {
  func initialize() {
    setupViews()
    setupConstraints()
    configureRender()
  }

  func configureRender() {
    renderer.adapter.parentViewController = self
    renderer.target = tableView
  }

  func setupViews() {
    setupTableView()
    tableView.contentInsetAdjustmentBehavior = .never
    
    vStackView.addArrangedSubview(tableView)
  }

  func setupConstraints() {
   
  }
  
  func setupTableView() {
    tableView = ContentSizedTableView(frame: .zero, style: tableViewStyle).then {
      $0.setContentCompressionResistancePriority(.required, for: .vertical)
      $0.setContentHuggingPriority(.defaultLow, for: .vertical)
      $0.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: CGFloat.leastNonzeroMagnitude, height: CGFloat.leastNonzeroMagnitude))
      $0.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: CGFloat.leastNonzeroMagnitude, height: CGFloat.leastNonzeroMagnitude))
      $0.separatorStyle = .none
      $0.backgroundColor = R.color.primaryBackgroundColor()
      $0.contentInset = .zero
    }
  }
}

public final class ContentSizedTableView: UITableView {
  public override var contentSize: CGSize {
    didSet {
      invalidateIntrinsicContentSize()
    }
  }

  public override var intrinsicContentSize: CGSize {
    layoutIfNeeded()
    return CGSize(width: UIView.noIntrinsicMetric, height: contentSize.height)
  }
}
