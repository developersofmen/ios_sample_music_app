//
//  AlbumCollectionViewCell.swift
//  SampleMusicApp
//
//  Created by Mayank Jain on 27/06/22.
//

import UIKit

class AlbumCollectionViewCell: UICollectionViewCell {
    
    private let cornerRadius = 15.0
    
    let musicThumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 15
        return imageView
    }()
    
    let alphaView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let subTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray
        label.font = UIFont.SFProText(.medium, size: 12)
        label.text = ""
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        return label
    }()
    
    let musicTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        label.font = UIFont.SFProText(.semibold, size: 16)
        label.text = ""
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 4
        return label
    }()
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.layer.cornerRadius = cornerRadius
        self.clipsToBounds = true
        self.addViews()
    }
    
    func configureCell(result: Result?) {
        if let resultNotNull = result {
        self.musicTitleLabel.text = (resultNotNull.name ?? "").uppercased()
        self.subTitleLabel.text = resultNotNull.artistName ?? ""
        
        //replacing 100X100 with 300X300 for better resolution images
        self.musicThumbnailImageView.imageFromServerURL(urlString: resultNotNull.artworkUrl100?.replacingOccurrences(of: "100x100", with: "300x300") ?? "")
        }
    }
}

extension AlbumCollectionViewCell {
    
    func addViews(){
        self.addSubview(self.musicThumbnailImageView)
        self.addSubview(alphaView)
        self.addSubview(subTitleLabel)
        self.addSubview(musicTitleLabel)
        self.addViewsConstraint()
        self.setGradientBackground()
    }
    
    func addViewsConstraint() {
        
        self.musicThumbnailImageView.addConstraints(
            [
                equal(self, \.leftAnchor),
                equal(self, \.topAnchor),
                equal(self, \.rightAnchor),
                equal(self, \.bottomAnchor)
            ]
        )
        
        self.subTitleLabel.addConstraints(
            [
                equal(self,  \.bottomAnchor, constant: -12),
                equal(self, \.rightAnchor, constant: -12),
                equal(self, \.leftAnchor, constant: 12),
            ]
        )
        
        self.musicTitleLabel.addConstraints(
            [
                equal(self, \.rightAnchor, constant: -12),
                equal(self, \.leftAnchor, constant: 12),
                equal(self.subTitleLabel, \.bottomAnchor, \.topAnchor, constant: -1)
            ]
        )
        self.alphaView.addConstraints(
            [
                equal(self, \.rightAnchor),
                equal(self, \.leftAnchor),
                equal(self, \.bottomAnchor),
                equal(self, \.topAnchor),
                
            ]
        )
    }
}

extension AlbumCollectionViewCell {
    func setGradientBackground() {
        DispatchQueue.main.async {
            self.alphaView.removeSublayer()
            let colorTop =  UIColor.black.withAlphaComponent(0.0).cgColor
            let colorBottom = UIColor.black.withAlphaComponent(0.9).cgColor
            let gradientLayer = CAGradientLayer()
            gradientLayer.colors = [colorTop, colorBottom]
            gradientLayer.locations = [0.0,1.0]
            gradientLayer.frame = self.alphaView.bounds
            self.alphaView.layer.insertSublayer(gradientLayer, at:0)
        }
    }
}
