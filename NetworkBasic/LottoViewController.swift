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
    
    static var lastDrwNo:Int {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.locale = Locale(identifier: "ko")
        formatter.timeZone = TimeZone(identifier: "Asia/Seoul")
        // today의 날짜를 가져올 떄 시.분.초는 0으로 맞춰줌.
        let today = Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: Date())!
        let baseDay = formatter.date(from: "2022-07-23")! // 22.07.23은 1025회차
        let inter = today.timeIntervalSince(baseDay)
        return 1025+Int(floor(inter/86400/7)) // 86400으로 나눠줘서 기준 회차보다 며칠이 지난건지 계산하고, 그것을 다시 7로 나누어서, 몇주가 지난건지 계산..
    }
    
    let numberList: [Int] = Array(1...lastDrwNo).reversed()
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
        requestLotto(numberList[0])
        // Do any additional setup after loading the view.
    }
    
    func requestLotto(_ number:Int) {
        let url = "\(EndPoint.lottoURL)&drwNo=\(number)"
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
                self.lottoNumLabelList[6].backgroundColor = UIColor(named: "Color\((json["bnusNo"].intValue-1)/10)")
                self.numberTextField.text = json["drwNo"].stringValue + "회자"
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
//        numberTextField.text = "\(numberList[row])회차"
        requestLotto(numberList[row])
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(numberList[row])회차"
    }
    
}
