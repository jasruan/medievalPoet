//
//  MyAppData.swift
//  Magneto1
//
//  Created by Johnny Siu & Jasmine Ruan (RIT Student) on 3/21/17.
//  Copyright © 2017 igmstu. All rights reserved.
//

import Foundation
import UIKit
class MyAppData{
    //MARK: -singleton-
    static let shared = MyAppData()
    //MARK: -constants-
    let categoryKey = "categoryKey"
    let imageKey = "imageKey"
    //MARK: -ivar / initialization-
    var category = ""
    {
        didSet
        {
            let defaults = UserDefaults.standard
            defaults.set(category, forKey: categoryKey)
        }
    }
    var img = UIImage()
        {
        //grab the image data 
        didSet{
            let data = UIImagePNGRepresentation(img)
            let defaults = UserDefaults.standard
            defaults.set(data, forKey: imageKey)
        }
    }
    
    private init()
    {
        readDefaultsData()
    }
    //MARK: -private helper methods-
    private func readDefaultsData()
    {
        //grab the User defaults
        let defaults = UserDefaults.standard
        //check to see if the user default has a saved value for category, if not, make it one
        if let s = defaults.object(forKey: categoryKey)
        {
            //if their is something there, make it the category
            category = s as! String
        }
        else
        {
            category = "welcome"
        }
        //converts image data to image if it has saved an image
            if let imgData = defaults.object(forKey: imageKey){
            img = UIImage(data:imgData as! Data)!
        }
            else {
                img = UIImage(named:"defaultBG.png")!
        }
    }
    
}
