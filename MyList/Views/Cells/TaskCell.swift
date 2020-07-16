//
//  TaskCell.swift
//  MyList
//
//  Created by Samuel Folledo on 6/27/20.
//  Copyright © 2020 SamuelFolledo. All rights reserved.
//

import UIKit

class TaskCell: UITableViewCell {
    
    //MARK: Properties
    var task: Task! { didSet { populateViews() } }
    
    //MARK: View Properties
    lazy var mainStackView: UIStackView = {
        let stackView: UIStackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillProportionally
        stackView.spacing = 10
        return stackView
    }()
    lazy var verticalStackView: UIStackView = { //will contain the nameLabel, detailLabel, dueateLabel
        let stackView: UIStackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .fillProportionally
        stackView.spacing = 5
        return stackView
    }()
    lazy var nameLabel: UILabel = {
        let label: UILabel = UILabel()
        label.font = .font(size: 20, weight: .bold, design: .default)
        label.textColor = .label
        label.numberOfLines = 2
        label.textAlignment = .left
        return label
    }()
    lazy var detailLabel: UILabel = {
        let label: UILabel = UILabel()
        label.font = .font(size: 14, weight: .medium, design: .rounded)
        label.textColor = .secondaryLabel
        label.numberOfLines = 1
        label.textAlignment = .left
        label.isHidden = true
        return label
    }()
    lazy var dueDateLabel: UILabel = {
        let label: UILabel = UILabel()
        label.font = .font(size: 14, weight: .regular, design: .rounded)
        label.textColor = .secondaryLabel
        label.numberOfLines = 1
        label.textAlignment = .left
        label.isHidden = true
        return label
    }()
    lazy var colorView: ColorView = {
        let colorView = ColorView(shape: .square, color: .clear, isFilled: true, height: 40)
        return colorView
    }()
    
    //MARK: Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        self.setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = ""
        detailLabel.text = ""
        dueDateLabel.text = ""
    }
    
    //MARK: Private Methods
    func setupViews() {
        contentView.backgroundColor = .systemGray6
        //resize cell's line separator
        preservesSuperviewLayoutMargins = false
        separatorInset = UIEdgeInsets.init(top: 0, left: 16, bottom: 0, right: 16)
        layoutMargins = UIEdgeInsets.init(top: 0, left: 16, bottom: 0, right: 16)
        //add mainStackView to content view
        contentView.addSubview(mainStackView)
        mainStackView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-10)
        }
        mainStackView.addArrangedSubview(colorView)
        colorView.snp.makeConstraints { (make) in
            make.height.equalTo(30)
            make.width.equalTo(30)
            make.centerY.equalToSuperview()
        }
        mainStackView.addArrangedSubview(verticalStackView)
        verticalStackView.snp.makeConstraints { (make) in
            make.height.lessThanOrEqualToSuperview()
            make.width.lessThanOrEqualToSuperview()
        }
        verticalStackView.addArrangedSubview(nameLabel)
        nameLabel.snp.makeConstraints { (make) in
            make.height.equalTo(50)
            make.width.equalToSuperview()
        }
        verticalStackView.addArrangedSubview(detailLabel)
        detailLabel.snp.makeConstraints { (make) in
            make.height.equalTo(20)
            make.width.equalToSuperview()
        }
        verticalStackView.addArrangedSubview(dueDateLabel)
        dueDateLabel.snp.makeConstraints { (make) in
            make.height.equalTo(20)
            make.width.equalToSuperview()
        }
    }
    
    fileprivate func populateViews() {
        nameLabel.text = task.name
        if let dueDate = task.dueDate {
            detailLabel.isHidden = false
            detailLabel.text = dueDate.dateToDueDate
        }
        colorView.color = task.project!.color!
        colorView.isFilled = task.isDone //fill colorView if task isDone
    }
}
