//
//  ScrollViewController.swift
//  Demo-iOS
//
//  Created by William Towe on 10/15/20.
//  Copyright © 2020 Kosoku Interactive, LLC. All rights reserved.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.

import Ditko

extension KDIScrollViewFadeAxis: CustomStringConvertible {
    public var description: String {
        switch self {
        case .none:
            return "None"
        case .horizontal:
            return "Horizontal"
        case .vertical:
            return "Vertical"
        default:
            return "UNKNOWN"
        }
    }
}

final class ScrollViewController: UIViewController, DetailViewController {
    private let stackView = UIStackView()
    private let axisSegmentedControl = UISegmentedControl()
    private let leadingEdgeTextField = KDITextField()
    private let trailingEdgeTextField = KDITextField()
    private let scrollView = KDIScrollView()
    private let label = UILabel()
    
    private let fadeAxes: [KDIScrollViewFadeAxis] = [
        .none,
        .horizontal,
        .vertical
    ]
    
    static func detailViewTitle() -> String! {
        return "KDIScrollView"
    }
    static func detailViewSubtitle() -> String! {
        return "UIScrollView with a fade effect"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = Self.detailViewTitle()
        self.kso_addNavigationBarTitleView()
        
        self.stackView.translatesAutoresizingMaskIntoConstraints = false
        self.stackView.axis = .vertical
        self.stackView.spacing = 8.0
        self.view.addSubview(self.stackView)
        
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[view]-|", options: [], metrics: nil, views: ["view": self.stackView]))
        NSLayoutConstraint.activate([self.stackView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 8.0)])
        
        self.axisSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        self.axisSegmentedControl.removeAllSegments()
        for axis in self.fadeAxes {
            self.axisSegmentedControl.insertSegment(withTitle: axis.description, at: self.axisSegmentedControl.numberOfSegments, animated: false)
        
        }
        self.axisSegmentedControl.selectedSegmentIndex = 0
        self.axisSegmentedControl.kdi_add({ [weak self] (_, _) in
            guard let index = self?.axisSegmentedControl.selectedSegmentIndex, let axis = self?.fadeAxes[index] else {
                return
            }
            
            self?.scrollView.fadeAxis = axis
        }, for: .valueChanged)
        self.stackView.addArrangedSubview(self.axisSegmentedControl)
        
        let formatter = NumberFormatter()
        
        formatter.numberStyle = .decimal
        
        self.leadingEdgeTextField.translatesAutoresizingMaskIntoConstraints = false
        self.leadingEdgeTextField.inputAccessoryView = KDINextPreviousInputAccessoryView(frame: .zero, responder: self.leadingEdgeTextField)
        self.leadingEdgeTextField.borderStyle = .roundedRect
        self.leadingEdgeTextField.textEdgeInsets = UIEdgeInsets(top: 0.0, left: 8.0, bottom: 0.0, right: 8.0)
        self.leadingEdgeTextField.placeholder = "Leading Edge Percentage"
        self.leadingEdgeTextField.kdi_add({ [weak self] (_, _) in
            guard let text = self?.leadingEdgeTextField.text, !text.isEmpty, let percentage = formatter.number(from: text)?.floatValue else {
                return
            }
            
            self?.scrollView.leadingEdgeFadePercentage = percentage
        }, for: .editingChanged)
        self.stackView.addArrangedSubview(self.leadingEdgeTextField)
        
        self.trailingEdgeTextField.translatesAutoresizingMaskIntoConstraints = false
        self.trailingEdgeTextField.inputAccessoryView = KDINextPreviousInputAccessoryView(frame: .zero, responder: self.trailingEdgeTextField)
        self.trailingEdgeTextField.borderStyle = .roundedRect
        self.trailingEdgeTextField.textEdgeInsets = UIEdgeInsets(top: 0.0, left: 8.0, bottom: 0.0, right: 8.0)
        self.trailingEdgeTextField.placeholder = "Leading Edge Percentage"
        self.trailingEdgeTextField.kdi_add({ [weak self] (_, _) in
            guard let text = self?.trailingEdgeTextField.text, !text.isEmpty, let percentage = formatter.number(from: text)?.floatValue else {
                return
            }
            
            self?.scrollView.trailingEdgeFadePercentage = percentage
        }, for: .editingChanged)
        self.stackView.addArrangedSubview(self.trailingEdgeTextField)
        
        self.title = Self.detailViewTitle()
        self.view.backgroundColor = .white
        self.scrollView.translatesAutoresizingMaskIntoConstraints = false
        if #available(iOS 11.0, *) {
            self.scrollView.contentInsetAdjustmentBehavior = .never
        }
        self.view.addSubview(self.scrollView)
        
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[view]-|", options: [], metrics: nil, views: ["view": self.scrollView]))
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "V:[top]-[view]-|", options: [], metrics: nil, views: ["view": self.scrollView, "top": self.stackView]))
        
        self.label.translatesAutoresizingMaskIntoConstraints = false
        self.label.numberOfLines = 0
        self.label.text = LoremIpsum.paragraphs(withNumber: 10)
        self.scrollView.addSubview(self.label)
        
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "H:|[view]|", options: [], metrics: nil, views: ["view": self.label]))
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "V:|[view]|", options: [], metrics: nil, views: ["view": self.label]))
        NSLayoutConstraint.activate([self.label.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor)])
    }
}
