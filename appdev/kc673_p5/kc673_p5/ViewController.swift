//
//  ViewController.swift
//  kc673_p5
//
//  Created by kaishuo cheng on 4/14/19.
//  Copyright © 2019 Cornell AppDev. All rights reserved.
//

import UIKit
import Foundation
protocol FoodtypeDelegate: class {
    func FoodtypeChanged(to type: String, insert: Bool)
}
protocol TimeDelegate: class {
    func timeChanged(to type: String, insert: Bool)
}
class ViewController: UIViewController {
    var filterbar: UICollectionView!
    var collectionview: UICollectionView!
    var search: UISearchBar = UISearchBar()
    let padding: CGFloat = 8
    let headerHeight: CGFloat = 30
    let restaurantCellReuseIdentifier = "restaurantCellReuseIdentifier"
    let headerReuseIdentifier = "headerReuseIdentifier"
    let filtercellreuseidentifer = "filtercellreuseidentifierå"
    let tableviewcellreuseidentifier = "tableviewcellreuseidentifer"
    let timebarcellreuseidentifer = "timecellreuseidentifer"
    var restaurants: [restaurant]!
    var selectedrestaurants: [restaurant]!
    var selectedtypes: [String]!
    let restauranttypes = foodtype.allCases
    let timeslots = mealtime.allCases
    var layouttoggle: UIBarButtonItem = UIBarButtonItem()
    var tableview : UITableView = UITableView()
    var searchtext: String?
    var selectedtime: [String]!
    var timebar: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        // Do any additional setup after loading the view, typically from a nib.
        title = "My Restaurant"
        // construct restaurants
        let appel = restaurant(image: UIImage(named: "appel")!, name: "Appel", food: foodtype.Dininghall, time: [mealtime.breakfast,mealtime.lunch,mealtime.dinner], cost: 14)
        let CTB = restaurant(image: UIImage(named: "CTB")!, name: "CTB", food: foodtype.American, time: [mealtime.breakfast,mealtime.lunch], cost: 10)
        let four = restaurant(image: UIImage(named: "four")!, name: "Four Seasons", food: foodtype.Korean, time: [mealtime.lunch,mealtime.dinner], cost: 20)
        let koko = restaurant(image: UIImage(named: "koko")!, name: "KoKo", food: foodtype.Korean, time: [mealtime.lunch,mealtime.dinner], cost: 20)
        let plum = restaurant(image: UIImage(named: "plum")!, name: "Plum Tree", food: foodtype.Korean, time: [mealtime.lunch,mealtime.dinner], cost: 20)
        let risley = restaurant(image: UIImage(named: "risley")!, name: "Risley", food: foodtype.Dininghall, time: [mealtime.breakfast,mealtime.lunch,mealtime.dinner], cost: 14)
        let tasteofThai = restaurant(image: UIImage(named: "tasteofthai")!, name: "Taste of Thai", food: foodtype.Thai, time: [mealtime.lunch,mealtime.dinner], cost: 15)
        let tasty = restaurant(image: UIImage(named: "tasty")!, name: "De Tasty Hot Pot", food: foodtype.Chinese, time: [mealtime.lunch,mealtime.dinner], cost: 25)
        let texas = restaurant(image: UIImage(named: "texas")!, name: "Texas Roadhouse", food: foodtype.Steak, time: [mealtime.dinner,mealtime.latedinner], cost: 12)
        let trillium = restaurant(image: UIImage(named: "trillium")!, name: "Trillium", food: foodtype.Dininghall, time: [mealtime.lunch,mealtime.dinner], cost: 15)
        let layoutforcollectionview = UICollectionViewFlowLayout()
        // restaurant grid view
        
        layoutforcollectionview.scrollDirection = .vertical
        layoutforcollectionview.minimumInteritemSpacing = padding
        layoutforcollectionview.minimumLineSpacing = padding
        
        collectionview = UICollectionView(frame: .zero, collectionViewLayout: layoutforcollectionview)
        collectionview.translatesAutoresizingMaskIntoConstraints = false
        collectionview.backgroundColor = .white
        collectionview.dataSource = self
        collectionview.delegate = self
        collectionview.register(RestaurantCollectionViewCell.self, forCellWithReuseIdentifier: restaurantCellReuseIdentifier)
        // construct table view
        tableview = UITableView(frame: .zero)
        tableview.translatesAutoresizingMaskIntoConstraints = false
        tableview.backgroundColor = .white
        tableview.dataSource = self
        tableview.delegate = self
         tableview.register(RestaurantTablenViewCell.self, forCellReuseIdentifier: tableviewcellreuseidentifier)
        view.addSubview(collectionview)
        
        restaurants = [appel,CTB,four,koko,plum,risley,tasteofThai,tasty,texas,trillium]
        selectedrestaurants = [appel,CTB,four,koko,plum,risley,tasteofThai,tasty,texas,trillium]
        selectedtypes = []
        selectedtime = []
        // filter bar view
        // construct food type filter bar
        let layoutforfilterbar = UICollectionViewFlowLayout()
        layoutforfilterbar.scrollDirection = .horizontal
        layoutforfilterbar.minimumInteritemSpacing = padding/2
//        layoutforfilterbar.minimumLineSpacing = padding
        filterbar = UICollectionView(frame: .zero, collectionViewLayout: layoutforfilterbar)
        filterbar.translatesAutoresizingMaskIntoConstraints = false
        filterbar.backgroundColor = .white
        filterbar.dataSource = self
        filterbar.delegate = self
        filterbar.register(filterviewcell.self, forCellWithReuseIdentifier: filtercellreuseidentifer)
        // construct time filter bar
        let layoutfortimebar = UICollectionViewFlowLayout()
        layoutfortimebar.scrollDirection = .horizontal
        layoutfortimebar.minimumInteritemSpacing = padding/2
        timebar = UICollectionView(frame: .zero, collectionViewLayout: layoutfortimebar)
        timebar.translatesAutoresizingMaskIntoConstraints = false
        timebar.backgroundColor = .white
        timebar.dataSource = self
        timebar.delegate = self
        timebar.register(timeviewcell.self, forCellWithReuseIdentifier: timebarcellreuseidentifer)
        view.addSubview(timebar)
//        filterbar.register(HeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerReuseIdentifier)
         view.addSubview(filterbar)
        
        // navigation bar
        layouttoggle.title = "layout toggle"
        layouttoggle.tintColor = .blue
        layouttoggle.target = self
        layouttoggle.action = #selector(changetoggle)
         self.navigationItem.rightBarButtonItem = layouttoggle
        search.translatesAutoresizingMaskIntoConstraints = false
        search.delegate = self
        search.enablesReturnKeyAutomatically = false
        view.addSubview(search)
        
        
        setupConstraints()
    }
    func setupConstraints() {
        NSLayoutConstraint.activate([
            filterbar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            filterbar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            filterbar.heightAnchor.constraint(equalToConstant: 30),
            filterbar.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ])
        NSLayoutConstraint.activate([
            timebar.topAnchor.constraint(equalTo: filterbar.bottomAnchor),
            timebar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            timebar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            timebar.heightAnchor.constraint(equalToConstant: 30)
            ])
        NSLayoutConstraint.activate([
            search.topAnchor.constraint(equalTo: timebar.bottomAnchor),
            search.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            search.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            search.heightAnchor.constraint(equalToConstant: 40)
            ])
        NSLayoutConstraint.activate([
            collectionview.topAnchor.constraint(equalTo: search.bottomAnchor),
            collectionview.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionview.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionview.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ])
        
    }
    // an ovarall function that handles reloaddata
    // list1 is after exmaing foodtype
    // list2 is after examing searching
    // list3 is after examing time
    func reloadData(){
        selectedrestaurants = []
        var list1: [restaurant] = []
        var list2 : [restaurant] = []
        var list3 : [restaurant] = []
        // check if comply with food type
        for i in restaurants{
            if selectedtypes != []{
            for j in selectedtypes{
                if ("\(i.food)" == j){
                    if list1.firstIndex(where: {$0 === i}) == nil{
                         list1.append(i)}
                    }
                   
                }}
            else{
                list1 = restaurants
            }
        }
        // check if comply with search bar
        
           if searchtext == nil || searchtext == "" {
            list2 = list1
           }
           else{
            
            for i in list1{
                if i.name.range(of: searchtext!) != nil{
                    if list2.firstIndex(where: {$0 === i}) == nil{
                        list2.append(i)}
                   
                }
            }
            
        }
        // check time
        for i in list2{
            if selectedtime != []{
                for j in selectedtime{
                    for k in i.time{
                    if ("\(k)" == j){
                        if list3.firstIndex(where: {$0 === i}) == nil{
                            list3.append(i)}
                      
                        }  }}}
            else{
                list3 = list2
            }
        }
        selectedrestaurants = list3
        self.tableview.reloadData()
        self.collectionview.reloadData()
    
       
}
    @objc func changetoggle(){
        var fromView: UIView
        var toView: UIView
        if (self.tableview.superview == self.view)
        {
            fromView = self.tableview;
             toView = self.collectionview;
            toView.frame = self.view.bounds;
            self.view.addSubview(toView)
            fromView.removeFromSuperview()
            NSLayoutConstraint.activate([
                collectionview.topAnchor.constraint(equalTo: search.bottomAnchor),
                collectionview.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                collectionview.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                collectionview.trailingAnchor.constraint(equalTo: view.trailingAnchor)
                ])
        }
        else
        {
             fromView = self.collectionview;
           toView = self.tableview;
            toView.frame = self.view.bounds;
            fromView.removeFromSuperview()
            self.view.addSubview(toView)
            NSLayoutConstraint.activate([
                tableview.topAnchor.constraint(equalTo: search.bottomAnchor),
                tableview.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                tableview.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                tableview.trailingAnchor.constraint(equalTo: view.trailingAnchor)
                ])
        }
        
    

}
}

extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == collectionview{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: restaurantCellReuseIdentifier, for: indexPath) as! RestaurantCollectionViewCell
        let singlerestaurant = selectedrestaurants[indexPath.item]
        cell.configure(for: singlerestaurant)
           return cell
        }
        else if collectionView == filterbar{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: filtercellreuseidentifer, for: indexPath) as! filterviewcell
            let type = restauranttypes[indexPath.item]
            cell.configure(for: "\(type)")
            cell.delegate = self
            return cell
        }
        else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: timebarcellreuseidentifer, for: indexPath) as! timeviewcell
            let time = timeslots[indexPath.item]
            cell.configure(for: "\(time)")
            cell.delegate = self
            return cell
        }
        
    }
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collectionview{
            return selectedrestaurants.count}
        else if collectionView == filterbar{
            return restauranttypes.count
        }
        else{
            return timeslots.count
        }
    }
    
//    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//
//        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerReuseIdentifier, for: indexPath)
//        if collectionView != filterbar{
//            headerView.frame.size.height = 0.0
//            headerView.frame.size.width = 0.0
//        }
//        return headerView
//        }
//
//
    
}





extension ViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == collectionview{
        let length = (collectionView.frame.width - padding * 3-10) / 2.0
        return CGSize(width: length, height: length)
        
        }
        else if collectionView == filterbar{
            let length = (collectionView.frame.width - padding * 3) / 3.0
            return CGSize(width: length, height: 30)
        }
        else{
            let length = (collectionView.frame.width - padding * 3) / 3.0
            return CGSize(width: length, height: 30)
        }
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
//        return CGSize(width: collectionView.frame.width, height: headerHeight)
//    }
   
}
extension ViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == collectionview{
           
        let restaurant = restaurants[indexPath.row]
        let ViewController = DetailViewController(restaurant: restaurant)
        navigationController?.pushViewController(ViewController, animated: true)
        }
        
        
    }
    
}
//  which food button clicked?
extension ViewController: FoodtypeDelegate {
    func FoodtypeChanged(to type: String, insert: Bool) {
        // choose a category
        if insert{
            selectedtypes.append(type)
            
        }
        
            // deselect a category
        else{
           let index = selectedtypes.firstIndex(of: type)
            selectedtypes.remove(at: index!)
        }
        self.reloadData()
    }
    
    
   
}
// which time button clicked?
extension ViewController: TimeDelegate {
    func timeChanged(to type: String, insert: Bool) {
        // choose a category
        if insert{
            selectedtime.append(type)
            
        }
            // deselect a category
        else{
            let index = selectedtime.firstIndex(of: type)
            selectedtime.remove(at: index!)
        }
        self.reloadData()
    }
    
    
    
}
// tableview stuff
extension ViewController: UITableViewDataSource {
    
    /// Tell the table view how many rows should be in each section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedrestaurants.count
    }
    
    /// Tell the table view what cell to display for each row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableviewcellreuseidentifier, for: indexPath)as! RestaurantTablenViewCell
        let restaurant = selectedrestaurants[indexPath.row]
        cell.configure(for: restaurant)
        return cell
    }
    
    
    
}
extension ViewController: UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 5*padding
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let restaurant = selectedrestaurants[indexPath.row]
        let ViewController = DetailViewController(restaurant: restaurant)
        navigationController?.pushViewController(ViewController, animated: true)
    }
    
    
    
}

extension ViewController: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
        self.searchtext = searchBar.text
       self.reloadData()
}

}
