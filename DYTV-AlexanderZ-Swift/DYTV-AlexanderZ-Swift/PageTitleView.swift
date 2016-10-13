//
//  PageTitleView.swift
//  DYTV-AlexanderZ-Swift
//
//  Created by Alexander Zou on 16/9/23.
//  Copyright © 2016年 Alexander Zou. All rights reserved.
//

import UIKit

protocol PageTitleViewDelegate : class {
    func pageTitleView(titleView : PageTitleView, selectedIndex : Int)
}

private let kScrollLineH : CGFloat = 2
private let kNormalColor : (CGFloat,CGFloat,CGFloat) = (85,85,85)
private let kMoveColor : (CGFloat,CGFloat,CGFloat) = (255,128,0)

class PageTitleView: UIView {
    
    // 定义属性
    fileprivate var titles : [String]
    fileprivate var currentIndex : Int = 0
    weak var delegate : PageTitleViewDelegate?
    
    
    // 懒加载属性
    fileprivate lazy var titleLabels : [UILabel] = [UILabel]()
    fileprivate lazy var scrollView : UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false                     //点击回到头部
        scrollView.bounces = false
        return scrollView
    }()
    
    fileprivate lazy var scrollLine : UIView = {
       
        let scrollLine = UIView()
        scrollLine.backgroundColor = UIColor.orange
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
    
    fileprivate func setupUI(){
        
        addSubview(scrollView)
        scrollView.frame = bounds
        
        setupTitleLabels()
        
        setupButtomLineAndScrollLine()
        
    }
    
    @objc fileprivate func setupTitleLabels(){
        
        let labelW : CGFloat = frame.width / CGFloat(titles.count)
        let labelH : CGFloat = frame.height - kScrollLineH
        
        for (index,title) in titles.enumerated() {
            
            let label = UILabel()
            label.text = title
            label.tag = index
            label.font = UIFont.systemFont(ofSize: 16.0)
            label.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
            label.textAlignment = .center
            
            let labelX : CGFloat = labelW * CGFloat(index)
            let labelY : CGFloat = 0
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            
            scrollView.addSubview(label)
            titleLabels.append(label)
            
            // 给label添加手势
            label.isUserInteractionEnabled = true
            let tapGes = UITapGestureRecognizer(target: self, action: #selector(self.titleLabelClick(_:)))
            label.addGestureRecognizer(tapGes)
            
        }
        
    }
    
    fileprivate func setupButtomLineAndScrollLine(){
        
        let buttomLine = UIView()
        buttomLine.backgroundColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
        let lineH : CGFloat = 0.5
        buttomLine.frame = CGRect(x: 0, y: frame.height - lineH, width: frame.width, height: lineH)
        addSubview(buttomLine)
        
        scrollView.addSubview(scrollLine)

        guard let firstLabel = titleLabels.first else { return }
        firstLabel.textColor = UIColor(r: kMoveColor.0, g: kMoveColor.1, b: kMoveColor.2)
        scrollLine.frame = CGRect(x: firstLabel.frame.origin.x, y: frame.height - kScrollLineH, width: firstLabel.frame.width, height: kScrollLineH)
        
    }
}

// MARK:- 监听label的点击事件
extension PageTitleView {
    @objc fileprivate func titleLabelClick(_ tapGes : UITapGestureRecognizer) {
        
        guard let currentLabel = tapGes.view as? UILabel else { return }
        
        // 如果是重复点击同一个Title,那么直接返回
        if currentLabel.tag == currentIndex { return }
        
        let oldLabel = titleLabels[currentIndex]
        
        // 切换文字的颜色
        currentLabel.textColor = UIColor(r: kMoveColor.0, g: kMoveColor.1, b: kMoveColor.2)
        oldLabel.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
        
        currentIndex = currentLabel.tag
        
        // 滚动条位置发生改变
        let scrollLineX = CGFloat(currentIndex) * scrollLine.frame.width
        UIView.animate(withDuration: 0.15, animations: {
            self.scrollLine.frame.origin.x = scrollLineX
        })
        
        delegate?.pageTitleView(titleView: self, selectedIndex: currentIndex)
    }
}


extension PageTitleView {
    func setTitleWithProgress(progress : CGFloat, sourceIndex : Int, targetIndex : Int){
        
        
        let sourceLabel = titleLabels[sourceIndex]
        let targetLabel = titleLabels[targetIndex]
        
        // 处理滑块的逻辑
        let moveTotalX = targetLabel.frame.origin.x - sourceLabel.frame.origin.x
        let moveX = moveTotalX * progress
        scrollLine.frame.origin.x = sourceLabel.frame.origin.x + moveX
        
        // 颜色的渐变
        let colorDelta = (kMoveColor.0 - kNormalColor.0, kMoveColor.1 - kNormalColor.1, kMoveColor.2 - kNormalColor.2)
        
        sourceLabel.textColor = UIColor(r: kMoveColor.0 - colorDelta.0 * progress, g: kMoveColor.1 - colorDelta.1 * progress, b: kMoveColor.2 - colorDelta.2 * progress)
        
        targetLabel.textColor = UIColor(r: kNormalColor.0 + colorDelta.0 * progress, g: kNormalColor.1 + colorDelta.1 * progress, b: kNormalColor.2 + colorDelta.2 * progress)
        
        currentIndex = targetIndex
    }
}
