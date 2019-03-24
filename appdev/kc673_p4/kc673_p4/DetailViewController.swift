//
//  DetailViewController.swift
//  kc673_p4
//
//  Created by kaishuo cheng on 3/23/19.
//  Copyright © 2019 Cornell AppDev. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    var songname: UILabel
    var nametext: UITextField
    var artist: UILabel
    var artisttext: UITextField
    var album: UILabel
    var albumtext: UITextField
    var song: Song
    var save: UIButton
    var valid: UILabel
    var imagelabel: UILabel!
    var imagenum : UITextField!
    var num: UILabel!
    let imagecount = 7

    weak var delegate: ChangesongtextDelegate?
    init(song: Song, image: Int){
        self.songname = UILabel()
        self.songname.text = "songname:"
        self.artist = UILabel()
        self.artist.text = "artist:"
        self.album = UILabel()
        self.album.text = "album:"
        self.nametext = UITextField()
        self.nametext.text = song.songname
        
        imagenum = UITextField()
        imagenum.text = "\(image)"
        self.artisttext = UITextField()
        self.artisttext.text = song.artist[0]
        
        if song.artist.count > 1{
            var new = song.artist
            new.remove(at: 0)
            for x in new{
                artisttext.text?.append(contentsOf: ", \(x)")
            }
        }
        self.albumtext = UITextField()
        self.albumtext.text = song.album
        self.song = song
        save = UIButton()
        valid = UILabel()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        songname.translatesAutoresizingMaskIntoConstraints = false
        nametext.translatesAutoresizingMaskIntoConstraints = false
        artist.translatesAutoresizingMaskIntoConstraints = false
        artisttext.translatesAutoresizingMaskIntoConstraints = false
        albumtext.translatesAutoresizingMaskIntoConstraints = false
        album.translatesAutoresizingMaskIntoConstraints = false
        valid.text = "Separate different artists by comma "
        valid.translatesAutoresizingMaskIntoConstraints = false
        valid.textColor = .red
        
        save.setTitle("save", for: .normal)
        
        save.addTarget(self, action: #selector(changetext), for: .touchUpInside)
        save.translatesAutoresizingMaskIntoConstraints = false
        save.backgroundColor = .blue
        imagelabel = UILabel()
        imagelabel.text = "image: "
        imagelabel.translatesAutoresizingMaskIntoConstraints = false
        imagenum.translatesAutoresizingMaskIntoConstraints = false
        num = UILabel()
        num.text = "type in a number from 0 to 6 to change picture"
        num.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(songname)
        view.addSubview(nametext)
        view.addSubview(artisttext)
        view.addSubview(artist)
        view.addSubview(album)
        view.addSubview(albumtext)
        view.addSubview(valid)
        view.addSubview(save)
        view.addSubview(imagelabel)
        view.addSubview(imagenum)
       view.addSubview(num)
       
        setupconstraints()

        // Do any additional setup after loading the view.
    }
    func setupconstraints(){
        NSLayoutConstraint.activate([
            songname.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            songname.topAnchor.constraint(equalTo: view.topAnchor, constant: 40),
            songname.heightAnchor.constraint(equalToConstant: 50)
            ])
        NSLayoutConstraint.activate([
            nametext.leadingAnchor.constraint(equalTo: songname.trailingAnchor, constant: 40),
            nametext.topAnchor.constraint(equalTo: view.topAnchor, constant: 40),
            nametext.heightAnchor.constraint(equalToConstant: 50)
            ])
        NSLayoutConstraint.activate([
            artist.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            artist.topAnchor.constraint(equalTo: songname.bottomAnchor, constant: 20),
            artist.heightAnchor.constraint(equalToConstant: 50)
            ])
        NSLayoutConstraint.activate([
            artisttext.leadingAnchor.constraint(equalTo: artist.trailingAnchor, constant: 40),
            artisttext.topAnchor.constraint(equalTo: nametext.bottomAnchor, constant: 20),
            artisttext.heightAnchor.constraint(equalToConstant: 50)
            ])
        NSLayoutConstraint.activate([
            album.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            album.topAnchor.constraint(equalTo: artist.bottomAnchor, constant: 20),
            album.heightAnchor.constraint(equalToConstant: 20)
            ])
        NSLayoutConstraint.activate([
            albumtext.leadingAnchor.constraint(equalTo: album.trailingAnchor, constant: 30),
           albumtext.topAnchor.constraint(equalTo: artisttext.bottomAnchor, constant: 20),
            albumtext.heightAnchor.constraint(equalToConstant: 20)
            ])
        NSLayoutConstraint.activate([
            imagelabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            imagelabel.topAnchor.constraint(equalTo: album.bottomAnchor, constant: 30),
            imagelabel.heightAnchor.constraint(equalToConstant: 30),
            
            
            ])
        NSLayoutConstraint.activate([
            imagenum.leadingAnchor.constraint(equalTo: imagelabel.trailingAnchor, constant: 30),
            imagenum.topAnchor.constraint(equalTo: imagelabel.topAnchor),
            imagenum.heightAnchor.constraint(equalToConstant: 30)
            ])
        NSLayoutConstraint.activate([
            save.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            save.topAnchor.constraint(equalTo: imagelabel.bottomAnchor, constant: 30),
            save.heightAnchor.constraint(equalToConstant: 30),
            
            
            ])
        
        NSLayoutConstraint.activate([
            valid.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            valid.topAnchor.constraint(equalTo: save.bottomAnchor, constant: 10),
            valid.heightAnchor.constraint(equalToConstant: 50)
            ])
        NSLayoutConstraint.activate([
            num.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            num.topAnchor.constraint(equalTo: valid.bottomAnchor, constant: 10),
            valid.heightAnchor.constraint(equalToConstant: 50)
            ])
        
        
    }
    @objc func changetext(){
        
        if let name = nametext.text , let artist = artisttext.text, let album = albumtext.text, let images = imagenum.text{
            if (name != "" && artist != "" && album != "" && artist.first != "," && Int(images)! < imagecount){
                let artistlist = artist.components(separatedBy: ",")
                delegate?.TextChanged(to: name, artist: artistlist, album: album, image: Int(images)!, song:  song)
            dismiss(animated: true, completion: nil)
            }
            else{
                valid.text = "Input Not Valid"
                valid.textColor = .red
            }
        }
        
        
        
    }
    


}
