//
//  PageTitleView.swift
//  DYTV-AlexanderZ-Swift
//
//  Created by Alexander Zou on 16/9/23.
//  Copyright © 2016年 Alexander Zou. All rights reserved.
//

import UIKit

private let kScrollLineH : CGFloat = 2

class PageTitleView: UIView {
    
    
    // 定义属性
    private var titles : [String]
    
    
    // 懒加载属性
    private lazy var titleLabels : [UILabel] = [UILabel]()
    
    private lazy var scrollView : UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false                     //点击回到头部
        scrollView.bounces = false
        return scrollView
    }()
    
    private lazy var scrollLine : UIView = {
       
        let scrollLine = UIView()
        scrollLine.backgroundColor = UIColor.orangeColor()
        return scrollLine
        
    }()
    
    // 自定义构造函数
    init(frame: CGRect, title:[String]) {
        
        self.titles = title
        
        super.init(frame:frame)
        
        setupUI()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

extension PageTitleView {
    
    private func setupUI(){
        
        // 1.添加UIScrollView
        addSubview(scrollView)
        scrollView.frame = bounds
        
        // 2.添加Title对应的label
        setupTitleLabels()
        
        // 3.设置底线和滚动条
        setupButtomLineAndScrollLine()
        
    }
    
    private func setupTitleLabels(){
        
        // 0.提前确定label的frame
        let labelW : CGFloat = frame.width / CGFloat(titles.count)
        let labelH : CGFloat = frame.height - kScrollLineH
        
        for (index,title) in titles.enumerate() {
            // 1.创建lable
            let label = UILabel()
            
            // 2.创建lable属性
            label.text = title
            label.tag = index
            label.font = UIFont.systemFontOfSize(16.0)  //字体大小
            label.textColor = UIColor.darkGrayColor()
            label.textAlignment = .Center               //居中
            
            // 3.设置label的frame
            let labelX : CGFloat = labelW * CGFloat(index)
            let labelY : CGFloat = 0
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            
            scrollView.addSubview(label)
            titleLabels.append(label)
            
        }
        
        
        
    }
    
    private func setupButtomLineAndScrollLine(){
        
        // 1.设置底线
        let buttomLine = UIView()
        buttomLine.backgroundColor = UIColor.darkGrayColor()
        let lineH : CGFloat = 0.5
        buttomLine.frame = CGRect(x: 0, y: frame.height - lineH, width: frame.width, height: lineH)
        addSubview(buttomLine)
        
        // 2.添加scrollLine
        scrollView.addSubview(scrollLine)
        // 2.1获取lable
        guard let firstLabel = titleLabels.first else { return }
        firstLabel.textColor = UIColor.orangeColor()
        scrollLine.frame = CGRect(x: firstLabel.frame.origin.x, y: frame.height - kScrollLineH, width: firstLabel.frame.width, height: kScrollLineH)
        
    }
    
    
}