//
//  ContactTableViewCell.swift
//  ContactsApp
//
//  Created by Daniel Fratila on 9/15/23.
//

import UIKit

class ContactTableViewCell: UITableViewCell, ReusableView, NibLoadableView {
    @IBOutlet private weak var personImageView: ImageLoaderView!
    @IBOutlet private weak var personName: UILabel!
    @IBOutlet private weak var detailImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func createPersonLabel(personLabelString: String) {
        let personLabel = UILabel()
        personLabel.translatesAutoresizingMaskIntoConstraints = false
        
        personImageView.addSubview(personLabel)
        
        NSLayoutConstraint.activate([
            personLabel.topAnchor.constraint(equalTo: personImageView.topAnchor),
            personLabel.leadingAnchor.constraint(equalTo: personImageView.leadingAnchor),
            personLabel.trailingAnchor.constraint(equalTo: personImageView.trailingAnchor),
            personLabel.bottomAnchor.constraint(equalTo: personImageView.bottomAnchor)
        ])
        
        personLabel.text = personLabelString
        personLabel.textColor = .white
        personLabel.backgroundColor = UIColor(red: 193.0/255.0, green: 200.0/255.0, blue: 215.0/255.0, alpha: 1.0)
        personLabel.font = UIFont(name: "SF-Pro-Text-Bold", size: 17.0)
        personLabel.textAlignment = .center
    }
}

// MARK: - ViewModelConfigurable

extension ContactTableViewCell: Configurable {
    func configure(with viewModel: ContactScreen.ContactCellViewModel) {
        if let strUrl = viewModel.imageString?.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed),
              let imgUrl = URL(string: strUrl) {
            personImageView.loadImageWithUrl(imgUrl)
        }
        if let personLabelString = viewModel.personLabelString {
            createPersonLabel(personLabelString: personLabelString)
        }
        personName.text = viewModel.title
        detailImageView.image = UIImage(named: "rightArrow")
    }
}
