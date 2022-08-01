//
//  ReuseableViewProtocol.swift
//  NetworkBasic
//
//  Created by 한상민 on 2022/08/01.
//

import UIKit

protocol ReuseableViewProtocol {
    static var reuseIdentifier: String {get}
}

extension UIViewController : ReuseableViewProtocol {
    // extension - 저장 프로퍼티 사용 불가능
    static var reuseIdentifier: String{
        return String(describing: self)
    }
}

extension UITableViewCell: ReuseableViewProtocol {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
