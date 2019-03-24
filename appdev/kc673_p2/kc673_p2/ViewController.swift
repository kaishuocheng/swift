//
//  ViewController.swift
//  kc673_p2
//
//  Created by kaishuo cheng on 3/10/19.
//  Copyright © 2019 Cornell AppDev. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var groceryitem : UITextField!
    var groceryleft : UILabel!
    var grocerylabel : UILabel!
    var additem : UIButton!
    var grocerylist: UITextView!
    var quantity: UITextField!
    var quanleft : UILabel!
    var Switch : UISwitch!
    var list : Array<String> = []
    var control: UISegmentedControl!
    var sorted : Array<String> = []
    var listandquan : Array<String> = []
    var space : String.Index!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        view.backgroundColor = UIColor.white
 
        groceryitem = UITextField()
        groceryitem.translatesAutoresizingMaskIntoConstraints = false
        groceryitem.backgroundColor = .gray
        groceryitem.font = UIFont.systemFont(ofSize: 12)
        groceryleft = UILabel()
        groceryleft.translatesAutoresizingMaskIntoConstraints = false
        groceryleft.text = "Grocery Item: "
        groceryleft.textColor = UIColor.black
        groceryleft.font = UIFont.systemFont(ofSize: 12)
        groceryitem.clipsToBounds = true
        groceryitem.contentMode = .scaleAspectFit
        view.addSubview(groceryitem)
        view.addSubview(groceryleft)
        quantity = UITextField()
        quantity.translatesAutoresizingMaskIntoConstraints = false
        quantity.backgroundColor = .gray
        quantity.font = UIFont.systemFont(ofSize: 12)
        quanleft = UILabel()
        quanleft.translatesAutoresizingMaskIntoConstraints = false
        quanleft.text = "Quantity: "
        quanleft.textColor = UIColor.black
        quanleft.font = UIFont.systemFont(ofSize: 12)
        view.addSubview(quantity)
        view.addSubview(quanleft)
        additem = UIButton()
        additem.translatesAutoresizingMaskIntoConstraints = false
        additem.setTitle("Add Item", for: .normal)
        additem.setTitleColor(.blue, for: .normal)
        additem.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        additem.addTarget(self, action: #selector(additemPressed), for: .touchUpInside)
        view.addSubview(additem)
        
        grocerylist = UITextView()
        grocerylist.translatesAutoresizingMaskIntoConstraints = false
        grocerylist.text = ""
        grocerylist.isEditable = true
        grocerylist.font = UIFont.systemFont(ofSize: 12)
        grocerylist.backgroundColor = .white
        grocerylist.textColor = .black
        view.addSubview(grocerylist)
        grocerylabel = UILabel()
        grocerylabel.translatesAutoresizingMaskIntoConstraints = false
        grocerylabel.text = "Grocery List: "
        grocerylabel.textColor = UIColor.black
        grocerylabel.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        
        view.addSubview(grocerylabel)
        Switch = UISwitch()
        Switch.translatesAutoresizingMaskIntoConstraints = false
        Switch.tintColor = .gray
        Switch.tintColor = .black
        Switch.isOn = true
        
        view.addSubview(Switch)
        control = UISegmentedControl()
        control.insertSegment(withTitle: "Ascedning", at: 0, animated: false)
        control.insertSegment(withTitle: "Descedning", at: 1, animated: false)
        control.translatesAutoresizingMaskIntoConstraints = false
        control.tintColor = .blue
        control.addTarget(self, action: #selector(controlchanged), for: .valueChanged)
        view.addSubview(control)
        setupConstraints()
    }
    func setupConstraints(){
        NSLayoutConstraint.activate([
            groceryitem.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            groceryitem.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant : 25),
            groceryitem.heightAnchor.constraint(equalToConstant: 20),
            groceryitem.widthAnchor.constraint(equalToConstant: 80)
            
            ])
        NSLayoutConstraint.activate([
            groceryleft.topAnchor.constraint(equalTo: groceryitem.topAnchor),
            groceryleft.trailingAnchor.constraint(equalTo: groceryitem.leadingAnchor, constant : -20),
            groceryleft.bottomAnchor.constraint(equalTo: groceryitem.bottomAnchor),
            groceryleft.widthAnchor.constraint(equalToConstant: 80)

            ])
        NSLayoutConstraint.activate([
            quantity.topAnchor.constraint(equalTo: groceryitem.topAnchor, constant: 30),
            quantity.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant : 25),
            quantity.heightAnchor.constraint(equalToConstant: 20),
            quantity.widthAnchor.constraint(equalToConstant: 80)
            
            ])
        NSLayoutConstraint.activate([
            quanleft.topAnchor.constraint(equalTo: quantity.topAnchor),
            quanleft.trailingAnchor.constraint(equalTo: quantity.leadingAnchor, constant : -20),
            quanleft.bottomAnchor.constraint(equalTo: quantity.bottomAnchor),
            quanleft.widthAnchor.constraint(equalToConstant: 80)
            
            ])
        NSLayoutConstraint.activate([
            additem.topAnchor.constraint(equalTo: quantity.bottomAnchor, constant:30),
            additem.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            additem.heightAnchor.constraint(equalToConstant: 25),
            additem.widthAnchor.constraint(equalToConstant: 200)
            ])
   
        NSLayoutConstraint.activate([
            grocerylabel.topAnchor.constraint(equalTo: additem.bottomAnchor, constant : 30),
            grocerylabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            grocerylabel.widthAnchor.constraint(equalToConstant: 100),
            grocerylabel.heightAnchor.constraint(equalToConstant: 20)
            
            ])
        NSLayoutConstraint.activate([
            Switch.topAnchor.constraint(equalTo: groceryitem.topAnchor),
            Switch.centerXAnchor.constraint(equalTo: groceryitem.trailingAnchor, constant: 40),
            Switch.widthAnchor.constraint(equalToConstant: 50),
            Switch.heightAnchor.constraint(equalToConstant: 20)
            
            ])
        NSLayoutConstraint.activate([
            control.topAnchor.constraint(equalTo: grocerylabel.bottomAnchor, constant : 10),
            control.heightAnchor.constraint(equalToConstant: 30),
            control.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            control.widthAnchor.constraint(equalToConstant: 200),
       
            
            ])
        NSLayoutConstraint.activate([
            grocerylist.widthAnchor.constraint(equalToConstant: 200),
            grocerylist.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -20),
            grocerylist.topAnchor.constraint(equalTo: control.bottomAnchor, constant: 40),
            grocerylist.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -8)
            ])
    }

@objc func additemPressed(){
    if  !checkvalidity() && Switch.isOn{
        grocerylist.text += "Item: \(groceryitem.text!), Quantity: \(quantity.text!) \n"
        list.append(groceryitem.text!)
        listandquan.append("\(groceryitem.text!) \(quantity.text!)")
        groceryitem.text = ""
        quantity.text = ""
    }
    else{
        
        groceryitem.text = ""
        quantity.text = ""
    }
        
    }
    func checkvalidity() -> Bool{
       
        return (groceryitem.text == "") || (quantity.text == "") || (list.contains(groceryitem.text!) || groceryitem.text!.contains(" ") || quantity.text!.contains(" "))
        
    }
    @objc func controlchanged(){
        if control.selectedSegmentIndex == 0{
            sorted = listandquan.sorted{$0.compare($1) == .orderedAscending}
            grocerylist.text = ""
            for i in sorted{
                
                space = i.firstIndex(of: " ")
                grocerylist.text += "Item: \(String(i[..<space])), Quantity: \(String(i.suffix(from: space))) \n"
            }
           
        }
        if control.selectedSegmentIndex == 1{
            sorted = listandquan.sorted{$0.compare($1) == .orderedDescending}
            grocerylist.text = ""
            for i in sorted{
                
                space = i.firstIndex(of: " ")
                grocerylist.text += "Item: \(String(i[..<space])), Quantity: \(String(i.suffix(from: space))) \n"
            }
            
        }
    }
}






