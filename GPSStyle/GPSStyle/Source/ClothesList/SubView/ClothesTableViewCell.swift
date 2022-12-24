//
//  ClothesTableViewCell.swift
//  GPSStyle
//
//  Created by Алексей Шевченко on 24.12.2022.
//

import UIKit
import PinLayout

class ClothesTableViewCell: UITableViewCell {
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
    
    static let cellReuseIdentifier = "ClothesTableViewCell"
    private let imageClothesView = UIImageView()
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
        imageClothesView.image = nil
        size = 0
    }

    func configure(model: ClothingModel) {
        ImageLoader.shared.image(hash: model.hashValue, with: model.imageName) { [weak self] hash, image  in
            guard model.hashValue == hash else {
                return
            }
            DispatchQueue.main.async { [weak self] in
                self?.imageClothesView.image = image
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
            imageClothesView.pin
                .left(Constants.imageMargin)
                .vertically(Constants.imageClothVerticallyMargin)
                .size(Constants.imageClothSideSize)
            title.pin
                .right(of: imageClothesView)
                .marginLeft(Constants.labelLeftMargin)
                .right()
                .top()
                .bottom()
        } else {
            imageClothesView.pin
                .left(Constants.imageMargin)
                .vertically(Constants.imageClothVerticallyMargin)
                .width(Constants.imageClothSideSize / 2)
                .height(Constants.imageClothSideSize)
            countLabel.pin
                .right(of: imageClothesView)
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
    
        contentView.addSubviews(imageClothesView, title, countLabel)
        title.verticalAlignment = .middle
        title.font = FontFamily.Inter.regular.font(size: 14)
        countLabel.font = FontFamily.Inter.regular.font(size: 14)
        countLabel.textColor = ColorName.mainPurple.color
        
        imageClothesView.addOverlay()
        imageClothesView.layer.cornerRadius = Constants.imageCornerRadius
        imageClothesView.layer.masksToBounds = true
        imageClothesView.contentMode = .scaleAspectFit
    }
}
