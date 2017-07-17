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
    
    @IBOutlet weak var imageView: UIImageView!
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
    
    @IBAction func camera(_ sender: Any) {
        
        if !UIImagePickerController.isSourceTypeAvailable(.camera) {
            return
        }
        
        let cameraPicker = UIImagePickerController()
        cameraPicker.delegate = self
        cameraPicker.sourceType = .camera
        cameraPicker.allowsEditing = false
        
        present(cameraPicker, animated: true)
    }
    
    @IBAction func onSubmit(_ sender: Any) {
        
        // Core ML
//        var a: Double = 6.3;
//        var b: Double = 3.3;
//        var c: Double = 4.7;
//        var d: Double = 1.6;
        
        var a : Double!
        var b : Double!
        var c : Double!
        var d : Double!
        
        if let sepal_length_value = Double(sepal_length_tf.text!) {
            a = sepal_length_value
            print("The user entered value for sepal_length is \(sepal_length_value)")
        } else {
            print("Not a valid number: \(sepal_length_tf.text!)")
        }
        
        if let sepal_width_value = Double(sepal_width_tf.text!) {
            b = sepal_width_value
            print("The user entered value for sepal_length is \(sepal_width_value)")
        } else {
            print("Not a valid number: \(sepal_width_tf.text!)")
        }
        
        if let petal_length_value = Double(petal_length_tf.text!) {
            c = petal_length_value
            print("The user entered value for sepal_length is \(petal_length_value)")
        } else {
            print("Not a valid number: \(petal_length_tf.text!)")
        }
        
        if let petal_Width_value = Double(petal_Width_tf.text!) {
            d = petal_Width_value
            print("The user entered value for sepal_length is \(petal_Width_value)")
        } else {
            print("Not a valid number: \(petal_Width_tf.text!)")
        }
        
        if let prediction = try? model.prediction(sepal_length: a,sepal_width: b,petal_length: c,petal_width: d)
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
    /*
    func isValidNumber(str:String) -> Bool{
        if str.isEmpty {
            return false
        }
        let newChar = NSCharacterSet(charactersInString: str)
        let boolValid = NSCharacterSet.decimalDigitCharacterSet().isSupersetOfSet(newChar)
        if boolValid{
            return true
        }else{
            let lst = str.componentsSeparatedByString(".")
            let newStr = lst.joinWithSeparator("")
            let currentChar = NSCharacterSet(charactersInString: newStr)
            if lst.count == 2 && !lst.contains("") && NSCharacterSet.decimalDigitCharacterSet().isSupersetOfSet(currentChar){
                return true
            }
            return false
        }
    }
 */

}

extension ViewController: UIImagePickerControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        picker.dismiss(animated: true)
        classifier.text = "Analyzing Image..."
        guard let image = info["UIImagePickerControllerOriginalImage"] as? UIImage else {
            return
        } //1
        
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 299, height: 299), true, 2.0)
        image.draw(in: CGRect(x: 0, y: 0, width: 299, height: 299))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        let attrs = [kCVPixelBufferCGImageCompatibilityKey: kCFBooleanTrue, kCVPixelBufferCGBitmapContextCompatibilityKey: kCFBooleanTrue] as CFDictionary
        var pixelBuffer : CVPixelBuffer?
        let status = CVPixelBufferCreate(kCFAllocatorDefault, Int(newImage.size.width), Int(newImage.size.height), kCVPixelFormatType_32ARGB, attrs, &pixelBuffer)
        guard (status == kCVReturnSuccess) else {
            return
        }
        
        CVPixelBufferLockBaseAddress(pixelBuffer!, CVPixelBufferLockFlags(rawValue: 0))
        let pixelData = CVPixelBufferGetBaseAddress(pixelBuffer!)
        
        let rgbColorSpace = CGColorSpaceCreateDeviceRGB()
        let context = CGContext(data: pixelData, width: Int(newImage.size.width), height: Int(newImage.size.height), bitsPerComponent: 8, bytesPerRow: CVPixelBufferGetBytesPerRow(pixelBuffer!), space: rgbColorSpace, bitmapInfo: CGImageAlphaInfo.noneSkipFirst.rawValue) //3
        
        context?.translateBy(x: 0, y: newImage.size.height)
        context?.scaleBy(x: 1.0, y: -1.0)
        
        UIGraphicsPushContext(context!)
        newImage.draw(in: CGRect(x: 0, y: 0, width: newImage.size.width, height: newImage.size.height))
        UIGraphicsPopContext()
        CVPixelBufferUnlockBaseAddress(pixelBuffer!, CVPixelBufferLockFlags(rawValue: 0))
        imageView.image = newImage
        
        // Core ML
        let a: Double = 6.3;
        let b: Double = 3.3;
        let c: Double = 4.7;
        let d: Double = 1.6;
        
        guard let prediction = try? model.prediction(sepal_length: a,sepal_width: b,petal_length: c,petal_width: d) else {
            return
        }
        
        classifier.text = "I think this is a \(prediction.featureNames)."
        print(prediction.class_);
        print(prediction.classProbability);
    }
}
