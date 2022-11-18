//
//  UIImageView+Extensions.swift
//  FetchRewards
//
//  Created by LanceMacBookPro on 11/16/22.
//

import UIKit

var imageCache = NSCache<AnyObject, AnyObject>()

// MARK: - Create ImageView
extension UIImageView {
    
    static func createImageView(with contentMode: UIView.ContentMode) -> UIImageView {
        
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = contentMode
        imageView.backgroundColor = .black
        return imageView
    }
}

// MARK: - LoadImage
extension UIImageView {
    
    func loadImage(with url: URL) {
        
        self.image = nil
        
        if let cachedImage = imageCache.object(forKey: url.absoluteString as AnyObject) as? UIImage {
            image = cachedImage
            return
        }
        
        Service.shared.fetchData(with: url) { [weak self](result) in
            
            switch result {
            case .failure(let sessionError):
                
                print("image-falied-: ", sessionError.localizedDescription)
                
            case .success(let data):
                
                guard let downloadedImage = UIImage(data: data) else {
                    print("image-is-nil")
                    return
                }
                
                imageCache.setObject(downloadedImage, forKey: url.absoluteString as AnyObject)
                
                DispatchQueue.main.async { [weak self] in
                    self?.image = downloadedImage
                }
            }
        }
    }
}
