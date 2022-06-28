//
//  AlbumListViewController.swift
//  SampleMusicApp
//
//  Created by Mayank Jain on 27/06/22.
//

import UIKit
import CoreData

class AlbumListViewController: UIViewController {
    
    //MARK: Private constants
    private let albumCellIdentifier = "AlbumCollectionViewCell"
    private let navigationHeaderTitle = "Top 100 Albums"
    private let cellLeftPadding = 16.0
    private let cellRightPadding = 16.0
    private let cellTopSectionPadding = 10.0
    private let cellBottomPadding = 0.0
    private let cellSpacing = 12.0
    private let numberOfCellsIncolumn = 2
    
    
    //MARK: Private variables
    private var albumViewModel = AlbumViewModel()
    private var albumCollectionView: UICollectionView!
    
    private var albumData:Album?
    
    //Remove the left,right padding and spacing from view width and divide by numberOfCellsIncolumn to get the width and height for the cell.
    //Width and height will be same for the square shape of the cell
    private var cellWidthAndHeight: Double {
        return (UIScreen.width - cellLeftPadding - cellRightPadding - (cellSpacing * Double(numberOfCellsIncolumn - 1))) / Double(numberOfCellsIncolumn)
    }
    
    /// Adding refreshControl to show while pull to refresh
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(AlbumListViewController.handleRefresh(_:)), for: UIControl.Event.valueChanged)
        refreshControl.tintColor = UIColor.gray
        return refreshControl
    }()
    
    //MARK: ViewController life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        self.navigationItem.title = navigationHeaderTitle
        self.configureCollectionView()
        
        //On launch show data from local DB, untill refresh data from network
        self.displayDataFromDB()
        
        //Refresh data from network api
        self.syncDataFromNetwork()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.barStyle = .default
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        //adjust autolayout mask when view is ready
        self.albumCollectionView.addConstraints(equalToSuperview(with: .zero, pinBottomToSafeArea: false, pinTopToSafeArea: true))
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        self.view.backgroundColor = .systemBackground
    }
    
    //MARK: Private methods
    /// setup collectionview
    func configureCollectionView(){
        
        //create layout for the cell
        self.configureCollectionViewLayout()
        
        //configure collectionview
        self.albumCollectionView.register(AlbumCollectionViewCell.self, forCellWithReuseIdentifier: albumCellIdentifier)
        self.albumCollectionView.delegate = self
        self.albumCollectionView.dataSource = self
        self.albumCollectionView.backgroundColor = .systemBackground
        self.view.addSubview(self.albumCollectionView)
        self.albumCollectionView.addSubview(self.refreshControl)
    }
    
    override func actionRightNavButton(sender: UIButton) {
        self.syncDataFromNetwork()
    }
    
    //create layout for the cell
    func configureCollectionViewLayout() {
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: cellTopSectionPadding, left: cellLeftPadding, bottom: 0.0, right: cellRightPadding)
        layout.itemSize = CGSize(width: cellWidthAndHeight, height: cellWidthAndHeight)
        layout.minimumLineSpacing = cellSpacing
        layout.minimumInteritemSpacing = cellSpacing
        self.albumCollectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
    }
    
    /// load data from db and show on UI
    func displayDataFromDB() {
        self.albumData = self.albumViewModel.getAlbumDataFromDB()
        self.albumCollectionView.reloadData()
    }
    
    /// refresh data on pull
    /// - Parameter refreshControl: refreshControl
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        self.syncDataFromNetwork()
    }
    
    /// sync data by calling network api
    func syncDataFromNetwork() {
        //Only show loader when there is no data on UI
        //Else refresh data without showing loader to user
        
        if let totalAlbums = self.albumData?.toResult {
            if totalAlbums.count < 1 {
                self.startLoader()
            }
        }
        else {
            self.startLoader()
        }
        
        self.albumViewModel.fetchAndRefreshAlbumData { album in
            self.stopLoaders()
            guard album != nil else { return }
            self.albumData = album
            DispatchQueue.main.async {
                self.albumCollectionView.reloadData()
                self.showReloadButton()
            }
        } failure: { errorMsg in
            self.stopLoaders()
            self.showToastMsg(message: errorMsg, isError: true)
            DispatchQueue.main.async {
                self.showReloadButton()
            }
        }
    }
    
    //Show reload button to refresh data on empty screen
    func showReloadButton() {
        //show on empty screen
        if (self.albumData?.toResult?.count ?? 0) == 0 {
            self.addRightBarButton(nil, UIImage(systemName: "repeat.circle"))
        } else {
            //hide when there is data on UI
            self.removeRightBarButton()
        }
    }
    
    /// Show toast message
    /// - Parameters:
    ///   - message: message
    ///   - isError: send true if message is for error, else send false
    func showToastMsg(message:String,isError:Bool){
        DispatchQueue.main.async {
            AppToast.show(message: message, controller: self, isError: isError)
        }
    }
    
    /// display loading
    func startLoader(){
        //Only show loader when refreshControl is not showing to prevent double loader
        //refreshControl should be shown when user pull to refresh
        if !self.refreshControl.isRefreshing {
            self.displayAnimatedActivityIndicatorView()
        }
    }
    
    /// Stop loader
    func stopLoaders(){
        DispatchQueue.main.async {
            if self.refreshControl.isRefreshing {
                self.refreshControl.endRefreshing()
            }
            if self.isDisplayingActivityIndicatorView() {
                self.hideAnimatedActivityIndicatorView()
            }
        }
    }
    
    // MARK: - Navigation
    
    /// Navigate to the album detail screen
    /// - Parameter selectedAlbum: selected album for detail
    func navigateToAlbumDetail(_ selectedAlbum: Result) {
        let controller = AlbumDetailsViewController()
        controller.albumDetails = selectedAlbum
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
}

//MARK: UICollectionView DataSources
extension AlbumListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.albumData?.toResult?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //get reusable cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: albumCellIdentifier, for: indexPath) as? AlbumCollectionViewCell
        
        //configure cell
        cell?.configureCell(result: (self.albumData?.toResult?.allObjects[indexPath.item]) as? Result)
        
        return cell ?? UICollectionViewCell()
    }
}

//MARK: UICollectionView Delegates
extension AlbumListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let album = self.albumData?.toResult?.allObjects[indexPath.item] as? Result {
            self.navigateToAlbumDetail(album)
        }
    }
}
