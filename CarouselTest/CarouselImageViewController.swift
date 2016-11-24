//
//  CarouselImageViewController.swift
//  CarouselTest
//
//  Created by Peter Bødskov on 24/11/2016.
//  Copyright © 2016 ReelTrak. All rights reserved.
//

import UIKit

class CarouselImageViewController: UIViewController {

    var carouselImage: UIImage? = nil
    
    @IBOutlet weak var imageView: UIImageView! {
        didSet {
            imageView.image = carouselImage
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setImage(fromURLString urlString: String) {
        if let url = URL(string: urlString) {
            do {
                let data = try Data(contentsOf: url)
                carouselImage = UIImage(data: data)
            } catch {
                print("error")
            }
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
