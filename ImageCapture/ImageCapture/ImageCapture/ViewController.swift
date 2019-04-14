//
//  ViewController.swift
//  ImageCapture
//
//  Created by Niranth padmonkar on 4/13/19.
//  Copyright © 2019 Niranth padmonkar. All rights reserved.
//

import UIKit
import SCSDKCreativeKit
import CoreML
import Vision

class ViewController: UIViewController , UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    
    
    @IBOutlet weak var PhotoLibrary: UIButton!
    
    
    @IBOutlet weak var Camera: UIButton!
    
    
    @IBOutlet weak var ImageView: UIImageView!
    
    
    @IBOutlet weak var snap: UIButton!
    
    
    var guess = ""

    
    override func viewDidLoad() {
        super.viewDidLoad()
        snap.isEnabled = false
        snap.isHidden = true
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    
    
    @IBAction func CameraAction(_ sender: UIButton) {
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera){
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerController.SourceType.camera;
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion:nil)
            snap.isEnabled = true
            snap.isHidden = false;
            }
        
     //   let picker = UIImagePickerController()
       // picker.delegate = self
      //  picker.sourceType = .camera
        
       // present(picker,animated: true, completion:nil )
    }
    
    @IBAction func PhotoLibraryAction(_ sender: UIButton) {
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary){
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary;
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion:nil)
            
        }
       // let picker = UIImagePickerController()
      //  picker.delegate = self
       // picker.sourceType = .photoLibrary
        
      //  present(picker,animated: true, completion:nil )
        
        
    }
    
    @IBAction func snap(_ sender: Any) {
        
        let snapshot = ImageView.image.unsafelyUnwrapped// Any image is OK. In this codes, SceneView's snapshot is passed.
        let photo = SCSDKSnapPhoto(image: snapshot)
        let snap = SCSDKPhotoSnapContent(snapPhoto: photo)
        

        
        //Caption
        snap.caption = "Getting some caffeine for that morning grind"
        
        //Sticker
        let stickURL = URL(string: "https://static1.squarespace.com/static/5495f996e4b0d669a5b4b329/549a235be4b0d8516b3ff820/549a235ce4b0fd529c202e51/1419387740871/Corp-Logo.png")!
        let sticker = SCSDKSnapSticker(stickerUrl: stickURL, isAnimated: false)
        snap.sticker = sticker;
        
        // URL
        //snap.attachmentUrl = "https://www.snapchat.com"
        
        let api = SCSDKSnapAPI(content: snap)
        api.startSnapping { error in
            
            if let error = error {
                print(error.localizedDescription)
            } else {
                // success
                
            }
        }
        
    }
    
    
    
    
    
 /*
    @IBAction func SaveAction(_ sender: UIButton) {
        let imageData = UIImageJPEGRepresentation(ImageView.image!,0.6)
        let compressedJPEGImage = UIImage(data: imageData!)
        UIImageWriteToSavedPhotosAlbum(compressedJPEGImage!,nil,nil,nil)
    }
 */
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        
        ImageView.image = selectedImage
        dismiss(animated: true, completion: nil)
        
        
        //let localModel = LocalModel(name: "my_local_model", path: modelPath)
        /*
        guard let model = try? VNCoreMLModel(for: model1().model) else {
            fatalError("Unable to load model")
        }
        
        let request = VNCoreMLRequest(model: model) {[weak self] request, error in
            guard let results = request.results as? [VNClassificationObservation],
            let topResult = results.first
                else {
                    fatalError("Unexpected results")
            }
            
            DispatchQueue.main.async {[weak self] in
                self?.guess = String(topResult.identifier)
            }
        }
        
        print(guess)*/
    }
    
    
    
    
    
}

