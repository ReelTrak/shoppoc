//
//  CarouselPageViewController.swift
//  CarouselTest
//
//  Created by Peter Bødskov on 24/11/2016.
//  Copyright © 2016 ReelTrak. All rights reserved.
//

import UIKit

class CarouselPageViewController: UIPageViewController {
    
    var imageViewControllers: [UIViewController]? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        guard let hverdagensViewController = storyboard?.instantiateViewController(withIdentifier: "carouselImageView") as? CarouselImageViewController else {
            print("dagnabbit")
            return
        }
        
        guard let furaViewController = storyboard?.instantiateViewController(withIdentifier: "carouselImageView") as? CarouselImageViewController else {
            print("dagnabbit")
            return
        }

        guard let yephaViewController = storyboard?.instantiateViewController(withIdentifier: "carouselImageView") as? CarouselImageViewController else {
            print("dagnabbit")
            return
        }


        hverdagensViewController.setImage(fromURLString: "https://shop.reeltrak.com/images/campaign/large/hverdagenshelte.jpg")
        furaViewController.setImage(fromURLString: "https://shop.reeltrak.com/images/campaign/large/fura-top.jpg")
        yephaViewController.setImage(fromURLString: "https://shop.reeltrak.com/images/campaign/large/yepha-morten-top.jpg")
        
        imageViewControllers = [hverdagensViewController, furaViewController, yephaViewController]
        
        setViewControllers([hverdagensViewController], direction: .forward, animated: true, completion: nil)
        
        dataSource = self
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}

extension CarouselPageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let imageViewControllers = imageViewControllers else {
            return nil
        }
        
        if let index = imageViewControllers.index(of: viewController) {
            if index < imageViewControllers.count - 1 {
                return imageViewControllers[index + 1]
            } else {
                return imageViewControllers.first!
            }
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let imageViewControllers = imageViewControllers else {
            return nil
        }
        
        if let index = imageViewControllers.index(of: viewController) {
            if index > 0 {
                return imageViewControllers[index - 1]
            } else {
                return imageViewControllers[imageViewControllers.count - 1]
            }
        }
        return nil
    }
}
