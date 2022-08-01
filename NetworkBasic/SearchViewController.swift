//
//  SearchViewController.swift
//  NetworkBasic
//
//  Created by 한상민 on 2022/07/27.
//

import UIKit

/*
 Swift Protocol
 - Delegate
 - Datasource
 
 1. 왼팔/오른팔 가져오기
 2. 테이블뷰 아웃렛 연결
 3. 1번과 2번 연결고리 작업
 */
class SearchViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    func configureView() {
        searchTableView.backgroundColor = .clear
        searchTableView.separatorColor = . clear
//        search
    }
    func configureLabel() {
    }
    
    @IBOutlet weak var searchTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTableView.backgroundColor = .clear
        // 연결고리 작업 : 테이블뷰가 해야 할 역할을 > 뷰 컨트롤러에게 요청 (cf.여기서 self는 클래스의 인스턴스 자체를 가르킴) - Delegate 패턴
        searchTableView.delegate = self
        searchTableView.dataSource = self
        // 테이블뷰가 사용할 테이블뷰 셀(XIB) 등록
        // (XIB: Xml Interface Builder <= NIB)
        searchTableView.register(UINib(nibName: "ListTableViewCell", bundle: nil), forCellReuseIdentifier: ListTableViewCell.reuseIdentifier)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.reuseIdentifier, for: indexPath) as? ListTableViewCell else {
            return UITableViewCell()
        }
        cell.backgroundColor = .clear
        cell.titleLabel.font = .boldSystemFont(ofSize: 22)
        cell.titleLabel.text = "HELLO"
        return cell
    }
    
}
