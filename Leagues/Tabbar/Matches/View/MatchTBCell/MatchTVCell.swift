//
//  MatchTVCell.swift
//  Leagues
//
//  Created by Asmaa_Abdelfattah on 28/01/1403 AP.
//

import UIKit

class MatchTVCell: UITableViewCell {

    @IBOutlet weak var matchName: UILabel!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var matchView: UIView!{
        didSet{
            matchView.layer.cornerRadius = 5
            matchView.layer.shadowColor = UIColor.lightGray.cgColor
            matchView.layer.shadowOffset = CGSize(width: 0, height: 2)
            matchView.layer.shadowOpacity = 0.5
            matchView.layer.shadowRadius = 4
            matchView.clipsToBounds = false
        }
    }
    
    @IBOutlet weak var favBtn: UIButton!{
        didSet{
            favBtn.setTitle("", for: .normal)
        }
    }
    var delegate:FavouriteProtocol?
    var match:Match?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func setFav(_ sender: Any) {
        if let match = self.match {
            delegate?.setFavourite(match: match)
        }}
}
