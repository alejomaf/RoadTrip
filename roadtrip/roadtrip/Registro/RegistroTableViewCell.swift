//
//  RegistroTableViewCell.swift
//  roadtrip
//
//  Created by Aula11 on 26/11/20.
//  Copyright © 2020 ual. All rights reserved.
//

import UIKit

class RegistroTableViewCell: UITableViewCell {

    @IBOutlet weak var validationBorder: UIView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.accessoryView?.tintColor = UIColor.init(red: 0, green: 170, blue: 255, alpha: 1)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
