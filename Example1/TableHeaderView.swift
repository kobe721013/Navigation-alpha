
//
//  ParallaxHeaderView.swift
//  ParallaxHeaderView
//
//  Created by wl on 15/11/3.
//  Copyright © 2015年 wl. All rights reserved.
//

import UIKit

protocol TableHeaderViewDelegate: class {
    func LockScorllView(maxOffsetY: CGFloat)
    func autoAdjustNavigationBarAplha(aplha: CGFloat)
}

extension TableHeaderViewDelegate where Self : UITableViewController {
    func LockScorllView(maxOffsetY: CGFloat) {
        self.tableView.contentOffset.y = maxOffsetY
    }
    func autoAdjustNavigationBarAplha(aplha: CGFloat) {
        self.navigationController?.navigationBar.setMyBackgroundColorAlpha(alpha:aplha)
    }
}



class TableHeaderView: UIView {
    
    var subView: UIView
    var contentView: UIView = UIView()
    /// 最大的下拉限度
    var maxOffsetY: CGFloat
    weak var delegate: TableHeaderViewDelegate!
    private let originY:CGFloat = -64//navigationBar's height
    
     // MARK: - 初始化方法
    init(subView: UIView, headerViewSize: CGSize, maxOffsetY: CGFloat, delegate: TableHeaderViewDelegate) {
        
        self.subView = subView
        self.maxOffsetY = maxOffsetY < 0 ? maxOffsetY : -maxOffsetY
        self.delegate = delegate
        
        
        super.init(frame: CGRect(x:0, y:0, width:headerViewSize.width, height:headerViewSize.height))
        
        subView.autoresizingMask = [.flexibleLeftMargin, .flexibleRightMargin, .flexibleTopMargin, .flexibleBottomMargin, .flexibleWidth, .flexibleHeight]
        self.clipsToBounds = false;  //必須false
        self.contentView.frame = self.bounds
        self.contentView.addSubview(subView)
        self.contentView.clipsToBounds = true
        self.addSubview(contentView)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

   
     // MARK: - 其他方法
    func layoutHeaderViewWhenScroll(offset: CGPoint) {

        let delta:CGFloat = offset.y

        if delta < maxOffsetY {
            //鎖定table可以向下拉的最大Y值
            self.delegate.LockScorllView(maxOffsetY: maxOffsetY)
            
        }
        else if delta < 0
        {
            //還沒達到最大下拉高度, 調整headerView的長寬
            var rect = CGRect(x:0, y:0, width:self.bounds.size.width, height:self.bounds.size.height)
            rect.origin.y += delta ;
            rect.size.height -= delta;
            self.contentView.frame = rect;
        }
        
        //計算navigationBar的透明度值,只有當table往上滑時, header view的底端接觸到navigation'bar的底端, 表示header已經完全消失, 所以透明度要剛好是1, navigation完全顯示出來
        let alpha = CGFloat((-originY + delta) / (self.frame.size.height))
        print("originY=\(originY)...delta  = \(delta)... height=\(self.frame.size.height)... alpha = \(alpha)")
        self.delegate.autoAdjustNavigationBarAplha(aplha: alpha)
        
    }
}

