//
//  ViewController.swift
//  Light_2048
//
//  Created by light on 2017/5/12.
//  Copyright © 2017年 light. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // MARK:
    var data : [[Int]] = [[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0]]
    var viewArray = [[UILabel]]()
    var backView = UIView()
    var scoreView : UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        drawDefault()
        addNew()
        addNew()
        setContent()
        
        let swipeUp = UISwipeGestureRecognizer(target: self, action:#selector(self.viewSwipe(_ :)))
        swipeUp.direction = UISwipeGestureRecognizerDirection.up
        self.view.addGestureRecognizer(swipeUp)
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action:#selector(self.viewSwipe(_ :)))
        swipeDown.direction = UISwipeGestureRecognizerDirection.down
        self.view.addGestureRecognizer(swipeDown)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action:#selector(self.viewSwipe(_ :)))
        swipeLeft.direction = UISwipeGestureRecognizerDirection.left
        self.view.addGestureRecognizer(swipeLeft)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action:#selector(self.viewSwipe(_ :)))
        swipeRight.direction = UISwipeGestureRecognizerDirection.right
        self.view.addGestureRecognizer(swipeRight)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func viewSwipe(_ sender: UISwipeGestureRecognizer) {
        switch sender.direction {
        case UISwipeGestureRecognizerDirection.left:
            leftMove()
            leftAdd()
        case UISwipeGestureRecognizerDirection.right:
            rightMove()
            rightAdd()
        case UISwipeGestureRecognizerDirection.up:
            upMove()
            upAdd()
        case UISwipeGestureRecognizerDirection.down:
            downMove()
            downAdd()
        default:
            print("不能识别的滑动")
        }
        if haveVoid() || canMove(){
            
        }else{
            print("Game Over")
        }
        setContent()
    }

    // MARK: - 处理方法
    
    func leftMove(){
        for i in 0...3 {
            for j in (0...2).reversed() {
                for z in 0...j{
                    if data[i][z] == 0 {
                        swap(&data[i][z], &data[i][z + 1])
                    }
                }
            }
        }
        
    }
    
    func leftAdd() {
        for i in 0...3 {
            for j in 0...2 {
                if data[i][j] != 0 && data[i][j] == data[i][j + 1] {
                    data[i][j] *= 2
                    data[i][j + 1] = 0
                }
            }
        }
        leftMove()
        
    }
    
    
    func rightMove(){
        for i in 0...3 {
            for j in 0...2 {
                for z in (j...2).reversed(){
                    if data[i][z + 1] == 0 {
                        swap(&data[i][z], &data[i][z + 1])
                    }
                }
            }
        }
        
    }
    
    func rightAdd() {
        for i in 0...3 {
            for j in (0...2).reversed() {
                if data[i][j] != 0 && data[i][j] == data[i][j + 1] {
                    data[i][j] = 0
                    data[i][j + 1] *= 2
                }
            }
        }
        rightMove()
        
    }
    
    func upMove(){
        for i in (0...2).reversed() {
            for j in 0...3 {
                for z in (0...i).reversed(){
                    if data[z][j] == 0 {
                        swap(&data[z][j], &data[z + 1][j])
                    }
                }
            }
        }
        
    }
    
    func upAdd() {
        for i in 0...2 {
            for j in (0...3) {
                if data[i][j] != 0 && data[i][j] == data[i + 1][j] {
                    data[i][j] *= 2
                    data[i + 1][j] = 0
                }
            }
        }
        upMove()
        
    }
    
    func downMove(){
        for i in 0...2 {
            for j in 0...3 {
                for z in 0...i{
                    if data[z + 1][j] == 0 {
                        swap(&data[z][j], &data[z + 1][j])
                    }
                }
            }
        }
        
    }
    
    func downAdd() {
        for i in (0...2).reversed() {
            for j in (0...3) {
                if data[i][j] != 0 && data[i][j] == data[i + 1][j] {
                    data[i][j] = 0
                    data[i + 1][j] *= 2
                }
            }
        }
        downMove()
        
    }
    
    
    func drawDefault() {
        for i in 0...3 {
            var array = [UILabel]()
            for j in 0...3 {
                let label = UILabel(frame:CGRect(x: 60 * j , y: 60 * i ,width: 50 ,height: 50))
                label.font = UIFont.boldSystemFont(ofSize: 20)
//                label.font = UIFont.systemFont(ofSize: 20, weight: 50)
                label.adjustsFontSizeToFitWidth = true
                label.textAlignment = NSTextAlignmentFromCTTextAlignment(CTTextAlignment.center)
                label.textColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
                label.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
                self.view.addSubview(label)
                array.append(label)
            }
            viewArray.append(array)
        }
    }
    
    func setContent() {
        for i in 0...3 {
            for j in 0...3 {
                let label = viewArray[i][j]
                label.text = "\(data[i][j])"
                if data[i][j] == 0 {
                    label.text = ""
                }
            }
        }
    }
    
    // MARK: -产生新的方块
    
    func addNew() {
        var x = Int(arc4random_uniform(4))
        var y = Int(arc4random_uniform(4))
        
        //寻找空位
        while data[x][y] != 0{
            x = Int(arc4random_uniform(4))
            y = Int(arc4random_uniform(4))
        }
        let kind:Int = Int(arc4random_uniform(3))
        data[x][y] = ((kind % 2) + 1)*2
    }
    
    //判断是否有空位
    func haveVoid()->Bool{
        for i in 0..<4{
            for j in 0..<4{
                if data[i][j] == 0 {
                    addNew()
                    return true
                }
            }
        }
        return false
    }
    
    func canMove() -> Bool {
        for i in 0..<4{
            for j in 0..<4{
                if i + 1 < 4 && data[i][j] == data[i+1][j] || i - 1 > 0 && data[i][j] == data[i-1][j] || j + 1 < 4 && data[i][j] == data[i][j+1] || j - 1 > 0 && data[i][j] == data[i][j-1] {
                    return true
                }
            }
        }
        return false
    }
    
    // MARK: - UI
    
    func creatUI() {
        scoreView = UIView()
        scoreView?.frame = CGRect(x: 0,y: 0,width: 1,height: 1)
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
