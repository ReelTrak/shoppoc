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
    var currentIndex: Int = 0
    var carouselTimer: Timer? = nil
    
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
        
        guard let currentViewController = currentViewController else {
            return
        }
        
        setViewControllers([currentViewController], direction: .forward, animated: true, completion: nil)
        
        dataSource = self
        
    }
    
    
    var currentViewController: UIViewController? {
        guard let imageViewControllers = imageViewControllers else {
            return nil
        }
        return imageViewControllers[currentIndex]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("appearing")
        if carouselTimer == nil {
            print("setting timer")
            carouselTimer = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: true) { [unowned self] timer in
                self.advanceToNextImage(timer)
            }
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("disappearing")
        if carouselTimer != nil {
            carouselTimer!.invalidate()
            carouselTimer = nil
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func advanceToNextImage(_ timer: Timer) {
        if  let currentViewController = currentViewController,
            let nextViewController = nextViewController(afterViewController: currentViewController) {
            setViewControllers([nextViewController], direction: .forward, animated: true, completion: nil)
        }
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
        return nextViewController(afterViewController: viewController)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        return previousViewController(beforeViewController: viewController)
    }
    
    func nextViewController(afterViewController viewController: UIViewController) -> UIViewController? {
        guard let imageViewControllers = imageViewControllers else {
            return nil
        }
        if let index = imageViewControllers.index(of: viewController) {
            if index < imageViewControllers.count - 1 {
                currentIndex = index + 1
            } else {
                currentIndex = 0
            }
            return imageViewControllers[currentIndex]
        }
        return nil
    }

    func previousViewController(beforeViewController viewController: UIViewController) -> UIViewController? {
        guard let imageViewControllers = imageViewControllers else {
            return nil
        }
        if let index = imageViewControllers.index(of: viewController) {
            if index > 0 {
                currentIndex = index - 1
            } else {
                currentIndex = imageViewControllers.count - 1
            }
            return imageViewControllers[currentIndex]
        }
        return nil
    }
}
