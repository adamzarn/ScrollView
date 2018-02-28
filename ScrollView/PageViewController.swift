//
//  PageViewController.swift
//  ScrollView
//
//  Created by Adam Zarn on 2/27/18.
//  Copyright © 2018 Adam Zarn. All rights reserved.
//

import Foundation
import UIKit

class PageViewController: UIPageViewController {
    
    var viewControllersArray: [UIViewController] = []
    let colors: [UIColor] = [.red, .blue, .orange, .yellow, .black]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegate = self
        dataSource = self
        
        for color in colors {
            let vc = UIViewController()
            let view = UIView()
            vc.view.backgroundColor = .white
            view.frame.origin.x = vc.view.center.x - 100.0
            view.frame.origin.y = vc.view.center.y - 100.0
            view.frame.size.width = 200.0
            view.frame.size.height = 200.0
            view.backgroundColor = color
            vc.view.addSubview(view)
            viewControllersArray.append(vc)
        }
        
        let initialVC = viewControllersArray[0]
        
        self.setViewControllers([initialVC], direction: UIPageViewControllerNavigationDirection.forward, animated: true, completion: nil)
        
    }
    
}

extension PageViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        if let index = viewControllersArray.index(of: viewController) {
            if index == 0 {
                return viewControllersArray[viewControllersArray.count - 1]
            } else {
                return viewControllersArray[index - 1]
            }
        } else {
            return nil
        }
        
    
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        if let index = viewControllersArray.index(of: viewController) {
            if index == viewControllersArray.count - 1 {
                return viewControllersArray[0]
            } else {
                return viewControllersArray[index + 1]
            }
        } else {
            return nil
        }
        
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return viewControllersArray.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }

}

