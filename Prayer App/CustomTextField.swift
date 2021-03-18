//
//  CustomTextField.swift
//  Prayer App
//
//  Created by tomrunnels on 3/16/21.
//

import Foundation
import SwiftUI

struct CustomTextField: View {
    
    var placeholder: Text
    @Binding var text: String
    var editingChanged: (Bool)->() = { _ in }
    var commit: ()->() = { }

    init(placeholder: Text, text: Binding<String>, editingChanged: @escaping (Bool) -> () = { _ in }, commit: @escaping () -> () = { }) {
        self.placeholder = placeholder
        self._text = text
        self.editingChanged = editingChanged
        self.commit = commit
    }
    
    init(placeholderText: String, text: Binding<String>, editingChanged: @escaping (Bool) -> () = { _ in }, commit: @escaping () -> () = { }) {
        self.placeholder = Text(placeholderText).foregroundColor(.gray)
        self._text = text
        self.editingChanged = editingChanged
        self.commit = commit
    }
    

    var body: some View {
        ZStack(alignment: .leading) {
            if text.isEmpty { placeholder }
            TextField("", text: $text, onEditingChanged: editingChanged, onCommit: commit)
        }
    }
}



struct CustomTextField_Section: View {
    var placeholder: Text
    @Binding var text: String
    var sectionTitle: String
    var editingChanged: (Bool)->() = { _ in }
    var commit: ()->() = { }
    
    init(placeholder: Text, text: Binding<String>, sectionTitle: String, editingChanged: @escaping (Bool) -> () = { _ in }, commit: @escaping () -> () = { }) {
        self.placeholder = placeholder
        self._text = text
        self.editingChanged = editingChanged
        self.commit = commit
        self.sectionTitle = sectionTitle
    }
    
    init(placeholderText: String, text: Binding<String>,  sectionTitle: String, editingChanged: @escaping (Bool) -> () = { _ in }, commit: @escaping () -> () = { }) {
        self.placeholder = Text(placeholderText).foregroundColor(.gray)
        self._text = text
        self.editingChanged = editingChanged
        self.commit = commit
        self.sectionTitle = sectionTitle

    }

    var body: some View {
        Section(header: Text(sectionTitle)) {
            ZStack(alignment: .leading) {
                if text.isEmpty { placeholder }
                TextField("", text: $text, onEditingChanged: editingChanged, onCommit: commit)
            }
        }
    }
}
