//
//  ViewController.swift
//  CoreMLDemo
//
//  Created by Sai Kambampati on 14/6/2017.
//  Copyright © 2017 AppCoda. All rights reserved.
//

import UIKit
import CoreML

class ViewController: UIViewController, UINavigationControllerDelegate {
    @IBOutlet weak var classifier: UILabel!
    @IBOutlet weak var sepal_length_tf: UITextField!
    @IBOutlet weak var sepal_width_tf: UITextField!
    @IBOutlet weak var petal_length_tf: UITextField!
    @IBOutlet weak var petal_Width_tf: UITextField!
    var model: iris_lr!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        model = iris_lr()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onSubmit(_ sender: Any) {
        
        // Core ML
        // example values for iris flower attributes.
        
        //        var sepal_length_a : Double = 6.3
        //        var sepal_width_b : Double = 3.3
        //        var petal_length_c : Double = 4.7
        //        var petal_Width_d : Double = 1.6
        
        var sepal_length_a : Double!
        var sepal_width_b : Double!
        var petal_length_c : Double!
        var petal_Width_d : Double!
        
        if let sepal_length_value = Double(sepal_length_tf.text!) {
            sepal_length_a = sepal_length_value
            print("The user entered value for sepal_length is \(sepal_length_value)")
        } else {
            print("Not a valid number: \(sepal_length_tf.text!)")
        }
        
        if let sepal_width_value = Double(sepal_width_tf.text!) {
            sepal_width_b = sepal_width_value
            print("The user entered value for sepal_length is \(sepal_width_value)")
        } else {
            print("Not a valid number: \(sepal_width_tf.text!)")
        }
        
        if let petal_length_value = Double(petal_length_tf.text!) {
            petal_length_c = petal_length_value
            print("The user entered value for sepal_length is \(petal_length_value)")
        } else {
            print("Not a valid number: \(petal_length_tf.text!)")
        }
        
        if let petal_Width_value = Double(petal_Width_tf.text!) {
            petal_Width_d = petal_Width_value
            print("The user entered value for sepal_length is \(petal_Width_value)")
        } else {
            print("Not a valid number: \(petal_Width_tf.text!)")
        }
        
        // Prediction made on the basis of values entered.
        if let prediction = try? model.prediction(sepal_length: sepal_length_a,sepal_width: sepal_width_b,petal_length: petal_length_c,petal_width: petal_Width_d)
        {
            print("result: \(prediction.class_)")
            classifier.text = "I think this is a \(prediction.class_)."
        }
        else
        {
            print("Please enter all the values")
        }
        
        //        guard let prediction = try? model.prediction(sepal_length: a,sepal_width: b,petal_length: c,petal_width: d) else {
        //            return
        //        }
        //
        //        print(prediction.class_);
        //        print(prediction.classProbability);
    }
}
