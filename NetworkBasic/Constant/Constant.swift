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

struct APIKey {
    static let BOXOFFICE = "c2ad5bc0821ed8971e020de1fe4c2f97"
    static let NAVER_ID = "Yg1JQP1nZ9jO3ff987Ck"
    static let NAVER_SECRET = "d2Pcl3nXWP"
}

struct EndPoint {
    static let boxOfficeURL = "https://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?"
    static let lottoURL = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber"
    static let translateURL = "https://openapi.naver.com/v1/papago/n2mt"
}

//enum FontName: String {
//    case title = "SanFransisco"
//    case body = "SanFransisco"    // 중복 불가
//    case caption = "AppleSandol"
//}
