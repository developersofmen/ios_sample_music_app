//
//  AlbumDetailsViewController.swift
//  SampleMusicApp
//
//  Created by Mayank Jain on 27/06/22.
//

import UIKit

class AlbumDetailsViewController: UIViewController, UIGestureRecognizerDelegate {
    
    var albumDetails: Result?
    
    let mainContainerScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = UIColor.systemBackground
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    let mainContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.systemBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let containerForPillView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.systemBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let albumLergeThumnailView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let albumDetailsView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let musicThumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let subTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.init(red: 142/255.0, green: 142/255.0, blue: 147/255.0, alpha: 1.0)
        label.font = UIFont.SFProText(.regular, size: 18)
        label.text = ""
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    let musicTitleLabel: UILabel = {
        let label = UILabel()
        //using default text color, so that it will work in dark mode too
        label.font = UIFont.SFProText(.bold, size: 34)
        label.numberOfLines = 0
        label.text = ""
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let visitAlbumButton: UIButton = {
        let button = UIButton()
        button.setTitle("Visit The Album", for: .normal)
        button.titleLabel?.font = UIFont.SFProText(.semibold, size: 16)
        button.setTitleColor(UIColor.systemBackground, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor.init(red: 0/255.0, green: 122/255.0, blue: 255/255.0, alpha: 1.0)
        button.layer.cornerRadius = 10
        return button
    }()

    let copyRightInfoLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.init(red: 181/255.0, green: 181/255.0, blue: 181/255.0, alpha: 1.0)
        label.font = UIFont.SFProText(.medium, size: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .center

        return label
    }()
    
    let releasedInfoLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.init(red: 181/255.0, green: 181/255.0, blue: 181/255.0, alpha: 1.0)
        label.font = UIFont.SFProText(.medium, size: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    let pillView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.init(red: 0/255.0, green: 122/255.0, blue: 255/255.0, alpha: 1.0).cgColor
        return view
    }()
    
    let genreLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.init(red: 0/255.0, green: 122/255.0, blue: 255/255.0, alpha: 1.0)
        label.font = UIFont.SFProText(.medium, size: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    
    let bottomContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemBackground
        return view
    }()
    
    
    //MARK: ViewController life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.barStyle = .black

        self.addCustomBackButton()
        self.addAllSubviews()
        
        //setup navigation swipe to delete
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    
    //MARK: Private method
    func addAllSubviews() {
        
        self.view.addSubview(self.mainContainerScrollView)
        self.view.addSubview(self.bottomContainerView)
        self.musicThumbnailImageView.clipsToBounds = true

        self.mainContainerScrollView.addSubview(self.mainContainerView)

        self.mainContainerView.addSubview(self.albumLergeThumnailView)
        self.mainContainerView.addSubview(self.albumDetailsView)
        
        self.albumLergeThumnailView.addSubview(self.musicThumbnailImageView)
        
        self.albumDetailsView.addSubview(self.subTitleLabel)
        self.albumDetailsView.addSubview(self.musicTitleLabel)
        self.albumDetailsView.addSubview(self.containerForPillView)

        self.pillView.addSubview(self.genreLabel)
        self.containerForPillView.addSubview(self.pillView)
        
        self.bottomContainerView.addSubview(self.visitAlbumButton)
        self.bottomContainerView.addSubview(self.copyRightInfoLabel)
        self.bottomContainerView.addSubview(self.releasedInfoLabel)
        
        self.addViewsConstraint()
    }
    
    override func actionBackNavButton() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func onClickAppStoreVisitBtn(_ sender : UIButton) {
        if let _albumDetails = albumDetails {
            if let url = URL(string: _albumDetails.artistUrl ?? "") {
                UIApplication.shared.open(url)
            }
        }
    }
}

extension AlbumDetailsViewController {
    
    func addViewsConstraint() {
        
        self.bottomContainerView.addConstraints(
            [
                equal(self.view, \.leftAnchor),
                equal(self.view, \.rightAnchor),
                equal(self.view, \.bottomAnchor),
                equal(\.heightAnchor, to: 150.0)
            ]
        )
        
        self.mainContainerScrollView.addConstraints(
            [
                equal(self.view, \.leftAnchor),
                equal(self.view, \.topAnchor),
                equal(self.view, \.rightAnchor),
                equal(self.bottomContainerView, \.bottomAnchor, \.topAnchor, constant: 0.0)
            ]
        )
        
        let scg = self.mainContainerScrollView.contentLayoutGuide
        self.mainContainerScrollView.contentInsetAdjustmentBehavior = .never
        
        NSLayoutConstraint.activate([
            self.mainContainerView.topAnchor.constraint(equalTo: scg.topAnchor, constant: 0.0),
            self.mainContainerView.leadingAnchor.constraint(equalTo: scg.leadingAnchor, constant: 0.0),
            self.mainContainerView.trailingAnchor.constraint(equalTo: scg.trailingAnchor, constant: 0.0),
            self.mainContainerView.bottomAnchor.constraint(equalTo: scg.bottomAnchor, constant: 0.0),
        
            self.mainContainerView.widthAnchor.constraint(equalTo: self.mainContainerScrollView.frameLayoutGuide.widthAnchor, constant: 0.0),

            ])
        
        self.mainContainerView.addConstraints(
            [
                equal(self.albumDetailsView, \.bottomAnchor, \.bottomAnchor, constant:(0)),
            ]
        )
        
        self.albumLergeThumnailView.addConstraints(
            [
                equal(self.mainContainerView, \.leftAnchor),
                equal(self.mainContainerView, \.topAnchor),
                equal(self.mainContainerView, \.rightAnchor),
                equal(self.view, \.heightAnchor, \.heightAnchor, ratio: 0.5)
            ]
        )
    
        self.albumDetailsView.addConstraints(
            [
                equal(self.view, \.leftAnchor),
                equal(self.view, \.rightAnchor),
                equal(self.albumLergeThumnailView, \.topAnchor, \.bottomAnchor, constant: 0),
                equal(self.containerForPillView, \.bottomAnchor, \.bottomAnchor, constant: 0)

            ]
        )
        
        self.musicThumbnailImageView.addConstraints(
            [
                equal(self.albumLergeThumnailView, \.leftAnchor),
                equal(self.albumLergeThumnailView, \.topAnchor),
                equal(self.albumLergeThumnailView,  \.bottomAnchor),
                equal(self.albumLergeThumnailView,  \.rightAnchor)
            ]
        )
        self.subTitleLabel.addConstraints(
            [
                equal(self.albumDetailsView, \.leftAnchor, constant:(16)),
                equal(self.albumDetailsView, \.topAnchor, constant:(12)),
                equal(self.albumDetailsView, \.rightAnchor, constant:(-16)),
            ]
        )
        
        self.musicTitleLabel.addConstraints(
            [
                equal(self.albumDetailsView, \.leftAnchor, constant:(14)),
                equal(self.albumDetailsView, \.rightAnchor, constant:(-16)),
                equal(self.subTitleLabel, \.topAnchor, \.bottomAnchor, constant: -1)
            ]
        )
        
        self.containerForPillView.addConstraints(
            [
                equal(self.albumDetailsView, \.leftAnchor, constant:(0)),
                equal(self.albumDetailsView, \.rightAnchor, constant:(0)),
                equal(self.musicTitleLabel, \.topAnchor, \.bottomAnchor, constant:(5)),
                equal(\.heightAnchor, to: 50.0)
            ]
        )

        
        self.pillView.addConstraints(
            [
                equal(self.containerForPillView, \.leftAnchor, constant:(16)),
            ]
        )
        
        self.genreLabel.addConstraints(
            [
                equal(self.pillView, \.leftAnchor, constant:(5)),
                equal(self.pillView, \.rightAnchor, constant:(-5)),
                equal(self.pillView, \.topAnchor, constant:(5)),
                equal(self.pillView, \.bottomAnchor, constant:(-5)),
            ]
        )
        
        self.visitAlbumButton.addConstraints(
            [
                equal(self.bottomContainerView, \.bottomAnchor, constant:(-45)),
                equal(\.heightAnchor, to: 45),
                equal(\.widthAnchor, to: 155),
                equal(self.bottomContainerView, \.centerXAnchor)
            ]
        )

        self.copyRightInfoLabel.addConstraints(
            [
                equal(self.bottomContainerView, \.leftAnchor, constant:(16)),
                equal(self.bottomContainerView, \.rightAnchor, constant:(-16)),
                equal(self.visitAlbumButton, \.bottomAnchor, \.topAnchor, constant:(-20)),

            ]
        )

        self.releasedInfoLabel.addConstraints(
            [
                equal(self.bottomContainerView, \.leftAnchor, constant:(16)),
                equal(self.bottomContainerView, \.rightAnchor, constant:(-16)),
                equal(self.copyRightInfoLabel, \.bottomAnchor, \.topAnchor, constant:(-5)),

            ]
        )
        setupViewValue()
    }
    
    func setupViewValue() {
        
        if let _albumDetails = albumDetails {
            
            //replacing 100X100 with 500X500 for high resolution images
            let largeImage = _albumDetails.artworkUrl100?.replacingOccurrences(of: "100x100", with: "500x500") ?? ""
            
            self.musicThumbnailImageView.imageFromServerURL(urlString: largeImage)
            
            self.musicTitleLabel.text = (_albumDetails.name ?? "")
            self.subTitleLabel.text = _albumDetails.artistName ?? ""
            
            self.copyRightInfoLabel.text = DataBaseManager.getAlbumCopyright()
            self.releasedInfoLabel.text =  "Released " +  (_albumDetails.releaseDate?.getDate("yyyy-MM-dd").toLocalStringWithFormat(dateFormat: "MMM dd, yyyy") ?? "")
            
            if let genre = _albumDetails.toGenre?.allObjects.first as? Genre {
                self.genreLabel.text = genre.name
            }
                    
            self.visitAlbumButton.addTarget(self, action: #selector(AlbumDetailsViewController.onClickAppStoreVisitBtn(_:)), for: .touchUpInside)

        }
    }
    
}
