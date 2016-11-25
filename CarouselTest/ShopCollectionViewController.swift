//
//  ShopCollectionViewController.swift
//  CarouselTest
//
//  Created by Peter Bødskov on 25/11/2016.
//  Copyright © 2016 ReelTrak. All rights reserved.
//

import UIKit

class CarouselHeaderViewContainer: UICollectionReusableView {
    static let Identifier = "CarouselHeaderViewContainer"
    
    var carouselPageViewController: CarouselPageViewController? = nil
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setupImageCarousel() {
        print("setup")
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let carouselPageViewController = storyboard.instantiateViewController(withIdentifier: "CarouselPageViewController") as? CarouselPageViewController else {
            print("goodnight!")
            return
        }
        self.carouselPageViewController = carouselPageViewController
        self.carouselPageViewController!.view.frame = bounds
        addSubview(self.carouselPageViewController!.view)
    }
}

class ShopItemCollectionViewCell: UICollectionViewCell {
    static let Identifier = "ShopItemCollectionViewCell"
    
    @IBOutlet weak var albumImageView: UIImageView!
    @IBOutlet weak var albumNameLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    
    override func prepareForReuse() {
        albumImageView.image = nil
        albumNameLabel.text = ""
        artistNameLabel.text = ""
    }
}

class ShopCollectionViewController: UICollectionViewController {

    var carouselHeaderViewContainer: CarouselHeaderViewContainer? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
//        self.collectionView!.register(ShopItemCollectionViewCell.self, forCellWithReuseIdentifier: ShopItemCollectionViewCell.Identifier)
        self.collectionView!.register(CarouselHeaderViewContainer.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: CarouselHeaderViewContainer.Identifier)

    
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let shopCell = collectionView.dequeueReusableCell(withReuseIdentifier: ShopItemCollectionViewCell.Identifier, for: indexPath) as? ShopItemCollectionViewCell else {
            return UICollectionViewCell()
        }
        shopCell.albumImageView.image = UIImage(named: "coverImage")!
        shopCell.albumNameLabel.text = "Det överexponerade gömstället"
        shopCell.artistNameLabel.text = "bob hund"
        
        return shopCell
    }
    
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if carouselHeaderViewContainer == nil {
            print("setting up header")
            guard let carouselHeaderViewContainer = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: CarouselHeaderViewContainer.Identifier, for: indexPath) as? CarouselHeaderViewContainer else {
                return UICollectionReusableView()
            }
            carouselHeaderViewContainer.setupImageCarousel()
            self.carouselHeaderViewContainer = carouselHeaderViewContainer
        }
        
        return self.carouselHeaderViewContainer!
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        collectionView!.reloadData()
    }



    
    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}

extension ShopCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let height: CGFloat = view.frame.size.width * 0.34
        return CGSize(width: view.frame.size.width, height: height)
    }
}

