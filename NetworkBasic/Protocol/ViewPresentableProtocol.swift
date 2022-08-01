//
//  ViewPresentableProtocol.swift
//  NetworkBasic
//
//  Created by 한상민 on 2022/07/28.
//

import Foundation
import UIKit

// 프로토콜은 규약이자 필요한 요소를 명세만 할 뿐, 실질적인 구현부는 작성하지 않는다!
// 실질적인 구현은 프로토콜을 채택, 준수한 타입이 구현한다.
// 클래스, 구조체, 익스텐션, 열거형 ... 다양한 곳에서 사용할 수 있다.
// 클래스는 단일 상속만 가능하지만, 프로토콜은 채택 갯수에 제한이 없다.
// @objc optional > 선택적 요청 (Optional Requirement)
// 프로토콜 프로퍼티, 프롵토콜 메서드

// 프로토콜 프로퍼티: 프로토콜을 채택한 곳에서, 연산 프로퍼티로 쓰든, 저장 프로퍼티로 쓰든 상관없다.
// 무조건 var로 선언해야 한다.
// {get} {get set} => 이 부분은 최소 구현 사항을 명시해 놓은 것이다.
// {get} => 만약 get만 명시했다면, get 기능만 최소한 구현되어 있으면 된다! 필요하다면 set도 구현해도 된다.
@objc protocol ViewPresentableProtocol {
    var navigationTitleString:String {get set}
    @objc optional var backgroundColor:UIColor{get}
    static var identifier:String {get}
    
    func configureView()
    @objc optional func configureLabel()
    @objc optional func didSelectRowAt()
}

/*
 ex. 테이블뷰
 */

protocol SanhanTableViewProtocol {
    func nuberOfRowsInSection() -> Int
    func cellForRowAt(indexPath: IndexPath) -> UITableViewCell
}
