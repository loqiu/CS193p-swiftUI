//
//  FormExample.swift
//  CS193p
//
//  Created by 王崇锦 on 09/01/2025.
//
import SwiftUI

struct FormExample: View {
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var errorMessage: String? = nil

    var body: some View {
        Form {
            Section(header: Text("User Information")) {
                TextField("Name", text: $name)
                    .autocapitalization(.words)
                TextField("Email", text: $email)
                    .keyboardType(.emailAddress)
                SecureField("Password", text: $password)
            }

            if let error = errorMessage {
                Text(error)
                    .foregroundColor(.red)
            }

            Button("Submit") {
                submitForm()
            }
            .disabled(!isFormValid()) // 禁用按钮，直到表单有效
        }
    }

    // 表单验证逻辑
    func isFormValid() -> Bool {
        !name.isEmpty && isValidEmail(email) && password.count >= 6
    }

    func isValidEmail(_ email: String) -> Bool {
        // 简单的正则表达式验证邮箱格式
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email)
    }

    // 表单提交逻辑
    func submitForm() {
        if isFormValid() {
            // 处理成功提交
            print("Form submitted successfully!")
            errorMessage = nil
        } else {
            // 提示错误信息
            errorMessage = "Please ensure all fields are valid."
        }
    }
}

#Preview {
    FormExample()
}
