//
//  LocationViewController.swift
//  NetworkBasic
//
//  Created by 한상민 on 2022/07/29.
//

import UIKit

class LocationViewController: UIViewController {
    // Notification 1.
    // UN은 User Notification의 줄임말.
    let notificationCenter = UNUserNotificationCenter.current()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        requestAuthorization()
//        for family in UIFont.familyNames {
//            print("===========\(family)===========")
//            for name in UIFont.fontNames(forFamilyName: family) {
//                print(name)
//            }
//        }
    }
    
    @IBAction func notificationButtonClicked(_ sender: UIButton) {
        sendNotification()
    }
    
    // Notification 2. 권한 요청
    func requestAuthorization() {
        let authorizationOptions = UNAuthorizationOptions(arrayLiteral: .alert, .badge, .sound)
        notificationCenter.requestAuthorization(options: authorizationOptions) { success, error in
            if success {
                self.sendNotification()
            }
        }
    }
    
    // Notification 3. 권한 허용한 사용자에게 알림 요청 (언제? 어떤 컨텐츠로?)
    // iOS 시스템에서 알림을 담당 > 알림 등록을 해줘야 한다.
    func sendNotification() {
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = "다마고치를 키워보세요"
        notificationContent.subtitle = "오늘 행운의 숫자는 \(Int.random(in: 1...100))입니다."
        notificationContent.body = "저는 따끔따끔 다마고이입니다. 배고파요."
        notificationContent.badge = 40
        
        // 언제 보낼 것인가? 1) 시간 간격 2) 캘린더 3) 위치에 따라 설정 가능.
        // 시간 간격일 떄는 60초 이상 설정해야 반복 가능
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
//
//        var dataComponents = DateComponents()
//        dataComponents.minute = 15
//        let trigger = UNCalendarNotificationTrigger(dateMatching: dataComponents, repeats: true)
        
        // 알림 요청
        // identifier:
        // 동일하게 유지된다면 알림이 쌓이지 않음.
        // 만약 알림 관리를 할 필요가 없는 경우, (보통 알림 클릭하면 앱을 켜주는 정도) -> ex. Date()
        // 만약 알림 관리를 할 필요가 있는 경우, -> +1, 고유 이름, 규칙 등을 이용해서 설정.
        let request = UNNotificationRequest(identifier: "sanhan", content: notificationContent, trigger: trigger)
        notificationCenter.add(request)
    }
    
    /* Notification
     - 권한 허용해야만 알림이 온다.
     - 권한 허용 문구 시스템적으로 최초 한 번만 뜬다.
     - 허용 안 된 경우, 애플 설정으로 직접 유도하는 코드를 구성해야 한다.
     - 기본적으로 알림은 포그라운드에서 수신되지 않는다.
     - 로컬 알림에서는 60초 이상부터 반복 가능하다. / 갯수 제한은 64개 ( 갯수 제한의 세부 사항은 찾아봐야..) / 커스텀 사운드 사용 가능 (30초 제한이..?)
     
     * 뱃지 제거 > 언제 제거해주는게 맞은까? SceneDelegate에서 적절히 조절해줘야한다. 보통 sceneDidBecomeActive
     * 노티 제거 > 노티의 유효 기간은 별도의 설정을 하지 않으면 보통 한달 정도인거 같다. : 카톡 vs 잔디 > 언제 지우는 것이 맞을까?
     * 포그라운드 수신 > AppDelegate에서 설정. 딜리게이트 메서드로 해결!
     
     +⍺
     - 노티는 앱 실행이 기본인데, 특정 노티를 클릭할 때 특정 화면으로 가고 싶다면?
     - 포그라운드 수신, 특정 화면에서는 안받고 특정 조건에 대해서만 포그라운드 수신을 하고 싶다면?
     - iOS 15에 집중모드 등이 생기면서, 알림에 5~6개 우선 순위가 생겼다.
     */
}
