

import UIKit
//MARK 定义协议
protocol QYMPhotoselectedViewCellDelegate:NSObjectProtocol{
    //选择照片
    func photoSelectedCellSelectPhoto(cell: QYMPhotoselectedViewCell)
    //删除照片
    func photoSelectedCellRemovePhoto(cell: QYMPhotoselectedViewCell)
}

//MARK  自定义Cell
class QYMPhotoselectedViewCell: UICollectionViewCell {
    
    //代理属性
    weak var photoDelegate: QYMPhotoselectedViewCellDelegate?
    
    //用户选中的照片
    var image: UIImage?{
        
        didSet{
            
            if image == nil{
                photoButton.setImage(UIImage(named: "compose_pic_add"), forState: UIControlState.Normal)
                //如果没有显示图片 ，就隐藏删除按钮
                removeButton.hidden = true
            }else{
                //如果有图片，就显示删除按钮
                removeButton.hidden = false
                photoButton.setImage(image, forState: UIControlState.Normal)
            }
            
        }
    }
    //监听的方法
    @objc func removePhoto(){
        
        photoDelegate?.photoSelectedCellRemovePhoto(self)
    }
    @objc func clickPhoto(){
        
        photoDelegate?.photoSelectedCellSelectPhoto(self)
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //界面显示
    private func setupUI(){
        
        addSubview(photoButton)
        addSubview(removeButton)
        
        //自动布局
        photoButton.translatesAutoresizingMaskIntoConstraints = false
        removeButton.translatesAutoresizingMaskIntoConstraints = false
        
        let dict = ["photo":photoButton,"remove":removeButton]
        
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[photo]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: dict))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[photo]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: dict))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[remove]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: dict))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[remove]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: dict))
        
        //禁用按钮的交互，是为了保证使用collectionView的 didSelectItemAtIndex方法的执行
        photoButton.userInteractionEnabled = false
        //监听方法
        removeButton.addTarget(self , action: "removePhoto", forControlEvents: UIControlEvents.TouchUpInside)
        photoButton.addTarget(self, action: "clickPhoto", forControlEvents: UIControlEvents.TouchUpInside)
        photoButton.imageView?.contentMode = UIViewContentMode.ScaleAspectFill
    }
    
    
    
    private lazy var photoButton: UIButton = UIButton(imageName: "compose_pic_add")
    
    private lazy var removeButton:UIButton = UIButton(imageName: "compose_photo_close")
}
