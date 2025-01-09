//
//  EnhancedFormExample.swift
//  CS193p
//
//  Created by 王崇锦 on 09/01/2025.
//
import SwiftUI

struct EnhancedFormExample: View {
    @State private var username = ""
    @State private var email = ""
    @State private var password = ""
    @State private var errorMessage: String? = nil
    @State private var showAlert = false

    var body: some View {
        Form {
            Section(header: Text("User Info")) {
                TextField("Username", text: $username)
                    .autocapitalization(.none)
                TextField("Email", text: $email)
                    .keyboardType(.emailAddress)
                SecureField("Password", text: $password)
            }

            if let error = errorMessage {
                Text(error)
                    .foregroundColor(.red)
                    .font(.caption)
            }

            Button("Submit") {
                submitForm()
            }
            .disabled(!isFormValid())
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Success"),
                    message: Text("Form submitted successfully!"),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
        .padding()
    }

    func isFormValid() -> Bool {
        !username.isEmpty && isValidEmail(email) && isValidPassword(password)
    }

    func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email)
    }

    func isValidPassword(_ password: String) -> Bool {
        let passwordRegex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[@$!%*?&#])[A-Za-z\\d@$!%*?&#]{8,}$"
        return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: password)
    }

    func submitForm() {
        if isFormValid() {
            showAlert = true
            errorMessage = nil
        } else {
            errorMessage = "Please correct the errors before submitting."
        }
    }
}

#Preview {
    EnhancedFormExample()
}
