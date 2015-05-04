//
//  InterfaceController.swift
//  WatchWeather WatchKit Extension
//
//  Created by ZLMac on 15-4-28.
//  Copyright (c) 2015年 lgwh. All rights reserved.
//

import WatchKit
import Foundation

struct CityAQI {
    var city:String
    var aqi:Int
    var level:String
}

func warningInfo(aqi:Int)->(bgcolor:UIColor,fgcolor:UIColor,suggestion:String){
    switch aqi {
    case 0...50:
        return(UIColor.greenColor(),UIColor.lightGrayColor(),"清新世界太美!")
    case 51...100:
        return(UIColor.yellowColor(),UIColor.lightGrayColor(),"平淡日子静静!")
    case 101...150:
        return(UIColor.orangeColor(),UIColor.whiteColor(),"愁云惨雾万里凝!")
    case 151...200:
        return(UIColor.redColor(),UIColor.whiteColor(),"雾霾来袭兵临城!")
    case 201...300:
        return(UIColor.purpleColor(),UIColor.whiteColor(),"魔王压境无天日!")
    case 301...999:
        return(UIColor.brownColor(),UIColor.whiteColor(),"天诛地灭人绝迹!")
    default:
        return (UIColor.blackColor(),UIColor.whiteColor(),"")
    }
}
class InterfaceController: WKInterfaceController {

    @IBOutlet weak var labelBJ: WKInterfaceLabel!
    @IBOutlet weak var labelWH: WKInterfaceLabel!
    @IBOutlet weak var labelSZ: WKInterfaceLabel!
    @IBOutlet weak var labelCS: WKInterfaceLabel!
    
    @IBOutlet weak var labelAQIBJ: WKInterfaceLabel!
    @IBOutlet weak var labelAQIWH: WKInterfaceLabel!
    @IBOutlet weak var labelAQISZ: WKInterfaceLabel!
    @IBOutlet weak var labelAQICS: WKInterfaceLabel!
    
    
    @IBOutlet weak var labelLevelBJ: WKInterfaceLabel!
    @IBOutlet weak var labelLevelWH: WKInterfaceLabel!
    @IBOutlet weak var labelLevelSZ: WKInterfaceLabel!
    @IBOutlet weak var labelLevelCS: WKInterfaceLabel!
    
    @IBOutlet weak var labelsgBJ: WKInterfaceLabel!
    @IBOutlet weak var labelsgWH: WKInterfaceLabel!
    @IBOutlet weak var labelsgSZ: WKInterfaceLabel!
    @IBOutlet weak var labelsgCS: WKInterfaceLabel!
    
    @IBOutlet weak var gpBJ: WKInterfaceGroup!
    @IBOutlet weak var gpWH: WKInterfaceGroup!
    @IBOutlet weak var gpSZ: WKInterfaceGroup!
    @IBOutlet weak var gpCS: WKInterfaceGroup!
    func getAQI(city:String,completion:(CityAQI?)->()){
        let baseURL = "http://apistore.baidu.com/microservice/aqi?city="
        let session = NSURLSession.sharedSession()
        let requestURL = (baseURL + city).stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)
        let task = session.dataTaskWithURL(NSURL(string: requestURL!)!) { (data, _, error) -> Void in
            if error == nil {
               if let json = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments, error:nil) as? NSDictionary
               {
                  if let retData = json["retData"] as? NSDictionary
                    
                  {
                     let aqi = retData["aqi"] as? Int
                     let level = retData["level"] as?String
                    let cityAQI = CityAQI(city: city, aqi: aqi!, level: level!)
                    completion(cityAQI)
                    
                  }
               }
               
            }
        }
        task.resume()
    }
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
    }

    override func willActivate() {
       
        super.willActivate()
        
        if let bj = labelAQIBJ {
            if let levelbj = labelLevelBJ{
            getAQI("北京", completion: { (ca:CityAQI?) -> () in
                
                if let ca = ca {
                    bj.setText(ca.aqi.description)
                    bj.setTextColor(warningInfo(ca.aqi).fgcolor)

                    levelbj.setText(ca.level)
                    levelbj.setTextColor(warningInfo(ca.aqi).fgcolor)
                    self.gpBJ.setBackgroundColor(warningInfo(ca.aqi).bgcolor)
                    self.labelsgBJ.setText(warningInfo(ca.aqi).suggestion)
                }else {
                    println("没有获取到数据!")
                }
            })
            }
        }
        if let wh = labelAQIWH {
            if let levelwh = labelLevelWH{
                getAQI("武汉", completion: { (ca:CityAQI?) -> () in
                    
                    if let ca = ca {
                        wh.setText(ca.aqi.description)
                        wh.setTextColor(warningInfo(ca.aqi).fgcolor)
                    
                        levelwh.setText(ca.level)
                        levelwh.setTextColor(warningInfo(ca.aqi).fgcolor)
                        self.gpWH.setBackgroundColor(warningInfo(ca.aqi).bgcolor)
                        self.labelsgWH.setText(warningInfo(ca.aqi).suggestion)
                    }else {
                        println("没有获取到数据!")
                    }
                })
            }
        }
        if let sz = labelAQISZ {
            if let levelsz = labelLevelSZ{
                getAQI("上海", completion: { (ca:CityAQI?) -> () in
                    
                    if let ca = ca {
                        sz.setText(ca.aqi.description)
                        sz.setTextColor(warningInfo(ca.aqi).fgcolor)
                        
                        levelsz.setText(ca.level)
                        levelsz.setTextColor(warningInfo(ca.aqi).fgcolor)
                        self.gpSZ.setBackgroundColor(warningInfo(ca.aqi).bgcolor)
                        self.labelsgSZ.setText(warningInfo(ca.aqi).suggestion)
                    }else {
                        println("没有获取到数据!")
                    }
                })
            }
        }

        if let cs = labelAQICS {
            if let levelcs = labelLevelCS{
                getAQI("长沙", completion: { (ca:CityAQI?) -> () in
                    
                    if let ca = ca {
                        cs.setText(ca.aqi.description)
                        cs.setTextColor(warningInfo(ca.aqi).fgcolor)
                        
                        levelcs.setText(ca.level)
                        levelcs.setTextColor(warningInfo(ca.aqi).fgcolor)
                        self.gpCS.setBackgroundColor(warningInfo(ca.aqi).bgcolor)
                        self.labelsgCS.setText(warningInfo(ca.aqi).suggestion)
                    }else {
                        println("没有获取到数据!")
                    }
                })
            }
        }

        
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
