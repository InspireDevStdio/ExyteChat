//
//  CustomTextField.swift
//  Chat
//
//  Created by Aman Kumar on 22/08/25.
//

import Foundation
import SwiftUI

struct CustomTextField: UIViewRepresentable {
    @Environment(\.chatTheme) private var theme
    
    @Binding var text: String
    var inputFieldId: UUID
    var style: InputViewStyle
    var availableInputs: [AvailableInputType]
    var localization: ChatLocalization
    
    let initialHeight: CGFloat = 48
    let maxHeight: CGFloat = 200
    @Binding var textViewHeight: CGFloat
    
    func makeUIView(context: Context) -> UITextField {
        let textField = UITextField()
        textField.delegate = context.coordinator
        textField.font = UIFont.systemFont(ofSize: 15)
        textField.backgroundColor = UIColor.clear
        textField.borderStyle = .none
        textField.placeholder = localization.inputPlaceholder
        textField.textColor = UIColor(theme.colors.inputText)
        textField.attributedPlaceholder = NSAttributedString(
            string: localization.inputPlaceholder,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(theme.colors.inputPlaceholderText)]
        )
        
        // Set padding to match SwiftUI TextField
        let leftPadding = isMediaGiphyAvailable() ? 0 : 12
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: leftPadding, height: 48))
        textField.leftView = leftView
        textField.leftViewMode = .always
        
        let rightView = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: 48))
        textField.rightView = rightView
        textField.rightViewMode = .always

        return textField
    }

    func updateUIView(_ uiView: UITextField, context: Context) {
        // Only update if the text is actually different to avoid loops
        if uiView.text != text {
            uiView.text = text
        }
        
        // Calculate height (UITextField doesn't expand, so we keep it at initial height)
        if textViewHeight != initialHeight {
            textViewHeight = initialHeight
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UITextFieldDelegate {
        var parent: CustomTextField

        init(_ parent: CustomTextField) {
            self.parent = parent
        }

        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            // Calculate the new text
            let currentText = textField.text ?? ""
            guard let textRange = Range(range, in: currentText) else { return true }
            let newText = currentText.replacingCharacters(in: textRange, with: string)
            
            // Update the parent text using DispatchQueue to avoid publishing changes error
            DispatchQueue.main.async {
                self.parent.text = newText
            }
            return true
        }
    }
    
    private func isMediaGiphyAvailable() -> Bool {
        return availableInputs.contains(AvailableInputType.media)
        || availableInputs.contains(AvailableInputType.giphy)
    }
}
