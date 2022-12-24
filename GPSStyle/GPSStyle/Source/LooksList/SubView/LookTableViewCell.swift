//
//  LookTableViewCell.swift
//  GPSStyle
//
//  Created by Ivan Gorshkov on 24.12.2022.
//

import Foundation
import PinLayout

class LookTableViewCell: UITableViewCell {
    private enum Constants {
        static let imageCornerRadius: CGFloat = 20
        static let imageMargin: CGFloat = 12.0
        static let imageClothVerticallyMargin: CGFloat = 10.0
        static let imageClothSideSize: CGFloat = 64.0
        static let labelLeftMargin: CGFloat = 10.0
        static let labelHeightPercent: CGFloat = 46.0
        static let labelmarginTopPercent: CGFloat = 8.0
        static let warningImageSideSize: CGFloat = 15.0
        static let cellLeftMargin: CGFloat = 24.0
    }
    
    static let cellReuseIdentifier = "LookTableViewCell"
    private let imageLookView = UIImageView()
    private let title = VerticalAlignLabel()
    private let countLabel = UILabel()
    private var size = 0

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layout()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        return contentView.autoSizeThatFits(size, layoutClosure: layout)
    }

    override func prepareForReuse() {
        imageLookView.image = nil
        size = 0
    }

    func configure(model: LookModel) {
        ImageLoader.shared.image(hash: model.hashValue, with: model.imageName.first ?? "") { [weak self] hash, image  in
            guard model.hashValue == hash else {
                return
            }
            DispatchQueue.main.async { [weak self] in
                self?.imageLookView.image = image
            }
        }
        title.text = model.name
        size = model.imageName.count
        countLabel.text = "+\(size - 1)"
        countLabel.isHidden = size == 1
        setNeedsLayout()
    }

    private func layout() {
        contentView.pin.all().marginRight(Constants.cellLeftMargin)
        if size == 1 {
            imageLookView.pin
                .left(Constants.imageMargin)
                .vertically(Constants.imageClothVerticallyMargin)
                .size(Constants.imageClothSideSize)
            title.pin
                .right(of: imageLookView)
                .marginLeft(Constants.labelLeftMargin)
                .right()
                .top()
                .bottom()
        } else {
            imageLookView.pin
                .left(Constants.imageMargin)
                .vertically(Constants.imageClothVerticallyMargin)
                .width(Constants.imageClothSideSize / 2)
                .height(Constants.imageClothSideSize)
            countLabel.pin
                .right(of: imageLookView)
                .marginLeft(Constants.labelLeftMargin)
                .vertically(Constants.imageClothVerticallyMargin)
                .width(Constants.imageClothSideSize / 2)
                .height(Constants.imageClothSideSize)
            title.pin
                .right(of: countLabel)
                .marginLeft(Constants.labelLeftMargin)
                .right()
                .top()
                .bottom()
        }
    }
    
    private func setup() {
        selectionStyle = .none
        separatorInset = .zero
        accessoryType = .disclosureIndicator
    
        contentView.addSubviews(imageLookView, title, countLabel)
        title.verticalAlignment = .middle
        title.font = FontFamily.Inter.regular.font(size: 14)
        countLabel.font = FontFamily.Inter.regular.font(size: 14)
        countLabel.textColor = ColorName.mainPurple.color
        
        imageLookView.addOverlay()
        imageLookView.layer.cornerRadius = Constants.imageCornerRadius
        imageLookView.layer.masksToBounds = true
        imageLookView.contentMode = .scaleAspectFit
    }
}
