import SwiftUI

struct FormTestView: View {
    @State private var name = ""
    @State private var email = ""
    @State private var phone = ""
    @State private var gender = 0
    @State private var age = 25.0
    @State private var receiveNotification = true
    @State private var selectedDate = Date()
    @State private var resultMessage = "等待提交..."
    
    let genders = ["男", "女", "其他"]
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("基本信息")) {
                    TextField("姓名", text: $name)
                        .accessibilityIdentifier("form_name_textfield")
                    
                    TextField("邮箱", text: $email)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                        .accessibilityIdentifier("form_email_textfield")
                    
                    TextField("手机号", text: $phone)
                        .keyboardType(.phonePad)
                        .accessibilityIdentifier("form_phone_textfield")
                }
                
                Section(header: Text("其他选项")) {
                    Picker("性别", selection: $gender) {
                        ForEach(0..<genders.count) {
                            Text(self.genders[$0])
                        }
                    }
                    .accessibilityIdentifier("form_gender_picker")
                    
                    VStack(alignment: .leading) {
                        Text("年龄: \(Int(age))")
                            .accessibilityIdentifier("form_age_label")
                        Slider(value: $age, in: 0...100, step: 1)
                            .accessibilityIdentifier("form_age_slider")
                    }
                    
                    Toggle("接收通知", isOn: $receiveNotification)
                        .accessibilityIdentifier("form_notification_switch")
                    
                    DatePicker("日期", selection: $selectedDate, displayedComponents: .date)
                        .accessibilityIdentifier("form_date_picker")
                }
                
                Section {
                    Button(action: submitForm) {
                        Text("提交")
                            .frame(maxWidth: .infinity)
                            .foregroundColor(.white)
                    }
                    .listRowBackground(Color.green)
                    .accessibilityIdentifier("form_submit_button")
                }
                
                Section {
                    Text(resultMessage)
                        .foregroundColor(.gray)
                        .accessibilityIdentifier("form_result_label")
                }
            }
            .navigationTitle("表单测试")
        }
    }
    
    private func submitForm() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        let dateString = dateFormatter.string(from: selectedDate)
        
        resultMessage = """
        提交成功！
        姓名: \(name)
        邮箱: \(email)
        手机: \(phone)
        性别: \(genders[gender])
        年龄: \(Int(age))
        通知: \(receiveNotification ? "是" : "否")
        日期: \(dateString)
        """
        
        // Clear form
        name = ""
        email = ""
        phone = ""
    }
}

struct FormTestView_Previews: PreviewProvider {
    static var previews: some View {
        FormTestView()
    }
}
