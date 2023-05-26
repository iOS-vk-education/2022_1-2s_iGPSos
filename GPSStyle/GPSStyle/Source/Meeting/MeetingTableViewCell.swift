//
//  MeetingTableViewCell.swift
//  GPSStyle
//
//  Created by Алина Пахомова on 18.12.2022.
//

import UIKit
import PinLayout

class MeetingTableViewCell: UITableViewCell {
    private enum Constants {
        static let imageCornerRadius: CGFloat = 20
        static let imageMargin: CGFloat = 12.0
        static let imageClothVerticallyMargin: CGFloat = 10.0
        static let imageClothSideSize: CGFloat = 64.0
        static let labelLeftMargin: CGFloat = 10.0
        static let labelHeightPercent: CGFloat = 46.0
        static let cellLeftMargin: CGFloat = 24.0
    }
    
    private let imageClothView = UIImageView()
    private let title = VerticalAlignLabel()

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

    func configure(with model: CellModel) {
        ImageLoader.shared.image(hash: model.hashValue, with: model.imageUrl) { [weak self] hash, image  in
            guard model.hashValue == hash else {
                return
            }
            DispatchQueue.main.async { [weak self] in
                self?.imageClothView.image = image
            }
        }
        title.text = model.title
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
            .vCenter()
            .marginLeft(Constants.labelLeftMargin)
            .right()
            .top()
            .height(Constants.labelHeightPercent%)
    }
    
    private func setup() {
        separatorInset = .zero
    
        contentView.addSubviews(imageClothView, title)
        title.verticalAlignment = .bottom
        title.font = FontFamily.Inter.regular.font(size: 14)

        imageClothView.addOverlay()
        imageClothView.layer.cornerRadius = Constants.imageCornerRadius
        imageClothView.layer.masksToBounds = true
    }
    
    static func height() -> CGFloat {
        return Constants.imageClothSideSize + Constants.imageClothVerticallyMargin * 2 + Constants.imageMargin
    }
}
