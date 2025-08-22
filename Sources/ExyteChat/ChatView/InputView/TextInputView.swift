//
//  Created by Alex.M on 14.06.2022.
//

import SwiftUI

struct TextInputView: View {
    
    @Environment(\.chatTheme) private var theme
    
    @EnvironmentObject private var globalFocusState: GlobalFocusState
    
    @Binding var text: String
    var inputFieldId: UUID
    var style: InputViewStyle
    var availableInputs: [AvailableInputType]
    var localization: ChatLocalization
    
    @State private var textViewHeight: CGFloat = 48
    
    var body: some View {
        CustomTextField(
            text: $text,
            inputFieldId: inputFieldId,
            style: style,
            availableInputs: availableInputs,
            localization: localization,
            textViewHeight: $textViewHeight
        )
        .frame(height: textViewHeight)
        .onTapGesture {
            globalFocusState.focus = .uuid(inputFieldId)
        }
    }
}

