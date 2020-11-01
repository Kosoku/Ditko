//
//  TextFieldViewController.swift
//  Demo-iOS
//
//  Created by William Towe on 10/20/20.
//  Copyright © 2020 Kosoku Interactive, LLC. All rights reserved.
//

import Ditko
import KSOFontAwesomeExtensions

final class TextFieldViewController: UIViewController, DetailViewController {
    private struct TextFieldOptions: OptionSet {
        let rawValue: UInt
        
        static let alignmentLeft = TextFieldOptions(1 << 0)
        static let alignmentCenter = TextFieldOptions(1 << 1)
        static let alignmentRight = TextFieldOptions(1 << 2)
        
        static let leftView = TextFieldOptions(1 << 3)
        static let rightView = TextFieldOptions(1 << 4)
        
        static let none: TextFieldOptions = []
        
        init(_ rawValue: UInt) {
            self.rawValue = rawValue
        }
        init(rawValue: UInt) {
            self.rawValue = rawValue
        }
    }
    
    private let scrollView = KDIScrollView()
    private let stackView = UIStackView()
    
    private let options: [TextFieldOptions] = [
        [.alignmentCenter],
        [.alignmentCenter, .leftView],
        [.alignmentCenter, .rightView],
        [.alignmentCenter, .leftView, .rightView],
        
        [.alignmentLeft],
        [.alignmentLeft, .leftView],
        [.alignmentLeft, .rightView],
        [.alignmentLeft, .leftView, .rightView],
        
        [.alignmentRight],
        [.alignmentRight, .leftView],
        [.alignmentRight, .rightView],
        [.alignmentRight, .leftView, .rightView],
    ]
    
    static func detailViewTitle() -> String! {
        "KDITextField"
    }
    static func detailViewSubtitle() -> String! {
        "UITextField subclass with edge insets"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = Self.detailViewTitle()
        self.kso_addNavigationBarTitleView()
        
        self.view.backgroundColor = .white
        
        self.scrollView.translatesAutoresizingMaskIntoConstraints = false
        self.scrollView.fadeAxis = .vertical
        self.scrollView.leadingEdgeFadePercentage = 0.1
        self.scrollView.trailingEdgeFadePercentage = 0.1
        self.view.addSubview(self.scrollView)
        
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[view]-|", options: [], metrics: nil, views: ["view": self.scrollView]))
        NSLayoutConstraint.activate([
            self.scrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.scrollView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        self.stackView.translatesAutoresizingMaskIntoConstraints = false
        self.stackView.axis = .vertical
        self.stackView.distribution = .equalSpacing
        self.stackView.spacing = 8.0
        self.scrollView.addSubview(self.stackView)
        
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "H:|[view]|", options: [], metrics: nil, views: ["view": self.stackView]))
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[view]->=8-|", options: [], metrics: nil, views: ["view": self.stackView]))
        NSLayoutConstraint.activate([
            self.stackView.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor)
        ])
        
        var textFields = [KDITextField]()
        
        for options in self.options {
            let textField = KDITextField()
            
            textField.translatesAutoresizingMaskIntoConstraints = false
            textField.borderStyle = .roundedRect
            textField.adjustsFontForContentSizeCategory = true
            textField.font = UIFont.preferredFont(forTextStyle: .body)
            textField.inputAccessoryView = KDINextPreviousInputAccessoryView(frame: .zero, responder: textField)
            textField.textEdgeInsets = UIEdgeInsets(top: kSubviewMargin, left: kSubviewPadding, bottom: kSubviewMargin, right: kSubviewPadding)
            
            if options.contains(.alignmentLeft) {
                textField.textAlignment = .left
                textField.placeholder = "Left aligned"
            }
            else if options.contains(.alignmentCenter) {
                textField.textAlignment = .center
                textField.placeholder = "Center aligned"
            }
            else if options.contains(.alignmentRight) {
                textField.textAlignment = .right
                textField.placeholder = "Right aligned"
            }
            
            if options.contains(.leftView) {
                textField.leftView = self.createTextFieldLeftView()
                textField.leftViewMode = .always
                textField.leftViewEdgeInsets = UIEdgeInsets(top: 0.0, left: kSubviewPadding, bottom: 0.0, right: 0.0)
            }
            
            if options.contains(.rightView) {
                textField.rightView = self.createTextFieldRightView()
                textField.rightViewMode = .always
                textField.rightViewEdgeInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: kSubviewPadding)
            }
            
            self.stackView.addArrangedSubview(textField)
            textFields.append(textField)
        }
        
        self.kdi_registerForNextPreviousNotifications(with: textFields)
    }
    
    private func createTextFieldLeftView() -> UIView {
        let retval = UIImageView(image: UIImage.kso_fontAwesomeSolidImage(with: "\u{f0f3}", size: kBarButtonItemImageSize)?.kdi_template)
        
        retval.translatesAutoresizingMaskIntoConstraints = false
        
        return retval
    }
    private func createTextFieldRightView() -> UIView {
        let retval = UIButton(type: .system)
        
        retval.translatesAutoresizingMaskIntoConstraints = false
        retval.setTitle("Button", for: .normal)
        
        return retval
    }
}
