//
//  NewsCell.swift
//  Tock
//
//  Created by Kevin Turner on 11/23/16.
//  Copyright © 2016 Kevin Turner. All rights reserved.
//

import UIKit

class NewsCell: UITableViewCell {

    @IBOutlet weak var headlineLabel: UILabel!
    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    let background = UIView()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func populateCell(news: NewsItem){
        self.headlineLabel.text = news.headline
        self.descriptionLabel.text = news.description
        self.newsImage.image = news.image!
    }
    
    
    override func layoutSubviews() {
        
        let contentViewFrame = self.contentView.frame
        let horInset = CGFloat(5.0)
        let verInset = CGFloat(5.0)
        let backroundFrame = CGRect(x: horInset, y: verInset, width: contentViewFrame.width - (2*horInset), height: contentViewFrame.height - (2*verInset))
        
        
        background.frame = backroundFrame
        background.layer.cornerRadius = 20
        background.backgroundColor = UIColor.white
        background.alpha = 0.3
        
        self.contentView.insertSubview(background, belowSubview: self.headlineLabel)
        super.layoutSubviews()
        
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
