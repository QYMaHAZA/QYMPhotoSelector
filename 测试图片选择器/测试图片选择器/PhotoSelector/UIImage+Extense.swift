//
//  UIImage+Extense.swift
//  测试图片选择器
//
//  Created by mqy on 15/8/8.
//  Copyright © 2015年 qyma. All rights reserved.
//

import UIKit

extension UIImage{
    
    func scaleImage(width :CGFloat)->UIImage{
        
        //本身大小小于width
        if size.width < width{
            return self
        }
        //获取对应的比例 高度
        let height = size.height * width / size.width
        let s = CGSize(width: width, height: height)
        
        //开启图片上下文
        UIGraphicsBeginImageContext(s)
        
        //绘制图形
        drawInRect(CGRect(origin: CGPointZero, size: s))
        //获取图形
        let result = UIGraphicsGetImageFromCurrentImageContext()
        //关闭图形上下文
        UIGraphicsEndImageContext()
        return result
    }
}
