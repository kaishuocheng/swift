//
//  ViewController.swift
//  kc673_p3
//
//  Created by kaishuo cheng on 3/17/19.
//  Copyright © 2019 Cornell AppDev. All rights reserved.
//

import UIKit
protocol ChangeRedTextDelegate: class {
    func RedTextChanged(to newString: String)
}
protocol ChangeBlueTextDelegate: class {
    func BlueTextChanged(to newString: String)
}
class ViewController: UIViewController {
    var red : UIButton!
    var blue : UIButton!
    var magic : UIButton!
    var triangle: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        view.backgroundColor = .white
        title = "Drawing Arena"
        red = UIButton()
        red.translatesAutoresizingMaskIntoConstraints = false
        red.setTitle("Red Square Arena", for: .normal)
        red.setTitleColor(.red, for: .normal)
        red.addTarget(self, action: #selector(PushRedViewController), for: .touchUpInside)
        blue = UIButton()
        blue.translatesAutoresizingMaskIntoConstraints = false
        blue.setTitle("Blue Circle Arena", for: .normal)
        blue.setTitleColor(.blue, for: .normal)
        blue.addTarget(self, action: #selector(PushBlueViewController), for: .touchUpInside)
        view.addSubview(red)
        view.addSubview(blue)
       magic = UIButton()
        magic.translatesAutoresizingMaskIntoConstraints = false
        magic.setTitle("Magic Arena", for: .normal)
        magic.setTitleColor(.black, for: .normal)
        magic.addTarget(self, action: #selector(PushMagicViewController), for: .touchUpInside)
        view.addSubview(magic)
        triangle = UIButton()
        triangle.translatesAutoresizingMaskIntoConstraints = false
        triangle.setTitle("Triangle Arena", for: .normal)
        triangle.setTitleColor(.black, for: .normal)
       triangle.addTarget(self, action: #selector(PushTrianViewController), for: .touchUpInside)
        view.addSubview(triangle)
        setupConstraints()
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            red!.centerXAnchor.constraint(equalTo: view.centerXAnchor),
              red!.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            red!.widthAnchor.constraint(equalToConstant: 150),
            red!.heightAnchor.constraint(equalToConstant: 30)
            ])
        NSLayoutConstraint.activate([
            blue!.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            blue!.centerYAnchor.constraint(equalTo: red.centerYAnchor,constant: 50),
            blue!.widthAnchor.constraint(equalToConstant: 150),
            blue!.heightAnchor.constraint(equalToConstant: 30),
            ])
        NSLayoutConstraint.activate([
            magic!.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            magic!.centerYAnchor.constraint(equalTo: blue.centerYAnchor,constant: 50),
            magic!.widthAnchor.constraint(equalToConstant: 150),
            magic!.heightAnchor.constraint(equalToConstant: 30),
            ])
        NSLayoutConstraint.activate([
            triangle!.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            triangle!.centerYAnchor.constraint(equalTo: magic.centerYAnchor,constant: 50),
            triangle!.widthAnchor.constraint(equalToConstant: 150),
            triangle!.heightAnchor.constraint(equalToConstant: 30),
            ])
}
    @objc func PushRedViewController() {
        let redViewController = ArenaViewController(placeholderText: red.title(for: .normal)!, status : "red")
        navigationController?.pushViewController(redViewController, animated: true)
        redViewController.reddelegate = self
    }
    @objc func PushBlueViewController() {
        let blueViewController = ArenaViewController(placeholderText: blue.title(for: .normal)!, status : "blue")
        navigationController?.pushViewController(blueViewController, animated: true)
        blueViewController.bluedelegate = self
    }
    @objc func PushMagicViewController() {
        let magicViewController = ArenaViewController(placeholderText: magic.title(for: .normal)!, status : "magic")
        navigationController?.pushViewController(magicViewController, animated: true)
        
    }
    @objc func PushTrianViewController() {
        let trianViewController = ArenaViewController(placeholderText: triangle.title(for: .normal)!, status : "triangle")
        navigationController?.pushViewController(trianViewController, animated: true)
        
    }
    
}
extension ViewController: ChangeRedTextDelegate {

    
    func RedTextChanged(to newString: String) {
        red.setTitle(newString, for: .normal)
    }
}
extension ViewController: ChangeBlueTextDelegate {
    func BlueTextChanged(to newString: String) {
        blue.setTitle(newString, for: .normal)
    }
}
