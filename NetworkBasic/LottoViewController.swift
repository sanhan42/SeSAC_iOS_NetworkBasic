//
//  LottoViewController.swift
//  NetworkBasic
//
//  Created by 한상민 on 2022/07/28.
//

import UIKit
// 보통 외부 라이브러리는 한줄 띄우고 알파벳 순서로 임포트해준다.
import Alamofire
import SwiftyJSON

class LottoViewController: UIViewController {
    @IBOutlet weak var numberTextField: UITextField!
    @IBOutlet var lottoNumLabelList: [UILabel]!
    //    @IBOutlet weak var lottoPickerView: UIPickerView!
    var lottoPickerView = UIPickerView()
    
    let numberList: [Int] = Array(1...1025).reversed()
    override func viewDidLoad() {
        super.viewDidLoad()
        //numberTextField.textContentType = .oneTimeCode
        // 문자 메시지로 인증코드가 올 때, 인증코드를 자동으로 채워주기 - Automatic Strong Passwords and Security Code AutoFill
        numberTextField.tintColor = .clear
        numberTextField.inputView = lottoPickerView
        lottoPickerView.delegate = self
        lottoPickerView.dataSource = self
        for label in lottoNumLabelList {
            label.clipsToBounds = true
            label.layer.cornerRadius = label.frame.width/2
            label.textAlignment = .center
            label.textColor = .white
            label.font = .systemFont(ofSize: 17, weight: .heavy)
        }
        numberTextField.text = "1025회차"
        requestLotto(1025)
        // Do any additional setup after loading the view.
    }
    
    func requestLotto(_ number:Int) {
        let url = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=\(number)"
        // AF: 200 ~ 299 HTTP Status를 Default로 성공으로 간주. validate(statusCode: 200..<300)
        AF.request(url, method: .get).validate(statusCode: 200..<400).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                for (i, label) in self.lottoNumLabelList.enumerated() {
                    label.text = json["drwtNo\(i+1)"].stringValue
                    label.backgroundColor = UIColor(named: "Color\((json["drwtNo\(i+1)"].intValue-1)/10)")
                }
                self.lottoNumLabelList[6].text = json["bnusNo"].stringValue
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension LottoViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return numberList.count
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        numberTextField.text = "\(numberList[row])회차"
        requestLotto(numberList[row])
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(numberList[row])회차"
    }
    
}
