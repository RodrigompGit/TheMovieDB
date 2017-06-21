//
//  WatchDetailTableViewCell.swift
//  TesteChallengeTheMovieDB
//
//  Created by Eduardo Fornari on 19/06/17.
//  Copyright © 2017 Eduardo Fornari. All rights reserved.
//

import UIKit

class WatchDetailTableViewCell: UITableViewCell, UIImagePickerControllerDelegate,
UINavigationControllerDelegate {
    
    @IBOutlet weak var userPhotoUIImageView: UIImageView!
    
    @IBOutlet weak var eyeWatchedOrNotWatched: UIImageView!
    
    @IBOutlet weak var watchedOrNotWatchedUILabel: UILabel!
    
    
    let picker = UIImagePickerController()
    
    var movie: Movie! {
        didSet {
            picker.delegate = self
            
            var hasImage = false
            
            let userDefaults: UserDefaults = UserDefaults.standard
            var watchedMovies = [Watched]()
            
            if let watched = movie.watched(){
                userPhotoUIImageView.image = UIImage(data: watched.imageData as Data)
                eyeWatchedOrNotWatched.isHighlighted = true
                
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "MM/dd/yyyy"
                
                watchedOrNotWatchedUILabel.text = "Você viu este filme em:\n\(dateFormatter.string(from: watched.date))"
            }
            
            if let data = userDefaults.object(forKey: "watchedMovies") {
                watchedMovies = (NSKeyedUnarchiver.unarchiveObject(with: data as! Data) as? [Watched])!
                
                for watched in watchedMovies{
                    if(watched.idFilme! == movie.id!){
                        userPhotoUIImageView.image = UIImage(data: watched.imageData as Data)
                        hasImage = true
                        break
                    }
                }
                
            }
            
            if !hasImage{
                let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(chooseImage))
                userPhotoUIImageView.addGestureRecognizer(tapGestureRecognizer)
                userPhotoUIImageView.isUserInteractionEnabled = true
            }
        }
    }
    
    func chooseImage() {
        let optionMenu = UIAlertController(title: nil, message: "Image Source", preferredStyle: .actionSheet)
        
        let galery = UIAlertAction(title: "Gallery", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            self.picker.allowsEditing = false
            self.picker.sourceType = .photoLibrary
            self.picker.mediaTypes = ["public.image"]//UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
            self.parentViewController?.present(self.picker, animated: true, completion: nil)
        })
        let camera = UIAlertAction(title: "Camera", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            self.picker.allowsEditing = false
            self.picker.sourceType = .camera
            self.picker.mediaTypes = ["public.image"]//UIImagePickerController.availableMediaTypes(for: .camera)!
            self.parentViewController?.present(self.picker, animated: true, completion: nil)
        })
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        optionMenu.addAction(galery)
        optionMenu.addAction(camera)
        optionMenu.addAction(cancel)
        
        self.parentViewController?.present(optionMenu, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.parentViewController?.dismiss(animated: true) {}
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            //TODO
            //Save image
            self.userPhotoUIImageView.image = image
            
            let userDefaults: UserDefaults = UserDefaults.standard
            eyeWatchedOrNotWatched.isHighlighted = true
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM/dd/yyyy"
            let date = Date()
            watchedOrNotWatchedUILabel.text = "Você viu este filme em:\n\(dateFormatter.string(from: date))"
            
            let watched = Watched(imageData: UIImageJPEGRepresentation(image, 1)! as NSData, idFilme: movie.id!, date: date)
            var watchedMovies = [Watched]()
            
            userPhotoUIImageView.isUserInteractionEnabled = false
            
            
            if let data = userDefaults.object(forKey: "watchedMovies") {
                watchedMovies = (NSKeyedUnarchiver.unarchiveObject(with: data as! Data) as? [Watched])!
            }else{
            }
            
            watchedMovies.append(watched)
            let encodedData = NSKeyedArchiver.archivedData(withRootObject: watchedMovies)
            userDefaults.set(encodedData, forKey: "watchedMovies")
            userDefaults.synchronize()
            
            
            
            
        }
        
        self.parentViewController?.dismiss(animated: true) {}
    }
}
