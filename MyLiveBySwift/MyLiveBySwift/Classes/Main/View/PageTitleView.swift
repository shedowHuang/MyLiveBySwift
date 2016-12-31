//
//  PageTitleView.swift
//  MyLiveBySwift
//
//  Created by Shedows on 2016/12/31.
//  Copyright © 2016年 Shedows. All rights reserved.
//


// 1.自定义UIView；2.在UIView里加载UIScrollView

import UIKit

private let kScrollLineH : CGFloat = 2

protocol PageTitleViewDelegate: class {
    func pageTitleView(_ titleView : PageTitleView, selectedIndex index : Int)

}

class PageTitleView: UIView {
    
    // 定义成员变量
    fileprivate var titles: [String]
    fileprivate var titleLabels: [UILabel] = [UILabel]()
    fileprivate var currentIndex: Int = 0
    weak var deleget: PageTitleViewDelegate?
    
    // 懒加载        好处： 别的类可以直接调用
    var scrollVIew: UIScrollView = {
        let scrollVIew = UIScrollView()
        scrollVIew.showsHorizontalScrollIndicator = false
        scrollVIew.scrollsToTop = false
        scrollVIew.bounces = false
        
        return scrollVIew
    }()
    
    var scrollLineView: UIView = {
        let scrollLine = UIView()
        // 设置属性
        scrollLine.backgroundColor = UIColor.orange
        return scrollLine
    }()
    
    // 定义构造函数
    init(frame: CGRect, titles: [String]) {
        self.titles = titles
        super.init(frame: frame)
        
        // 加载UIScrollView
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension PageTitleView{

    func  setupUI(){
        // 添加SrcollView
        self.addSubview(scrollVIew)
        scrollVIew.frame = bounds
        
        // 添加Label到 SrcollView
        setTitleLabels()
        
        // 添加底线 和 底线上滚动滑线
        setBottomLineAndScrollLine()
    }
    
    private func setTitleLabels(){
        let labelW : CGFloat = frame.width / CGFloat(titles.count)
        let labelH : CGFloat = frame.height - kScrollLineH
        let labelY : CGFloat = 0
        
        // 1. 设置label
        for (index,title) in titles.enumerated(){
            // 创建label
            let label = UILabel()
            // 设置label 属性
            label.text = title
            label.tag = index
            label.font = UIFont.systemFont(ofSize: 16.0)
            label.textColor = UIColor.darkGray
            label.textAlignment = .center
            // 设置label的 frame
            let labelX : CGFloat = labelW * CGFloat(index)
            
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            // 将label添加到ScrollView
            scrollVIew.addSubview(label)
            titleLabels.append(label)
            
            // 添加label的手势
            label.isUserInteractionEnabled = true   // 设置用户可以互交
            let tapGas = UITapGestureRecognizer(target: self, action: #selector(self.titleLabelClick(_:)))
            label.addGestureRecognizer(tapGas)
            
        }
    }
    
    private func setBottomLineAndScrollLine() {
        // 创建底线
        let bottomLine = UIView()
        // 设置属性
        bottomLine.backgroundColor = UIColor.lightGray
        // 设置底线的frame
        let btmLineH : CGFloat = 0.5
        bottomLine.frame = CGRect(x: 0, y: frame.height-btmLineH, width: frame.width, height: btmLineH)
        // 添加到View
        self.addSubview(bottomLine)
        
        // 设置滑线的Frame
        guard let firstLabel = titleLabels.first else { return }
        firstLabel.textColor = UIColor.orange
        scrollLineView.frame = CGRect(x: firstLabel.frame.origin.x, y: frame.height - kScrollLineH, width: firstLabel.frame.width, height: kScrollLineH)
        // 将滑线添加到scrollView
               scrollVIew.addSubview(scrollLineView)

        
    }
}

// 监听label的手势
extension PageTitleView{
    @objc fileprivate func titleLabelClick(_ tapGes : UITapGestureRecognizer){
        
        //1. 获取当前label的下标值
        guard let currentLabel = tapGes.view as? UILabel else { return }
        // 2. 获取之前的label的下标值
        let oldLabel = titleLabels[currentIndex]
        // 3. 切换文件的颜色
        currentLabel.textColor = UIColor.orange
        oldLabel.textColor = UIColor.darkGray
        // 4.保存当前最新的label的下标值
        currentIndex = currentLabel.tag
        
        // 5.改变滚动条的位置，到当前点击label的位置
        let scrollLinePositionX = CGFloat(currentIndex) * scrollLineView.frame.width
        // 画个动画效果
        UIView.animate(withDuration: 0.15){
            self.scrollLineView.frame.origin.x = scrollLinePositionX
        }
        // 6.通知代理
        deleget?.pageTitleView(self, selectedIndex: currentIndex)
    }

}



