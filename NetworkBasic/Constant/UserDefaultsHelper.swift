//
//  UserDefaultsHelper.swift
//  NetworkBasic
//
//  Created by 한상민 on 2022/08/01.
//

import Foundation

class UserDefaultsHelper {
    private init() {} // 다른 곳에서 인스턴스 생성을 못하게 막아주기 위함.
    
    // 자기 자신의 인스턴스를 타입 프로퍼티 형태로 가지고 있음. // 동기화를 위해 많이 사용됨.
    static let standard = UserDefaultsHelper() // singleton 패턴
    // 보통 shared || standard || default 이름으로 많이 사용됨.
    /*싱글톤 객체 자체는 static이지만, 객체 안의 저장 프로퍼티들은 싱글톤 객체를 쓸 때만 메모리에 올라온다는 말씀이시죠? 프로퍼티들이 연산 프로퍼티로 구성되어있어서 그런건가..?*/
    
    
    let userDefaults = UserDefaults.standard
    enum Key: String {
        case nickname, age
    }
    
    var nickname: String {
        get {
            return userDefaults.string(forKey: Key.nickname.rawValue) ?? "대장"
        }
        set {
            userDefaults.set(newValue, forKey: Key.nickname.rawValue)
        }
    }
    
    var age: Int {
        get {
            return userDefaults.integer(forKey: Key.nickname.rawValue)
        }
        set {
            userDefaults.set(newValue, forKey: Key.nickname.rawValue)
        }
    }
}
