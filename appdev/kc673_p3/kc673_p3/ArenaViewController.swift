//
//  ModelVIewController.swift
//  kc673_p3
//
//  Created by kaishuo cheng on 3/17/19.
//  Copyright © 2019 Cornell AppDev. All rights reserved.
//

import UIKit


class ArenaViewController: UIViewController {
    weak var reddelegate: ChangeRedTextDelegate?
    weak var bluedelegate: ChangeBlueTextDelegate?
    var redplaceholderText: String
    var blueplaceholderText: String
    var slider: UISlider
     var valid : UILabel = UILabel()
    var status : String
    init(placeholderText: String, status: String) {
        if status == "red"{
        self.redplaceholderText = placeholderText
             self.blueplaceholderText = ""
        }else{
            self.blueplaceholderText = placeholderText
            self.redplaceholderText = ""
        }
        self.status = status
        self.magic = UIColor(red: .random(in: 0...1),
                        green: .random(in: 0...1),
                        blue: .random(in: 0...1),
                        alpha: 1.0)
        self.subview = UIView()
        self.slider = UISlider()
        super.init(nibName: nil, bundle: nil)
        
    }
    
    // This function is required, you can ignore it
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    var lefttext: UILabel = UILabel()
    var name: UITextField = UITextField()
    var redsave : UIBarButtonItem = UIBarButtonItem()
    var bluesave : UIButton = UIButton()
    var click: UITapGestureRecognizer = UITapGestureRecognizer()
    var magic: UIColor
    var subview : UIView
    var magicbutton : UIButton = UIButton()
    override func viewDidLoad() {
        
            
        super.viewDidLoad()
    self.view.isUserInteractionEnabled = true
      
        if status == "red"{
        redsave.title = "save"
        redsave.tintColor = .blue
        redsave.target = self
        redsave.action = #selector(redchangetext)
        view.backgroundColor = .white
        lefttext.translatesAutoresizingMaskIntoConstraints = false
        lefttext.text = "Arena Name: "
        name.text = redplaceholderText
        name.translatesAutoresizingMaskIntoConstraints = false
        valid.text = " "
        valid.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(lefttext)
        view.addSubview(name)
        view.addSubview(valid)
        self.navigationItem.rightBarButtonItem = redsave
        
        click.addTarget(self, action: #selector(reddraw))
        self.view.addGestureRecognizer(click)
            slider.minimumValue = 1.0
            slider.maximumValue = 50.0
            slider.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(slider)
            slider.value = 1.0
            slider.isEnabled = true
            slider.isUserInteractionEnabled = true
            redsetupConstraintsred()
        }
        else if status == "blue"{
            bluesave.translatesAutoresizingMaskIntoConstraints = false
            bluesave.setTitle("save", for: .normal)
            bluesave.backgroundColor = .white
            bluesave.setTitleColor(.blue, for: .normal)
            bluesave.addTarget(self, action: #selector(bluechangetext), for: .touchUpInside)
            view.backgroundColor = .white
            lefttext.translatesAutoresizingMaskIntoConstraints = false
            lefttext.text = "Arena Name: "
            name.text = blueplaceholderText
            name.translatesAutoresizingMaskIntoConstraints = false
            valid.text = " "
            valid.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(lefttext)
            view.addSubview(name)
            view.addSubview(valid)
            
            view.addSubview(bluesave)
            
            click.addTarget(self, action: #selector(bluedraw))
            view.addGestureRecognizer(click)
            bluesetupConstraints()
            
        }
        else if status == "magic"{
            magicbutton.setTitle("Drag to change transparency, Click to Change", for: .normal)
            magicbutton.backgroundColor = .gray
            subview.backgroundColor = magic
            self.view = subview
             click.addTarget(self, action: #selector(magicdraw))
            self.view.addGestureRecognizer(click)
            view.clipsToBounds = true
            magicbutton.translatesAutoresizingMaskIntoConstraints = false
            magicbutton.tintColor = .black
            magicbutton.addTarget(self, action: #selector(magicchange), for: .touchUpInside)
            view.addSubview(magicbutton)
            slider.minimumValue = 0.0
            slider.maximumValue = 1.0
            slider.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(slider)
            slider.value = 0.0
            slider.isEnabled = true
            slider.isUserInteractionEnabled = true
            magicsetupConstraints()
            
        }
        else{
            let rect = CGRect(x: 100, y: 100, width: 50, height: 50)
            let eraseview = UIView(frame: rect)
            eraseview.backgroundColor = .green
            view.backgroundColor = .white
            click.addTarget(self, action: #selector(triandraw))
            view.addGestureRecognizer(click)
            view.addSubview(eraseview)
            
            let erase = UITapGestureRecognizer()
            erase.addTarget(self, action: #selector(eraseall))
            eraseview.addGestureRecognizer(erase)
        }
        // Do any additional setup after loading the view.
    }
    func redsetupConstraintsred() {
        NSLayoutConstraint.activate([
            lefttext.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            lefttext.centerYAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            lefttext.widthAnchor.constraint(equalToConstant: 150),
            lefttext.heightAnchor.constraint(equalToConstant: 30)
            ])
        NSLayoutConstraint.activate([
            name.leadingAnchor.constraint(equalTo: lefttext.trailingAnchor, constant: 20),
            name.centerYAnchor.constraint(equalTo: lefttext.centerYAnchor),
            name.widthAnchor.constraint(equalToConstant: 150),
            name.heightAnchor.constraint(equalToConstant: 30)
            ])
        NSLayoutConstraint.activate([
            valid.leadingAnchor.constraint(equalTo: name.leadingAnchor),
            valid.trailingAnchor.constraint(equalTo: name.trailingAnchor, constant: 40),
            valid.centerYAnchor.constraint(equalTo: name.centerYAnchor, constant:40),
            valid.heightAnchor.constraint(equalToConstant: 30)
            ])
    NSLayoutConstraint.activate([
            slider.topAnchor.constraint(equalTo: lefttext.bottomAnchor),
            slider.heightAnchor.constraint(equalToConstant:20),
            slider.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            slider.widthAnchor.constraint(equalToConstant: 100)
            ])

}
    func bluesetupConstraints() {
        NSLayoutConstraint.activate([
            lefttext.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            lefttext.centerYAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            lefttext.widthAnchor.constraint(equalToConstant: 150),
            lefttext.heightAnchor.constraint(equalToConstant: 30)
            ])
        NSLayoutConstraint.activate([
            name.leadingAnchor.constraint(equalTo: lefttext.trailingAnchor, constant: 20),
            name.centerYAnchor.constraint(equalTo: lefttext.centerYAnchor),
            name.widthAnchor.constraint(equalToConstant: 150),
            name.heightAnchor.constraint(equalToConstant: 30)
            ])
        NSLayoutConstraint.activate([
            valid.leadingAnchor.constraint(equalTo: name.leadingAnchor),
            valid.trailingAnchor.constraint(equalTo: name.trailingAnchor, constant: 40),
            valid.centerYAnchor.constraint(equalTo: name.centerYAnchor, constant:40),
            valid.heightAnchor.constraint(equalToConstant: 30)
            ])
        NSLayoutConstraint.activate([
            bluesave.leadingAnchor.constraint(equalTo: name.leadingAnchor),
            bluesave.trailingAnchor.constraint(equalTo: name.trailingAnchor, constant: 40),
            bluesave.centerYAnchor.constraint(equalTo: name.centerYAnchor, constant:80),
            bluesave.heightAnchor.constraint(equalToConstant: 30)
            ])
    }
    func magicsetupConstraints(){
        NSLayoutConstraint.activate([
        magicbutton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        magicbutton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
         magicbutton.heightAnchor.constraint(equalToConstant: 40),
            magicbutton.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            
        ])
        NSLayoutConstraint.activate([
        slider.topAnchor.constraint(equalTo: magicbutton.bottomAnchor),
        slider.heightAnchor.constraint(equalToConstant:40),
        slider.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        slider.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
    @IBAction func redchangetext() {
        if let text = name.text, text != "" {
            reddelegate?.RedTextChanged(to: text)
            navigationController?.popViewController(animated: true)
        }
        else{
            valid.text = "Input Not Valid"
            valid.textColor = .red
            
        }
        
    }
    @objc func bluechangetext() {
        if let text = name.text, text != "" {
            bluedelegate?.BlueTextChanged(to: text)
            navigationController?.popViewController(animated: true)
        }
        else{
            valid.text = "Input Not Valid"
            valid.textColor = .red
            
        }
    }
        @objc func magicchange() {
            view.backgroundColor = view.backgroundColor?.withAlphaComponent(CGFloat(slider.value))
            }
        
    
    func drawshape(viewcontroller: UIViewController, location: CGPoint, shape: String, color : UIColor){
       
       
        if shape == "circle"{
        let circlePath = UIBezierPath(arcCenter: location, radius: CGFloat(20), startAngle: CGFloat(0), endAngle:CGFloat(Double.pi * 2), clockwise: true)
            let shapeLayer = CAShapeLayer()
            shapeLayer.path = circlePath.cgPath
            shapeLayer.fillColor = color.cgColor
            shapeLayer.strokeColor = color.cgColor
            shapeLayer.lineWidth = 1.0
            viewcontroller.view.layer.addSublayer(shapeLayer)

        }
        else if shape == "magicsquare"{
            let rect = CGRect(x: location.x-20.0, y: location.y-20.0, width: 40.0, height: 40.0)
            let rectpath = UIBezierPath(rect: rect)
            let shapeLayer = CAShapeLayer()
            shapeLayer.path = rectpath.cgPath
            shapeLayer.fillColor = color.cgColor
            shapeLayer.strokeColor = color.cgColor
            shapeLayer.lineWidth = 1.0
            viewcontroller.view.layer.addSublayer(shapeLayer)
        }
        else if shape == "redsquare"{
            let edge = CGFloat(self.slider.value)
            let left = location.x - edge/2
            let top = location.y - edge/2
            let rect = CGRect(x: left, y: top, width: edge, height: edge)
            let rectpath = UIBezierPath(rect: rect)
            let shapeLayer = CAShapeLayer()
            shapeLayer.path = rectpath.cgPath
            shapeLayer.fillColor = color.cgColor
            shapeLayer.strokeColor = color.cgColor
            shapeLayer.lineWidth = 1.0
            viewcontroller.view.layer.addSublayer(shapeLayer)
        }
        else{
            let path = UIBezierPath()
            
            let veredge = CGFloat(30.0)
            let toppoint = CGPoint(x: location.x, y: location.y + veredge)
            let rightpoint = CGPoint(x: location.x + CGFloat(3.squareRoot())*veredge/2, y: location.y - veredge/2)
            let leftpoint = CGPoint(x: location.x - CGFloat(3.squareRoot())*veredge/2, y: location.y - veredge/2)
           path.move(to: toppoint)
           path.addLine(to: rightpoint)
            path.addLine(to: leftpoint)
            path.close()
           let shapeLayer = CAShapeLayer()
            shapeLayer.path = path.cgPath
            shapeLayer.fillColor = color.cgColor
            shapeLayer.strokeColor = color.cgColor
            shapeLayer.lineWidth = 1.0
            viewcontroller.view.layer.addSublayer(shapeLayer)
           
        
        }
    }
@objc func reddraw(){
    
    drawshape(viewcontroller: self, location: click.location(in: self.view), shape: "redsquare", color: UIColor.red)
}
    @objc func bluedraw(){
       
        drawshape(viewcontroller: self, location: click.location(in: self.view), shape: "circle", color: UIColor.blue)
    }
    @objc func magicdraw(){
        let color = UIColor(red: .random(in: 0...1),
                            green: .random(in: 0...1),
                            blue: .random(in: 0...1),
                            alpha: 1.0)
        drawshape(viewcontroller: self, location: click.location(in: self.view), shape: "magicsquare", color: color)
    }
    @objc func triandraw(){
        
        drawshape(viewcontroller: self, location: click.location(in: self.view), shape: "triangle", color: UIColor.blue)
    }
    @objc func eraseall(){
        let rect = CGRect(origin: CGPoint(x: 0.0, y: 0.0), size: view.frame.size)
        let rectpath = UIBezierPath(rect: rect)
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = rectpath.cgPath
        shapeLayer.fillColor = UIColor.white.cgColor
        shapeLayer.strokeColor = UIColor.white.cgColor
        shapeLayer.lineWidth = 1.0
        view.layer.addSublayer(shapeLayer)
        view.bringSubviewToFront(view.subviews[0])
    }
}
