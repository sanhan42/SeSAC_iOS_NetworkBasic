//
//  SearchViewController.swift
//  NetworkBasic
//
//  Created by 한상민 on 2022/07/27.
//

import UIKit

import Alamofire
import SwiftyJSON
import JGProgressHUD
/*
 Swift Protocol
 - Delegate
 - Datasource
 
 1. 왼팔/오른팔 가져오기
 2. 테이블뷰 아웃렛 연결
 3. 1번과 2번 연결고리 작업
 */
class SearchViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchTableView: UITableView!
    
    var list: [BoxOfficeModel] = []
    var yesterday: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd" // y와 Y의 차이
        formatter.locale = Locale(identifier: "ko")
        formatter.timeZone = TimeZone(identifier: "Asia/Seoul")
        //return formatter.string(from: Date().addingTimeInterval(-86400))
        return formatter.string(from: Calendar.current.date(byAdding: .day, value: -1, to: Date())!)
    }
    // ProgressView
    let hud = JGProgressHUD()
    
    func configureView() {
        searchTableView.backgroundColor = .clear
        searchTableView.separatorColor = . clear
//        search
    }
    func configureLabel() {
    }
    
    func requestBoxOffice(text: String) {
        /* 각 json value -> list -> tabelView */
        
        hud.show(in: view)
        
        // 배열 초기화
        self.list.removeAll()
        
        let url = "\(EndPoint.boxOfficeURL)key=\(APIKey.BOXOFFICE)&targetDt=\(text)"
        AF.request(url, method: .get).validate(statusCode: 200..<300).responseData { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print(json)
                
                // 배열에 데이터 추가
                /*for i in 0...9 {
                    self.list.append(json["boxOfficeResult"]["dailyBoxOfficeList"][i]["movieNm"].stringValue)
                } */
                for movie in json["boxOfficeResult"]["dailyBoxOfficeList"].arrayValue {
                    let data = BoxOfficeModel(movieTitle: movie["movieNm"].stringValue, releaseDate:  movie["openDt"].stringValue, totalCount: movie["audiAcc"].stringValue)
                    self.list.append(data)
                }
                
                // 테이블뷰 갱신
                self.searchTableView.reloadData()
                self.hud.dismiss(animated: true)
                print(self.list)
                
            case .failure(let error):
                print(error)
                self.hud.dismiss()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTableView.backgroundColor = .clear
        // 연결고리 작업 : 테이블뷰가 해야 할 역할을 > 뷰 컨트롤러에게 요청 (cf.여기서 self는 클래스의 인스턴스 자체를 가르킴) - Delegate 패턴
        searchTableView.delegate = self
        searchTableView.dataSource = self
        // 테이블뷰가 사용할 테이블뷰 셀(XIB) 등록
        // (XIB: Xml Interface Builder <= NIB)
        searchTableView.register(UINib(nibName: "ListTableViewCell", bundle: nil), forCellReuseIdentifier: ListTableViewCell.reuseIdentifier)
        
        searchBar.delegate = self
        requestBoxOffice(text: yesterday)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.reuseIdentifier, for: indexPath) as? ListTableViewCell else {
            return UITableViewCell()
        }
        cell.backgroundColor = .clear
        cell.titleLabel.font = .boldSystemFont(ofSize: 22)
        cell.titleLabel.text = "\(list[indexPath.row].movieTitle) : \(list[indexPath.row].releaseDate)"
        
        return cell
    }
    
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        requestBoxOffice(text: searchBar.text!) // 추후에 옵셔널 바인딩, 8글자, 숫자, 날짜로 변경 시 유효한 형태의 값인지 확인 등의 처리를 해줘야 함.
    }
}
