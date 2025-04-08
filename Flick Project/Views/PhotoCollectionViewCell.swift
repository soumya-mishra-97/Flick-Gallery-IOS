//
//  PhotoCollectionViewCell.swift
//  Flick Project
//
//  Created by Soumya Ranjan Mishra on 09/04/25.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var photoImgView: UIImageView!
    @IBOutlet weak var photographerLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        photoImgView.contentMode = .scaleAspectFill
        photoImgView.clipsToBounds = true
        photographerLabel.numberOfLines = 1
        photographerLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
    }
    
    func configure(with photo: Photo) {
        photographerLabel.text = photo.title
        //loadImage(from: photo.src.medium) /// API Integration
        
        loadImage(from: photo.imageUrl) /// Local JSON
    }
    
    /*private func loadImage(from urlString: String) {
        photoImgView.image = nil
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let self = self, let data = data, error == nil,
                  let image = UIImage(data: data) else {
                return
            }
            DispatchQueue.main.async {
                self.photoImgView.image = image
            }
        }.resume()
    }*/
    
    private func loadImage(from urlString: String) {
            photoImgView.image = nil
            guard let url = URL(string: urlString) else { return }

            URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
                guard let self = self,
                      let data = data,
                      let image = UIImage(data: data),
                      error == nil else { return }
                DispatchQueue.main.async {
                    self.photoImgView.image = image
                }
            }.resume()
        }
}
