import SwiftUI

struct LoginView: View {
    @State private var username = ""
    @State private var password = ""
    @State private var rememberMe = true
    @State private var statusMessage = "请输入登录信息"
    @State private var isLoading = false
    @State private var showSuccess = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                // Logo
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .frame(width: 80, height: 80)
                    .foregroundColor(.blue)
                    .accessibilityIdentifier("login_logo_image")
                
                // Username
                TextField("请输入用户名", text: $username)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocapitalization(.none)
                    .accessibilityIdentifier("login_username_textfield")
                
                // Password
                SecureField("请输入密码", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .accessibilityIdentifier("login_password_textfield")
                
                // Remember Me
                HStack {
                    Toggle("记住我", isOn: $rememberMe)
                        .accessibilityIdentifier("login_remember_switch")
                    Spacer()
                }
                
                // Login Button
                Button(action: loginAction) {
                    if isLoading {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    } else {
                        Text("登录")
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                    }
                }
                .frame(height: 50)
                .background(Color.blue)
                .cornerRadius(8)
                .disabled(isLoading)
                .accessibilityIdentifier("login_submit_button")
                
                // Status Message
                Text(statusMessage)
                    .foregroundColor(statusColor)
                    .accessibilityIdentifier("login_status_label")
                
                Spacer()
            }
            .padding()
            .navigationTitle("登录测试")
            .alert(isPresented: $showSuccess) {
                Alert(title: Text("成功"), message: Text("登录成功！"), dismissButton: .default(Text("确定")))
            }
        }
    }
    
    private var statusColor: Color {
        if statusMessage.contains("成功") {
            return .green
        } else if statusMessage.contains("错误") || statusMessage.contains("不能为空") {
            return .red
        }
        return .gray
    }
    
    private func loginAction() {
        guard !username.isEmpty, !password.isEmpty else {
            statusMessage = "用户名或密码不能为空"
            return
        }
        
        isLoading = true
        statusMessage = "登录中..."
        
        // Simulate login
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            isLoading = false
            
            if username == "admin" && password == "123456" {
                statusMessage = "登录成功！"
                showSuccess = true
            } else {
                statusMessage = "用户名或密码错误"
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
