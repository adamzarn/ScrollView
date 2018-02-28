//
//  CollectionViewController.swift
//  ScrollView
//
//  Created by Adam Zarn on 2/27/18.
//  Copyright © 2018 Adam Zarn. All rights reserved.
//

import Foundation
import UIKit

class CollectionViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    let screenWidth = UIScreen.main.bounds.width
    let colors: [UIColor] = [.red, .blue, .orange, .yellow, .black]
    let numberOfCells = 100
    var currentIndexPath: IndexPath!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let swipeRight = UISwipeGestureRecognizer()
        swipeRight.addTarget(self, action: #selector(CollectionViewController.swipeRight(sender:)))
        swipeRight.direction = .right
        collectionView.addGestureRecognizer(swipeRight)
        
        let swipeLeft = UISwipeGestureRecognizer()
        swipeLeft.addTarget(self, action: #selector(CollectionViewController.swipeLeft(sender:)))
        swipeLeft.direction = .left
        collectionView.addGestureRecognizer(swipeLeft)
        
        currentIndexPath = IndexPath(row: numberOfCells/2, section: 0)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        collectionView.scrollToItem(at: currentIndexPath, at: .centeredHorizontally, animated: false)
    }
    
    @objc func swipeRight(sender: UISwipeGestureRecognizer) {
        if currentIndexPath.row > 0 {
            let previousIndexPath = IndexPath(row: currentIndexPath.row - 1, section: 0)
            collectionView.scrollToItem(at: previousIndexPath, at: UICollectionViewScrollPosition.centeredHorizontally, animated: true)
            currentIndexPath = previousIndexPath
        }
    }
    
    @objc func swipeLeft(sender: UISwipeGestureRecognizer) {
        if currentIndexPath.row < numberOfCells - 1 {
            let nextIndexPath = IndexPath(row: currentIndexPath.row + 1, section: 0)
            collectionView.scrollToItem(at: nextIndexPath, at: UICollectionViewScrollPosition.centeredHorizontally, animated: true)
            currentIndexPath = nextIndexPath
        }
    }
    
}

extension CollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: screenWidth-120.0, height: 300.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfCells
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell", for: indexPath) as UICollectionViewCell
        cell.backgroundColor = colors[indexPath.row % colors.count]
        return cell
    }
    
}
