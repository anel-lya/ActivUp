//
//  QuoteTableViewCell.swift
//  ActivUp
//
//  Created by Anel Rustamova on 06.12.2023.
//

import UIKit

class QuoteTableViewCell: UITableViewCell {

    @IBOutlet weak var v: UIView!
    
    @IBOutlet weak var title: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
        v.layer.cornerRadius = 20
        
    }


}
