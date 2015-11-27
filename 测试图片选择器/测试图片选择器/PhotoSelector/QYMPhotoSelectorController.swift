//
//  QYMPhotoSelectorController.swift
//  测试图片选择器
//
//  Created by mqy on 15/8/7.
//  Copyright © 2015年 qyma. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"
private let kPhotoSelectorMaxCount = 5
class QYMPhotoSelectorController: UICollectionViewController,QYMPhotoselectedViewCellDelegate,UIActionSheetDelegate {

    //MARK：设定流式布局
    init(){
      super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.backgroundColor = UIColor.whiteColor()
        
        
        self.collectionView!.registerClass(QYMPhotoselectedViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)


    }

    ///MARK: UICollectionViewDataSource  数据源方法
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //保证末尾的按钮添加图片
        return (photos.count == kPhotoSelectorMaxCount) ? kPhotoSelectorMaxCount : photos.count + 1
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) ->
        UICollectionViewCell {
            
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! QYMPhotoselectedViewCell
        
        //设置代理
        cell.photoDelegate = self
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: 40 , height: 40 )
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        cell.backgroundColor = UIColor.orangeColor()
        
         //   设置cell显示的图片
        cell.image = (indexPath.item < photos.count) ? photos[indexPath.item] :nil

        
        return cell
    }
    //点击之后，显示照片选中器
    /// 从相册添加图片
    private var indexPathPicture :NSIndexPath  = NSIndexPath()
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        indexPathPicture = indexPath
        addPicture()
    }
    //从相册添加图片
    func addPicture(){
        //判断是否支持访问相册
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary){
            
            //创建图片选择器
            let imagePickerVc = UIImagePickerController()
            //设置代理
            imagePickerVc.delegate = self
            
            currentIndex = indexPathPicture.item
            
            //modal出图片选择控制器
            presentViewController(imagePickerVc, animated: true, completion: nil)
            
        }
 
    }
    
//    let actionSheet = UIActionSheet(title:"选择图片" as StringLiteralConvertible , delegate: self, cancelButtonTitle: "取消", destructiveButtonTitle: "从图片获取", otherButtonTitles: "拍照",nil)
//    
//    actionSheet.showInView(view)
    


func actionSheet(actionSheet: UIActionSheet, clickedButtonAtIndex buttonIndex: Int) {
    print(buttonIndex)
    if buttonIndex == 0{
        //从图片获取
        addPicture()
        
    }
    if buttonIndex == 2{
        //拍照
        var sourceType = UIImagePickerControllerSourceType.Camera
        
        
        
        if !UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera){
            
            
            
            sourceType = UIImagePickerControllerSourceType.PhotoLibrary
            
            let picker = UIImagePickerController()
            
            
            
            picker.delegate = self
            
            currentIndex = indexPathPicture.item
            
            picker.allowsEditing = true//设置可编辑
            
            
            
            picker.sourceType = sourceType
            
            
            presentViewController(picker, animated: true, completion: nil)//进入照相界面
            
            
            
        }
    }
}











    /// 实现代理方法
   func photoSelectedCellRemovePhoto(cell: QYMPhotoselectedViewCell) {

    
    let indexPath = collectionView?.indexPathForCell(cell)
    photos.removeAtIndex(indexPath!.item)
    
    collectionView?.reloadData()
    
    }
   func photoSelectedCellSelectPhoto(cell: QYMPhotoselectedViewCell) {
       // <#code#>
    }

    lazy var photos = [UIImage]()
    //记录当前的照片的索引
    var currentIndex = 0
}

extension QYMPhotoSelectorController:UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
   func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
    
    //首先调用方法 缩小图片显示
    let scaleImage = image.scaleImage(100)
    //判断如果当前是最后一个。直接添加，如果不是替换
    if currentIndex > photos.count - 1{
        
   //在数组中添加选中的image
    photos.append(image)
        
    }else{
        
        photos[currentIndex] = scaleImage
    }
    //重写加载视图
    collectionView?.reloadData()
    
    dismissViewControllerAnimated(true , completion: nil)
    
    }
}