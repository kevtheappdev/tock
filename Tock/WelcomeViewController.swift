//
//  WelcomeViewController.swift
//  Tock
//
//  Created by Kevin Turner on 6/15/16.
//  Copyright © 2016 Kevin Turner. All rights reserved.
//

import UIKit
//import GoogleMaps

class WelcomeViewController: UIViewController, UIViewControllerTransitioningDelegate {
    
    //GMSAutocompleteViewControllerDelegate {
    
    
    @IBOutlet weak var welcomLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gradient = CAGradientLayer()
        gradient.frame = view.frame
        gradient.colors = [UIColor(red: 1, green: 0.4393680155, blue: 0.001996452746, alpha: 1).cgColor, UIColor(red: 1, green: 0.7662689211, blue: 0.3382564307, alpha: 1).cgColor]
        
             view.layer.backgroundColor = UIColor.clear.cgColor
             view.layer.insertSublayer(gradient, below: welcomLabel.layer)
           }


    @IBAction func selectPlace(_ sender: AnyObject) {
//        let autocompleteController = GMSAutocompleteViewController()
//        autocompleteController.delegate = self
//        self.presentViewController(autocompleteController, animated: true, completion: nil)
    }
    
//    func viewController(viewController: GMSAutocompleteViewController, didAutocompleteWithPlace place: GMSPlace){
//        print("Place name: ", place.name)
//        print("Place address: ", place.formattedAddress)
//        print("Place attributions: ", place.attributions)
//        
//        
//       viewController.dismissViewControllerAnimated(true, completion: nil)
//    }
//    
//    func viewController(viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: NSError){
//        print("failed %@", error)
//    }
//    
//    // User canceled the operation.
//    func wasCancelled(viewController: GMSAutocompleteViewController){
//        viewController.dismissViewControllerAnimated(true, completion: nil)
//    }
//    
//    // Turn the network activity indicator on and off again.
//    func didRequestAutocompletePredictions(viewController: GMSAutocompleteViewController) {
//        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
//    }
//    
//    func didUpdateAutocompletePredictions(viewController: GMSAutocompleteViewController) {
//        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
//    }
  
    @IBAction func swipedRight(_ sender: AnyObject) {
        print("swiped")
        self.performSegue(withIdentifier: "weather", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("prepping for segue")
        let destinationViewController = segue.destination
        destinationViewController.transitioningDelegate = self
    }
    
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning?
    {
        return RightSlideTransition()
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning?{
        return UnwindPopTransition()
    }
    
}
