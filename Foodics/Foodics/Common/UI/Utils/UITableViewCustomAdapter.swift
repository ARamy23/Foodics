//
//  UITableViewCustomAdapter.swift
//  Foodics
//
//  Created by Ahmed Ramy on 11/16/20.
//  Copyright © 2020 Ahmed Ramy. All rights reserved.
//

import Carbon

public final class UITableViewCustomAdapter: UITableViewAdapter {
  weak var parentViewController: UIViewController?
  
  public var isDeleteEnabled: Bool = false
  public var isEditEnabled: Bool = false
  public var deleteIcon: UIImage?
  public var removeItemPreHandler: ((CellNode) -> Bool)?
  public var removeItemHandler: Callback<IndexPath>?
  public var didScrollHandler: Callback<UIScrollView>?
  public var didEndScrollingAnimationHandler: Callback<UIScrollView>?
  public var editItemPreHandler: ((CellNode) -> Bool)?

  public override func tableView(
    _ tableView: UITableView,
    willDisplay cell: UITableViewCell,
    forRowAt indexPath: IndexPath
  ) {
    super.tableView(tableView, willDisplay: cell, forRowAt: indexPath)

    if let cell = cell as? UITableViewComponentCell, let content = cell.renderedContent as? UIViewController {
      parentViewController?.addChild(content)
      content.didMove(toParent: parentViewController)
    }
  }
    
  public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = super.tableView(tableView, cellForRowAt: indexPath)
    cell.layer.anchorPointZ = CGFloat(indexPath.row)
    if isEditEnabled {
      cell.selectionStyle = .default
    } else {
      cell.selectionStyle = .none
    }
    return cell
  }

  public override func tableView(
    _ tableView: UITableView,
    didEndDisplaying cell: UITableViewCell,
    forRowAt indexPath: IndexPath
  ) {
    super.tableView(tableView, didEndDisplaying: cell, forRowAt: indexPath)

    if let cell = cell as? UITableViewComponentCell, let content = cell.renderedContent as? UIViewController {
      content.willMove(toParent: nil)
      content.removeFromParent()
    }
  }

  public func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
    guard isDeleteEnabled else { return nil }

    if let value = removeItemPreHandler?(cellNode(at: indexPath)), !value { return nil }

    let deleteAction = UIContextualAction(style: .destructive, title: nil) { [weak self] (_, _, completionHandler) in
        self?.removeItemHandler?(indexPath)
        completionHandler(true)
    }
    
    deleteAction.title = "Remove".localized()
    
    if let deleteIcon = deleteIcon {
      deleteAction.image = deleteIcon
    }
    
    deleteAction.backgroundColor = R.color.destructionButtonsColor()
    let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
    
    return configuration
  }

  public func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    return checkInteraction(for: indexPath)
  }

  public func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
    return checkInteraction(for: indexPath) ? indexPath : nil
  }
  
  public func scrollViewDidScroll(_ scrollView: UIScrollView) {
    didScrollHandler?(scrollView)
  }

  public func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
    didEndScrollingAnimationHandler?(scrollView)
  }
}

private extension UITableViewCustomAdapter {

  func checkInteraction(for indexPath: IndexPath) -> Bool {
    guard isEditEnabled || isDeleteEnabled else { return true }

    if isEditEnabled, let canEdit = editItemPreHandler?(cellNode(at: indexPath)), canEdit {
      return true
    } else if isDeleteEnabled, let canDelete = removeItemPreHandler?(cellNode(at: indexPath)), canDelete {
      return true
    }
    return false
  }
}
