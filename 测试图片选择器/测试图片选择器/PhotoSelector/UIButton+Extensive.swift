
//
//  UIButton+Extensive.swift
//  测试图片选择器
//
//  Created by mqy on 15/8/8.
//  Copyright © 2015年 qyma. All rights reserved.
//

import UIKit

extension UIButton{
    
    convenience init(imageName:String){
        
        self.init()
      setImage(UIImage(named: imageName), forState: UIControlState.Normal)
    setImage(UIImage(named: imageName + "_highlighted"), forState: UIControlState.Highlighted)
    }
}
