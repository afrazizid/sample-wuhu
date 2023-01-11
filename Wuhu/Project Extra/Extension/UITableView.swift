//
//  UITableView.swift
//  WATERCO
//
//  Created by afrazali on 12/12/2019.
//  Copyright © 2019 Afraz Ali. All rights reserved.
//

import Foundation
import UIKit

extension UITableView {
    func registerCells(_ cells: [UITableViewCell.Type]) {
        cells.forEach({ register(UINib(nibName: String(describing: $0), bundle: nil), forCellReuseIdentifier: String(describing: $0)) })
    }
    
    func registerHeaderFooter(_ headerFooter: [UITableViewHeaderFooterView.Type]) {
        headerFooter.forEach({ register(UINib(nibName: String(describing: $0), bundle: nil), forHeaderFooterViewReuseIdentifier: String(describing: $0)) })
    }
    
    func dequeueReusableCell<T: UITableViewCell>(with type: T.Type, for indexPath: IndexPath) -> T {
        let cell = dequeueReusableCell(withIdentifier: String(describing: type), for: indexPath) as! T
        return cell
    }
    
    func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>(with type: T.Type) -> T? {
        return dequeueReusableHeaderFooterView(withIdentifier: String(describing: type)) as? T
    }
    
    
    func scrollToBottom(){

        DispatchQueue.main.async {
            let indexPath = IndexPath(
                row: self.numberOfRows(inSection:  self.numberOfSections - 1) - 1,
                section: self.numberOfSections - 1)
            self.scrollToRow(at: indexPath, at: .bottom, animated: true)
        }
    }

    func scrollToTop() {

        DispatchQueue.main.async {
            let indexPath = IndexPath(row: 0, section: 0)
            self.scrollToRow(at: indexPath, at: .top, animated: false)
        }
    }
}

