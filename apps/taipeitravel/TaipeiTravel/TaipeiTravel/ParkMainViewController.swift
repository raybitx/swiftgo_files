//
//  ParkMainViewController.swift
//  TaipeiTravel
//
//  Created by joe feng on 2016/6/6.
//  Copyright © 2016年 hsin. All rights reserved.
//

import UIKit
import CoreLocation

class ParkMainViewController: BaseMainViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 導覽列標題
        self.title = "公園"
        
        // 獲取類型
        self.fetchType = "park"
        
        // 台北景點資料 ID
        self.strTargetID = "8f6fcb24-290b-461d-9d34-72ed1b3f51f0"
        
        self.targetUrl = self.documentsPath + self.fetchType + ".json"
        
        // 取得 API 資料
        self.addData()
    }
    
    override func goDetail(index: Int) {
        let thisData = self.apiData[self.apiDataForDistance[index].index]
        let title = thisData["ParkName"] as? String ?? ""
        let intro = thisData["Introduction"] as? String ?? ""
        var area = thisData["Area"] as? String ?? "無面積資訊"
        
        if area != "無面積資訊" {
            area = "面積： " + area + " 平方公尺"
        }
        
        let type = thisData["ParkType"] as? String ?? ""
        let location = thisData["Location"] as? String ?? "無地址資訊"
        
        var latitude = 0.0
        if let num = thisData["Latitude"] as? NSString {
            latitude = num.doubleValue
        }
        
        var longitude = 0.0
        if let num = thisData["Longitude"] as? NSString {
            longitude = num.doubleValue
        }
        
        let info :[String:AnyObject] = [
            "title" : title,
            "intro" : intro,
            "type" : type,
            "location" : location,
            "area" : area,
            "latitude" : latitude,
            "longitude" : longitude,
        ]
        
        
        self.myUserDefaults.setObject(info, forKey: "\(self.fetchType)Detail")
        self.myUserDefaults.synchronize()
        
        print(info["title"] as? String ?? "NO Title")
        
        self.navigationController?.pushViewController(ParkDetailViewController(), animated: true)
        
    }
}
