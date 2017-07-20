//
//  Video.swift
//  YouTube
//
//  Created by iDev on 20/07/17.
//  Copyright © 2017 iDev. All rights reserved.
//

import UIKit

class Video: NSObject {
    
    var thumbnailImageName:String?
    var title:String?
    var numberOfViews: NSNumber?
    var uploadDate: NSDate?
    
    var channel: Channel?

}

class Channel: NSObject {
    var name:String?
    var profileImageName:String?
}
