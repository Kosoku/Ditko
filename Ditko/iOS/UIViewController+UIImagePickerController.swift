//
//  UIViewController+UIImagePickerController.swift
//  Ditko-iOS
//
//  Created by William Towe on 10/22/21.
//  Copyright © 2021 Kosoku Interactive, LLC. All rights reserved.
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

import UIKit

public extension UIViewController {
    // MARK: - Public Functions
    /**
     Presents the provided `UIImagePickerController` from *barButtonItem*.
     
     - Parameter imagePickerController: The image picker controller to present
     - Parameter barButtonItem: The bar button item to use when presenting as a popover
     - Parameter permittedArrowDirections: The permitted arrow directions when presenting as a popover, defaults to `UIPopoverArrowDirection.any`
     - Parameter animated: Whether to animate the presentation, defaults to `true`
     - Parameter completion: The completion block to invoke when the presentation has finished
     */
    func presentImagePickerController(_ imagePickerController: UIImagePickerController, barButtonItem: UIBarButtonItem, permittedArrowDirections: UIPopoverArrowDirection = .any, animated: Bool = true, completion: @escaping ([UIImagePickerController.InfoKey: Any]?) -> Void) {
        self.__kdi_present(imagePickerController, barButtonItem: barButtonItem, sourceView: nil, sourceRect: .zero, permittedArrowDirections: permittedArrowDirections, animated: animated, completion: completion)
    }
    
    /**
     Presents the provided `UIImagePickerController` from *sourceView*.
     
     - Parameter imagePickerController: The image picker controller to present
     - Parameter sourceView: The source view to use when presenting as a popover
     - Parameter sourceRect: The source rect to use when presenting as a popover, defaults to `CGRect.zero`
     - Parameter permittedArrowDirections: The permitted arrow directions when presenting as a popover, defaults to `UIPopoverArrowDirection.any`
     - Parameter animated: Whether to animate the presentation, defaults to `true`
     - Parameter completion: The completion block to invoke when the presentation has finished
     */
    func presentImagePickerController(_ imagePickerController: UIImagePickerController, sourceView: UIView, sourceRect: CGRect = .zero, permittedArrowDirections: UIPopoverArrowDirection = .any, animated: Bool = true, completion: @escaping ([UIImagePickerController.InfoKey: Any]?) -> Void) {
        self.__kdi_present(imagePickerController, barButtonItem: nil, sourceView: sourceView, sourceRect: sourceRect, permittedArrowDirections: permittedArrowDirections, animated: animated, completion: completion)
    }
}
