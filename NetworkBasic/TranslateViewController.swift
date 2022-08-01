//
//  TranslateViewController.swift
//  NetworkBasic
//
//  Created by 한상민 on 2022/07/28.
//

import UIKit

// UIButton, UITextField > Action 제공
// UITextView, UISearchBar, UIPickerView > Action 제공 X
// - UIControl을 상속받지 않기 떄문.

class TranslateViewController: UIViewController {
    @IBOutlet weak var userInputTextView: UITextView!
    let textViewPlaceholderText = "번역하고 싶은 문장을 작성해보세요."
    override func viewDidLoad() {
        super.viewDidLoad()
        userInputTextView.delegate = self
        
        userInputTextView.text = textViewPlaceholderText
        userInputTextView.textColor = .lightGray
        
        userInputTextView.font = UIFont(name: "S-CoreDream-9Black", size: 17)
        // Do any additional setup after loading the view.
    }
}

extension TranslateViewController:UITextViewDelegate {
    // 텍스트뷰의 텍스트가 변할 때마다 호출
    func textViewDidChange(_ textView: UITextView) {
        print(textView.text.count)
    }
    
    // 편집이 시작될 떄, 커서가 깜박이기 시작할 떄
    // 텍스트뷰 글자: 플레이스 홀더랑 글자가 같으면 clear & color 변경해주기
    func textViewDidBeginEditing(_ textView: UITextView) {
        print("Begin")
        if textView.textColor == .lightGray {
            textView.text = nil
            textView.textColor = .black
        }
        
    }
    
    // 편집이 끝났을 때, 커서가 없어지는 순간
    // 텍스트뷰 글자: 사용자가 아무 글자도 안 썼으면 플레이스 홀더 글자 보이게 하기
    func textViewDidEndEditing(_ textView: UITextView) {
        print("End")
        if textView.text.isEmpty {
            textView.textColor = .lightGray
            textView.text = textViewPlaceholderText
        }
    }
}
