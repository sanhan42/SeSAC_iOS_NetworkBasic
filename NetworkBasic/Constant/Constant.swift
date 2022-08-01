//
//  Constant.swift
//  NetworkBasic
//
//  Created by 한상민 on 2022/08/01.
//

import Foundation

//enum StoryboardName: String {
//    case Main
//    case Search
//    case Setting
//}

//struct StoryboardName {
//    private init() { // 인스턴스 생성 방지 - 접근 제어를 통해 초기화 방지를 해줄 수 있다.
//    }
//    static let main = "Main"
//    static let search = "Search"
//    static let setting = "Setting"
//}


/*
 1. struct type property vs enum type property => 인스턴스 생성 방지
 2. enum case vs enum static =>
 Raw value for enum case is unique. 중복 불가능.
 (raw value에 사용될 수 있는 값에 제약이 있다.)
 */
enum StoryboardName {
    static let main = "Main"
    static let search = "Search"
    static let setting = "Setting"
}

//enum FontName: String {
//    case title = "SanFransisco"
//    case body = "SanFransisco"    // 중복 불가
//    case caption = "AppleSandol"
//}
