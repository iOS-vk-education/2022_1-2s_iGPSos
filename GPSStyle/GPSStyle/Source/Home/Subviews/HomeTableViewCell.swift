//
//  HomeTableViewCell.swift
//  GPSStyle
//
//  Created by Ivan Gorshkov on 29.10.2022.
//

import UIKit
import PinLayout

class HomeTableViewCell: UITableViewCell {
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
    
    static let cellReuseIdentifier = "HomeTableViewCell"
    private let imageClothView = UIImageView()
    private let title = VerticalAlignLabel()
    private let subTitle = VerticalAlignLabel()
    private let warningImage = UIImageView(image: Asset.warning.image)

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
        imageClothView.image = nil
    }

    func configure(model: HomeRow) {
        ImageLoader.shared.image(hash: model.hashValue, with: model.imageUrl) { [weak self] hash, image  in
            guard model.hashValue == hash else {
                return
            }
            DispatchQueue.main.async { [weak self] in
                self?.imageClothView.image = image
            }
        }
        title.text = model.title
        subTitle.text = model.stringSpecification
        warningImage.isHidden = !model.isWarning
        setNeedsLayout()
    }

    private func layout() {
        contentView.pin.all().marginRight(Constants.cellLeftMargin)
        imageClothView.pin
            .left(Constants.imageMargin)
            .vertically(Constants.imageClothVerticallyMargin)
            .size(Constants.imageClothSideSize)
        
        title.pin
            .right(of: imageClothView)
            .marginLeft(Constants.labelLeftMargin)
            .right()
            .top()
            .height(Constants.labelHeightPercent%)
        subTitle.pin
            .right(of: imageClothView)
            .marginLeft(Constants.labelLeftMargin)
            .right()
            .below(of: title)
            .height(Constants.labelHeightPercent%)
            .marginTop(Constants.labelmarginTopPercent%)
        warningImage.pin
            .right(Constants.imageMargin)
            .vCenter()
            .size(Constants.warningImageSideSize)
    }
    
    private func setup() {
        selectionStyle = .none
        separatorInset = .zero
        accessoryType = .disclosureIndicator
    
        contentView.addSubviews(imageClothView, title, subTitle, warningImage)
        title.verticalAlignment = .bottom
        title.font = FontFamily.Inter.regular.font(size: 14)
        subTitle.font = FontFamily.Inter.regular.font(size: 14)
        subTitle.textColor = ColorName.darkGrey.color

        imageClothView.addOverlay()
        imageClothView.layer.cornerRadius = Constants.imageCornerRadius
        imageClothView.layer.masksToBounds = true
    }
}
