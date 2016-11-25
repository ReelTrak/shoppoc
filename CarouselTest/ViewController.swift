//
//  ViewController.swift
//  CarouselTest
//
//  Created by Peter Bødskov on 24/11/2016.
//  Copyright © 2016 ReelTrak. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var shopViewContainer: UIView!
    @IBOutlet weak var eduViewContainer: UIView!
    @IBOutlet weak var viewSelectorSegmentedControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showSelectedView()
    }
    
    func showSelectedView() {
        if viewSelectorSegmentedControl.selectedSegmentIndex == 0 {
            shopViewContainer.isHidden = false
            eduViewContainer.isHidden = true
        } else {
            shopViewContainer.isHidden = true
            eduViewContainer.isHidden = false
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didSelectView(_ sender: UISegmentedControl) {
        showSelectedView()
    }
}

