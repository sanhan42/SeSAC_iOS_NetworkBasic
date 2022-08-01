//
//  ViewController.swift
//  NetworkBasic
//
//  Created by 한상민 on 2022/07/27.
//

import UIKit

class ViewController: UIViewController { //ViewPresentableProtocol, UITableViewDelegate, UITableViewDataSource
    static let identifier: String = "ViewController" // 프로토콜에서 요구 사항으로 set이 설정 안되어있음. 그래서 상수로 사용할 수 있는 것.
    var navigationTitleString: String = "대장님의 다마고치"
    
    var backgroundColor: UIColor = .blue
    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//    }
    
    func configureView() {
//        navigationTitleString = "고래밥님의 다마고치"
        backgroundColor = .systemRed
        title = navigationTitleString
        view.backgroundColor = backgroundColor
    }
    
//    func configureLabel() {
//    }
//

    override func viewDidLoad() {
        super.viewDidLoad()
        
            UserDefaultsHelper.standard.nickname = "고래밥"
        title = UserDefaultsHelper.standard.nickname
        UserDefaultsHelper.standard.age = 80
        print(UserDefaultsHelper.standard.age)
        // Do any additional setup after loading the view.
    }


}

