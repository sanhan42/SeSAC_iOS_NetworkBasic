//
//  BeerViewController.swift
//  NetworkBasic
//
//  Created by 한상민 on 2022/08/01.
//

import UIKit

import Alamofire
import SwiftyJSON

class BeerViewController: UIViewController {
    @IBOutlet weak var beerImage: UIImageView!
    @IBOutlet weak var beerNameLabel: UILabel!
    @IBOutlet weak var beerDetailLabel: UILabel!
    @IBOutlet weak var changeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        beerNameLabel.font = .systemFont(ofSize: 20, weight: .bold)
        beerNameLabel.textAlignment = .center
        beerNameLabel.numberOfLines = 2
        beerDetailLabel.numberOfLines = 10
        beerDetailLabel.textAlignment = .center
        changeButton.layer.borderColor = UIColor(named: "Color0")?.cgColor
        changeButton.backgroundColor = UIColor(named: "Color0")
        changeButton.layer.cornerRadius = changeButton.frame.width/2
        changeButton.tintColor = .white
        requestBeer()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func changeButtonClicked(_ sender: UIButton) {
        requestBeer()
    }
    
    func requestBeer() {
        let url = "https://api.punkapi.com/v2/beers/random"
        AF.request(url, method: .get).validate().responseJSON {
            // Capture 'self' explicitly to enable implicit 'self' in this closure
            [self] response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)[0]
                beerNameLabel.text = json["name"].stringValue
                beerDetailLabel.text = json["description"].stringValue
                let tempStr = "http://health.chosun.com/site/data/img_dir/2015/08/11/2015081101302_0.jpg"
                guard let imageUrl = URL(string: json["image_url"].stringValue) else {
                    beerImage.load(url: URL(string: tempStr)!)
                    return
                }
                beerImage.load(url: imageUrl)
            case .failure(let error):
                print(error)
            }
        }
    }
}
