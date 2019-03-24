//
//  PlaylistTableViewCell.swift
//  kc673_p4
//
//  Created by kaishuo cheng on 3/21/19.
//  Copyright © 2019 Cornell AppDev. All rights reserved.
//

import UIKit
import AVKit
class PlaylistTableViewCell: UITableViewCell {
    var songimage: UIImageView!
    var songname : UILabel!
    var artist: UILabel!
    var album : UILabel!
//    var play: UIButton!
    let padding: CGFloat = 10
    let labelHeight: CGFloat = 16
    let ImageWidth: CGFloat = 20
    let ImageHeight: CGFloat = 20
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        songname = UILabel()
        songname.translatesAutoresizingMaskIntoConstraints = false
        songname.font = UIFont.systemFont(ofSize: 14)
        contentView.addSubview(songname)
        
        artist = UILabel()
        artist.translatesAutoresizingMaskIntoConstraints = false
        artist.font = UIFont.systemFont(ofSize: 14)
        contentView.addSubview(artist)
        
        album = UILabel()
        album.translatesAutoresizingMaskIntoConstraints = false
        album.font = UIFont.systemFont(ofSize: 12)
        contentView.addSubview(album)
        
        songimage = UIImageView()
        songimage.translatesAutoresizingMaskIntoConstraints = false
        songimage.isHidden = false
        songimage.contentMode = .scaleAspectFit
//        play = UIButton()
//        play.setTitle("play", for: .normal)
//        play.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(songimage)
//        contentView.addSubview(play)
        
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupConstraints() {
        NSLayoutConstraint.activate([
            songname.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            songname.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            songname.heightAnchor.constraint(equalToConstant: labelHeight)
            ])
        
        NSLayoutConstraint.activate([
            artist.leadingAnchor.constraint(equalTo: songname.leadingAnchor),
            artist.topAnchor.constraint(equalTo: songname.bottomAnchor),
            artist.heightAnchor.constraint(equalTo: songname.heightAnchor)
            ])
        NSLayoutConstraint.activate([
            album.leadingAnchor.constraint(equalTo: artist.leadingAnchor),
            album.topAnchor.constraint(equalTo: artist.bottomAnchor),
            album.heightAnchor.constraint(equalTo: artist.heightAnchor)
            ])
        
        NSLayoutConstraint.activate([
            songimage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: padding * -1),
            songimage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            songimage.heightAnchor.constraint(equalToConstant: ImageHeight),
            songimage.widthAnchor.constraint(equalToConstant: ImageWidth)
            ])
//        NSLayoutConstraint.activate([
//            play.trailingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: -20),
//            play.heightAnchor.constraint(equalToConstant: ImageHeight),
//
//            ])
    }
    func configure(for song: Song) {
        songname.text = song.songname
       
        album.text = song.album
        songimage.image = song.image
        
        artist.text = song.artist[0]
        if song.artist.count > 1{
            var new = song.artist
            new.remove(at: 0)
            for x in new{
            artist.text?.append(contentsOf: " and \(x)")
        }
        }
        
        /////need implemented
        
    }
//    @IBAction func playmusic(sender: UIButton){
//        let cell = sender.superview as! UITableViewCell
//        cell.
//    }
//
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
class Song {
    
    var songname: String
    var artist: [String]
    var album: String
    var image: UIImage
    
    init(songname: String, artist: [String],album: String,image: UIImage) {
        self.songname = songname
        self.artist = artist
        self.album = album
        self.image = image
        
    }
    
}
