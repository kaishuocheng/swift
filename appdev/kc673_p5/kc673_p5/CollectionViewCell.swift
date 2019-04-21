//
//  RestaurantCollectionViewCell.swift
//  kc673_p5
//
//  Created by kaishuo cheng on 4/14/19.
//  Copyright © 2019 Cornell AppDev. All rights reserved.
//

import UIKit

// restaurant collection view
class RestaurantCollectionViewCell: UICollectionViewCell {
    var photoImageView: UIImageView
    var name: UILabel!
    override init(frame: CGRect) {
       
        
        photoImageView = UIImageView(frame: .zero)
        photoImageView.translatesAutoresizingMaskIntoConstraints = false
        photoImageView.contentMode = .scaleAspectFit
        name = UILabel()
         super.init(frame: frame)
        contentView.addSubview(photoImageView)
        contentView.addSubview(name)
        name.translatesAutoresizingMaskIntoConstraints = false
        setupConstraints()
        
    }
    func setupConstraints() {
        NSLayoutConstraint.activate([
            photoImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            photoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            photoImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            photoImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
            ])
        NSLayoutConstraint.activate([
            name.topAnchor.constraint(equalTo: photoImageView.bottomAnchor),
            name.leadingAnchor.constraint(equalTo: photoImageView.leadingAnchor),
            ])
    }
    func configure(for restaurant: restaurant){
        photoImageView.image = restaurant.image
        name.text = restaurant.name
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// restaurant tableview
class RestaurantTablenViewCell: UITableViewCell {
    var photoImageView: UIImageView
    var name: UILabel!
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        
        photoImageView = UIImageView(frame: .zero)
        photoImageView.translatesAutoresizingMaskIntoConstraints = false
        photoImageView.contentMode = .scaleAspectFit
        name = UILabel()
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(photoImageView)
        contentView.addSubview(name)
        name.translatesAutoresizingMaskIntoConstraints = false
        setupConstraints()
        
    }
    func setupConstraints() {
        NSLayoutConstraint.activate([
            name.topAnchor.constraint(equalTo: contentView.topAnchor),
            name.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            ])
        NSLayoutConstraint.activate([
            photoImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            photoImageView.leadingAnchor.constraint(equalTo: name.trailingAnchor),
            photoImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            photoImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
            ])
        
    }
    func configure(for restaurant: restaurant){
        photoImageView.image = restaurant.image
        name.text = restaurant.name
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// food type cell
class filterviewcell: UICollectionViewCell{
    var choice: UIButton
    weak var delegate: FoodtypeDelegate?
    override init(frame: CGRect) {
        choice = UIButton()
        choice.isSelected = false
        choice.setTitleColor(.blue, for: .normal)
        choice.backgroundColor = .white
        super.init(frame:frame)
        contentView.addSubview(choice)
        choice.translatesAutoresizingMaskIntoConstraints = false
        choice.addTarget(self, action: #selector(foodtypeselected), for: .touchUpInside)
        setupconstrainst()
}
    func setupconstrainst(){
        NSLayoutConstraint.activate([
            choice.topAnchor.constraint(equalTo: contentView.topAnchor),
            choice.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            choice.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            choice.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
            ])
    }
    func configure(for title: String){
        choice.setTitle(title, for: .normal)
       
    }
    @objc func foodtypeselected(){
        if choice.isSelected{
            choice.isSelected = false
            delegate?.FoodtypeChanged(to: choice.currentTitle!, insert: false)
            choice.backgroundColor = .white
            
        }
        else{
            choice.isSelected = true
             delegate?.FoodtypeChanged(to: choice.currentTitle!, insert: true)
            choice.backgroundColor = .gray
            
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// time cell
class timeviewcell: UICollectionViewCell{
    var choice: UIButton
    weak var delegate: TimeDelegate?
    override init(frame: CGRect) {
        choice = UIButton()
        choice.isSelected = false
        choice.setTitleColor(.blue, for: .normal)
        choice.backgroundColor = .white
        super.init(frame:frame)
        contentView.addSubview(choice)
        choice.translatesAutoresizingMaskIntoConstraints = false
        choice.addTarget(self, action: #selector(timeselected), for: .touchUpInside)
        setupconstrainst()
    }
    func setupconstrainst(){
        NSLayoutConstraint.activate([
            choice.topAnchor.constraint(equalTo: contentView.topAnchor),
            choice.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            choice.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            choice.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
            ])
    }
    func configure(for title: String){
        choice.setTitle(title, for: .normal)
        
    }
    @objc func timeselected(){
        if choice.isSelected{
            choice.isSelected = false
            delegate?.timeChanged(to: choice.currentTitle!, insert: false)
            choice.backgroundColor = .white
            
        }
        else{
            choice.isSelected = true
            delegate?.timeChanged(to: choice.currentTitle!, insert: true)
            choice.backgroundColor = .gray
            
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
