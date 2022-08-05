//
//  ImageSearchViewController.swift
//  NetworkBasic
//
//  Created by 한상민 on 2022/08/03.
//

import UIKit

import Alamofire
import SwiftyJSON

class ImageSearchViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    @IBOutlet weak var imageCollectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var list: [String] = []
    
    // 네트워크 요청할 시작 페이지 넘버
    var startPage = 1
    var totalCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageCollectionView.delegate = self
        imageCollectionView.dataSource = self
        imageCollectionView.prefetchDataSource = self // 페이지네이션
        searchBar.delegate = self
        setCollectionViewLayout()
        // Do any additional setup after loading the view.
    }
    
    // fetchImage, requestImage, callImage, getImage... => respense에 따라 네이밍을 설정하는 편
    func fetchImage(query: String) {
        ImageSearchAPIManager.shared.fetchImageData(query: query, startPage: startPage) { totalCount, list in
            self.totalCount = totalCount
            self.list.append(contentsOf: list)
            DispatchQueue.main.async {
                self.imageCollectionView.reloadData()
            }
        }
        /* ImageSearchAPIManager 파일을 만들어 나눔*/
//        let text = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
//        let url = EndPoint.imageSearchURL + "query=\(text)&display=30&start=\(startPage)&sort=sim"
//        let header: HTTPHeaders = ["X-Naver-Client-Id":APIKey.NAVER_ID, "X-Naver-Client-Secret":APIKey.NAVER_SECRET]
//        AF.request(url, method: .get, headers: header).validate(statusCode: 200...300).responseData { response in
//            switch response.result {
//            case .success(let value):
//                let json = JSON(value)
//                self.totalCount = json["total"].intValue
////                for item in json["items"].arrayValue {
////                    guard let url = URL(string: item["link"].stringValue) else { return }
////                    self.list.append(url)
////                }
//                let newResult = json["items"].arrayValue.map{$0["link"].stringValue}
//                self.list.append(contentsOf: newResult)
//                // 서버통신 받는 시점에서 URL, UIImage 변환을 할 건지 => 서버 통신 시간 오래 걸림.
//                // 셀에서 URL, UIImage 변환을 할 건지 => 이 방식이 일반적이다. 서버 통신을 최대한 빠르게 마무리하고, 데이터 변환 작업은 다른 곳에서 처리.
//            case .failure(let error):
//                print(error)
//            }
//            self.imageCollectionView.reloadData() // 까먹지 말자!!
//        }
    }
   
    func setCollectionViewLayout() {
        let layout = UICollectionViewFlowLayout()
        let spacing:CGFloat = 8
        let width = (UIScreen.main.bounds.width - spacing*4) / 3
        layout.itemSize = CGSize(width: width, height: width * 1.2)
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        imageCollectionView.collectionViewLayout = layout
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier:ImageSearchCollectionViewCell.reuseIdentifier, for: indexPath) as? ImageSearchCollectionViewCell else {
            return UICollectionViewCell()
        }
        guard let url = URL(string: self.list[indexPath.row]) else { return cell }
        cell.resultImageView.load(url: url)
        return cell
    }
    
    /*
    // 페이지네이션 방법1. 컬렉션뷰가 특정 셀을 그리려는 시점에 호출되는 메서드.
    // 마지막 셀에 사용자가 위치해있는지 명확하게 확인하기가 어려움.
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        <#code#>
    }
    
    // 페이지네이션 방법2. UIScrollViewDelegateProtocol.
    // 테이블뷰|컬렉션뷰는 스크롤뷰를 상속받고 있어서, 스크롤뷰 프로토콜을 사용할 수 있음.
    // 스크롤할 때마다 호출되는 메서드.
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print(scrollView.contentOffset)
    }
    */
}

// 페이지네이션 방법3.
// 용량이 큰 이미지를 다운받아 셀에 보여주려고 하는 경우에 효과적.
// 셀이 화면에 보이기 전에 미리 필요한 리소스를 다운받을 수도 있고, 필요하지 않다면 데이터를 취소할 수도 있음.
// iOS10 이상 부터 사용 가능, 스크롤 성능 향상에 도움된다고 한다.
extension ImageSearchViewController: UICollectionViewDataSourcePrefetching {
    // 셀이 화면에 보이기 직전에 필요한 리소스를 미리 다운 받는 기능
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
//        print("=========\(indexPaths)")
        for indexPath in indexPaths {
            if list.count - 1 == indexPath.item && list.count < totalCount {
                startPage += 30
                fetchImage(query: searchBar.text!)
            }
        }
    }
    
    // 주로 작업을 취소할 때 사용. (직접 취소하는 기능을 구현해주어야 한다.)
    func collectionView(_ collectionView: UICollectionView, cancelPrefetchingForItemsAt indexPaths: [IndexPath]) {
//        print("!!!!취소!!!!!\(indexPaths)")
    }
}

extension ImageSearchViewController: UISearchBarDelegate {
    // 검색 버튼 클릭 시 실행. (return키 누름)
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let word = searchBar.text else { return }
            list.removeAll()
            startPage = 1
            fetchImage(query: word)
            if imageCollectionView.numberOfItems(inSection: 0) != 0  {
                imageCollectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
                imageCollectionView.reloadData()
            }
    }
    
    // 취소 버튼 눌렀을 때, searchBar의 Text Editing을 끝냄
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
//        searchBar.endEditing(true)
        list.removeAll()
        searchBar.text = ""
        imageCollectionView.reloadData()
        searchBar.setShowsCancelButton(false, animated: true)
    }
    
//    // Text Editing이 끝날 때 실행 (서치바에 커서가 사라질 때)
//    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
//
//    }
    
    // 서치바에 커서가 깜박이기 시작할 때 실행
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }
}

