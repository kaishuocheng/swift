//
//  ViewController.swift
//  kc673_p4
//
//  Created by kaishuo cheng on 3/21/19.
//  Copyright © 2019 Cornell AppDev. All rights reserved.
//

import UIKit
import AVKit

protocol ChangesongtextDelegate: class {
    func TextChanged(to name: String, artist: [String], album: String, image: Int, song: Song)
}
class ViewController: UIViewController {
    var songs : [Song]!
    var tableView: UITableView!
    let reuseIdentifier = "songlistCellReuse"
    let cellHeight: CGFloat = 60
    let cs = UIImage(named: "countingstars")
    let ra = UIImage(named: "ra")
    let nd = UIImage(named: "nd")
    let fs = UIImage(named:"fs")
    let om = UIImage(named:"om")
    let sl = UIImage(named: "sl")
    let wy = UIImage(named: "wy")
    var images : [UIImage]!
    var add : UIButton!
    var play: UIButton!
    var nextsong: UIButton!
    var current : Int!
    var player: AVPlayer!
    var urllist : [URL]!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Song List"
        view.backgroundColor = .white

        let CountingStars = Song(songname: "Counting Stars", artist: ["OneRepublic"], album: "Native", image: cs!)
        let Radioactive = Song(songname: "Radioactive", artist: ["Imagine Dragons"], album: "Night Visions", image: ra!)
        let NewDivide = Song(songname: "New Divide", artist: ["Likin Park"], album: "Transformers: Revenge of the Fallen", image: nd!)
        let Flightofthesivilbird = Song(songname: "Flight of the Silverbird", artist: ["Two Steps From Hell"], album: "Bettlecry", image: fs!)
        let Onmyown = Song(songname: "On My Own", artist: ["Ashes Remain"], album: "What I've Become", image: om!)
        let Someonelikeyou = Song(songname: "Someone Like You", artist: ["Adele"], album: "Someone Like You", image: sl!)
        let Weareyoung = Song(songname: "We Are Young", artist: ["Fun", "Janelle Monáe"], album: "Some Nights", image: wy!)
        let Battlebone = Song(songname: "Battlebone", artist: ["Two Steps From Hell"], album: "Bettlecry", image: fs!)
        let Victory = Song(songname: "Victory", artist: ["Two Steps From Hell"], album: "Bettlecry", image: fs!)
        let Forthewin = Song(songname: "For The Win", artist: ["Two Steps From Hell"], album: "Sky World", image: fs!)
        images = [cs,ra,nd,fs,om,sl,wy] as? [UIImage]
        
        songs = [CountingStars,Radioactive,NewDivide, Flightofthesivilbird, Onmyown, Someonelikeyou, Weareyoung, Battlebone, Victory, Forthewin]
        // Initialize tableView
        
        add = UIButton()
        add.setTitle("add", for: .normal)
        add.backgroundColor = .red
        add.translatesAutoresizingMaskIntoConstraints = false
        add.addTarget(self, action: #selector(addsong), for: .touchUpInside)
        tableView = UITableView(frame: .zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(PlaylistTableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.allowsSelectionDuringEditing = true
        play = UIButton()
        play.setTitle("play", for: .normal)
        play.backgroundColor = .red
        nextsong = UIButton()
        nextsong.setTitle("next", for: .normal)
        play.translatesAutoresizingMaskIntoConstraints = false
        nextsong.translatesAutoresizingMaskIntoConstraints = false
       self.tableView.isEditing = true
        current = 0
        view.addSubview(tableView)
        view.addSubview(add)
        view.addSubview(play)
        play.addTarget(self, action: #selector(playmusic), for: .touchUpInside)
        urllist = []
        urllist.append(URL.init(string: "http://www.largesound.com/ashborytour/sound/AshboryBYU.mp3")!)
        setupConstraints()
    }
    
    func setupConstraints() {
        // Setup the constraints for our views
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50)
            ])
        NSLayoutConstraint.activate([
            add.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            add.topAnchor.constraint(equalTo: view.bottomAnchor, constant: -50)
            ])
        NSLayoutConstraint.activate([
            play.leadingAnchor.constraint(equalTo: add.trailingAnchor, constant: 40),
            play.topAnchor.constraint(equalTo: view.bottomAnchor, constant: -50)
            ])
    
    }
    @objc func addsong(){
        var song: Song
     song = Song(songname: "new", artist: ["new"], album: "new", image: cs!)
        songs.append(song)
       tableView.reloadData()
        
    }
    @objc func playmusic(){
        let playeritem = AVPlayerItem(url: urllist[current])
        player = AVPlayer(playerItem: playeritem)
//        let playerLayer = AVPlayerLayer(player: player!)
//        playerLayer.frame = CGRect(x: 0, y: 0, width: 10, height: 50)
//        self.view.layer.addSublayer(playerLayer)
        player.play()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ViewController: UITableViewDataSource {
    
    /// Tell the table view how many rows should be in each section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }
    
    /// Tell the table view what cell to display for each row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! PlaylistTableViewCell
        let song = songs[indexPath.row]
        cell.configure(for: song)
        cell.selectionStyle = .none
        
        return cell
    }
     func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }

     func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let moved = songs[sourceIndexPath.row]
        songs.remove(at: sourceIndexPath.row)
        songs.insert(moved, at: destinationIndexPath.row)
        tableView.reloadData()
    }
    
}

extension ViewController: UITableViewDelegate {
    
   
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        let cell = tableView.cellForRow(at: indexPath) as! PlaylistTableViewCell
        let song = songs[indexPath.row]
        let detailview = DetailViewController(song: song, image: images.firstIndex(of: song.image)!)
        detailview.delegate = self
        present(detailview,animated: true,completion: nil)
    }
    
    /// Tell the table view what should happen if we deselect a row
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            let song = songs[indexPath.row]
            if let index = songs.firstIndex(where: {$0 === song}){
            songs.remove(at: index)
            tableView.reloadData()
            }}
    }
    
}
extension  ViewController: ChangesongtextDelegate{
    func TextChanged(to name: String, artist: [String], album: String, image: Int, song: Song) {
        
        song.songname = name
        song.artist = artist
        song.album = album
        song.image = images[image]
        tableView.reloadData()
        
    }
    

    }

