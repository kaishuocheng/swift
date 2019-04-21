//
//  DetailViewController.swift
//  kc673_p5
//
//  Created by kaishuo cheng on 4/14/19.
//  Copyright © 2019 Cornell AppDev. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    var restaurant: restaurant
    var picture: UIImageView
    var information: UITextView
    init(restaurant: restaurant){
       self.restaurant = restaurant
        picture = UIImageView(image: restaurant.image)
        information = UITextView()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(picture)
        var eatingtime: String = ""
        for i in restaurant.time{
        eatingtime += " \(i)"
        }
        information.text = "Name: \(restaurant.name) \n Type: \(restaurant.food) \n Time: \(eatingtime) \n Price: $\(restaurant.cost)"

        
        information.textColor = .black
        information.translatesAutoresizingMaskIntoConstraints = false
        information.font = UIFont.systemFont(ofSize: 16)
        picture.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(information)
        information.backgroundColor = .white
        information.isEditable = false
        setupconstrainst()
        // Do any additional setup after loading the view.
    }
    

    func setupconstrainst(){
        NSLayoutConstraint.activate([
            picture.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            picture.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            ])
        NSLayoutConstraint.activate([
            information.topAnchor.constraint(equalTo: picture.bottomAnchor, constant: 20),
            information.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            information.widthAnchor.constraint(equalToConstant: 200),
            information.heightAnchor.constraint(equalToConstant: 100)
            ])
    }

}
