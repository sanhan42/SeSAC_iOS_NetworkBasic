//
//  ImageSearchAPIManager.swift
//  NetworkBasic
//
//  Created by 한상민 on 2022/08/05.
//

import Foundation
import Alamofire
import SwiftyJSON

// 싱글턴 패턴은 클래스로 사용한다. 왜 구조체로 사용하는 것이 안 좋을까?
class ImageSearchAPIManager {
    static let shared = ImageSearchAPIManager()
    private init() {}
    
    typealias completionHandler = (Int, [String]) -> Void
    
    // non-escaping이 디폴트 => @escaping
    func fetchImageData(query:String, startPage: Int, completionHandler: @escaping completionHandler) {
        //        self.list.removeAll()
        let text = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let url = EndPoint.imageSearchURL + "query=\(text)&display=30&start=\(startPage)&sort=sim"
        let header: HTTPHeaders = ["X-Naver-Client-Id":APIKey.NAVER_ID, "X-Naver-Client-Secret":APIKey.NAVER_SECRET]
        AF.request(url, method: .get, headers: header).validate(statusCode: 200...300).responseData(queue: .global()) { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let totalCount = json["total"].intValue
                let list = json["items"].arrayValue.map{$0["link"].stringValue}
                    completionHandler(totalCount, list)
            case .failure(let error):
                print(error)
            }
           
        }
    }
}
