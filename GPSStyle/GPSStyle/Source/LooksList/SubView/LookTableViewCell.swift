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
        static let imageMargin: CGFloat = 8.0
        static let imageClothVerticallyMargin: CGFloat = 10.0
        static let imageClothSideSize: CGFloat = 70.0
        
        static let labelLeftMargin: CGFloat = 10.0
        
        static let labelHeightPercent: CGFloat = 46.0
        static let labelmarginTopPercent: CGFloat = 8.0
        static let warningImageSideSize: CGFloat = 15.0
        static let cellRightMargin: CGFloat = 24.0
        static let cellLeftMargin: CGFloat = 4.0
        
        static let containerMarginVertically: CGFloat = 4
    }
    
    static let cellReuseIdentifier = "LookTableViewCell"
    private let imagesContainer: UIView = UIView()
    private let imageFirstLookView = UIImageView()
    private let imageSecondLookView = UIImageView()
    private let imageThirdLookView = UIImageView()
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
    
    static func height() -> CGFloat {
        return Constants.imageClothSideSize + Constants.containerMarginVertically * 2 + Constants.imageMargin * 2
    }

    override func prepareForReuse() {
        [imageFirstLookView, imageSecondLookView, imageThirdLookView].forEach {
            $0.image = nil
        }
        size = 0
    }

    func configure(model: LookModel) {
        title.text = model.name
        size = model.imageName.count
        countLabel.text = "+\(size - 1)"
        countLabel.isHidden = size <= 3
        
        model.imageName.enumerated().forEach { index, imageName in
            guard index <= 2 else {
                return
            }
            
            ImageLoader.shared.image(hash: model.hashValue, with: imageName) { [weak self] hash, image  in
                guard model.hashValue == hash else {
                    return
                }
                DispatchQueue.main.async { [weak self] in
                    image?.withTintColor(.clear)
                    if index == .zero {
                        self?.imageFirstLookView.image = image
                    } else if index == 1 {
                        self?.imageSecondLookView.image = image
                    } else if index == 2 {
                        self?.imageThirdLookView.image = image
                    }
                }
            }
        }
        
        setNeedsLayout()
        layoutIfNeeded()
    }

    private func layout() {
        contentView.pin
            .top()
            .horizontally()
            .marginLeft(Constants.cellLeftMargin)
            .marginRight(Constants.cellRightMargin)
        
        imagesContainer.pin
            .left()
            .size(CGSize(width: Constants.imageClothSideSize + Constants.imageMargin * 2,
                         height: Constants.imageClothSideSize + Constants.imageMargin * 2))
            .vCenter()
        
        if size == 1 {
            imageFirstLookView.pin
                .vCenter()
                .left(Constants.imageMargin)
                .size(CGSize(width: Constants.imageClothSideSize,
                             height: Constants.imageClothSideSize))
        } else if size == 2 {
            imageFirstLookView.pin
                .topLeft(Constants.imageMargin)
                .width(Constants.imageClothSideSize / 2)
                .height(Constants.imageClothSideSize)
            
            imageSecondLookView.pin
                .top(Constants.imageMargin)
                .after(of: imageFirstLookView)
                .width(Constants.imageClothSideSize / 2)
                .height(Constants.imageClothSideSize)
        } else if size == 3 {
            imageFirstLookView.pin
                .topLeft(Constants.imageMargin)
                .width(Constants.imageClothSideSize / 2)
                .height(Constants.imageClothSideSize)
            
            imageSecondLookView.pin
                .top(Constants.imageMargin)
                .after(of: imageFirstLookView)
                .width(Constants.imageClothSideSize / 2)
                .height(Constants.imageClothSideSize / 2)
            
            imageThirdLookView.pin
                .below(of: imageSecondLookView)
                .after(of: imageFirstLookView)
                .width(Constants.imageClothSideSize / 2)
                .height(Constants.imageClothSideSize / 2)
        } else {
            imageFirstLookView.pin
                .topLeft(Constants.imageMargin)
                .width(Constants.imageClothSideSize / 2)
                .height(Constants.imageClothSideSize / 2)
            
            imageSecondLookView.pin
                .left(Constants.imageMargin)
                .below(of: imageFirstLookView)
                .width(Constants.imageClothSideSize / 2)
                .height(Constants.imageClothSideSize / 2)
            
            imageThirdLookView.pin
                .top(Constants.imageMargin)
                .after(of: imageFirstLookView)
                .width(Constants.imageClothSideSize / 2)
                .height(Constants.imageClothSideSize / 2)
            
            countLabel.pin
                .below(of: imageThirdLookView)
                .after(of: imageFirstLookView)
                .width(Constants.imageClothSideSize / 2)
                .height(Constants.imageClothSideSize / 2)
        }

        title.pin
            .after(of: imagesContainer)
            .marginLeft(Constants.labelLeftMargin)
            .right(Constants.labelLeftMargin)
            .sizeToFit(.width)
            .vCenter()
        
        contentView.pin
            .wrapContent(padding: 4)
    }
    
    private func setup() {
        selectionStyle = .none
        separatorInset = .zero
        accessoryType = .disclosureIndicator
        
        title.verticalAlignment = .middle
        title.font = FontFamily.Inter.regular.font(size: 14)
        title.numberOfLines = 3
        countLabel.textAlignment = .center
        countLabel.font = FontFamily.Inter.regular.font(size: 14)
        countLabel.textColor = ColorName.mainPurple.color
        
        imageFirstLookView.contentMode = .scaleAspectFit
        [imageFirstLookView, imageSecondLookView, imageThirdLookView].forEach {
            $0.contentMode = .scaleAspectFit
        }
        
        imagesContainer.backgroundColor = ColorName.darkGrey.color.withAlphaComponent(0.1)
//        imagesContainer.layer.borderWidth = 1
//        imagesContainer.layer.borderColor = ColorName.mainPurple.color.cgColor
        imagesContainer.layer.cornerRadius = 20
        imagesContainer.layer.masksToBounds = true
        
        imagesContainer.addSubviews(imageFirstLookView, imageSecondLookView, imageThirdLookView, countLabel)
        contentView.addSubviews(imagesContainer, title)
    }
}
