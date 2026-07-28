import UIKit

class FormTestViewController: UIViewController {
    
    // MARK: - UI Components (带测试ID)
    private let scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.accessibilityIdentifier = "form_scroll_view"
        return sv
    }()
    
    private let contentView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    private let nameTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "姓名"
        tf.borderStyle = .roundedRect
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.accessibilityIdentifier = "form_name_textfield"
        return tf
    }()
    
    private let emailTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "邮箱"
        tf.borderStyle = .roundedRect
        tf.keyboardType = .emailAddress
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.accessibilityIdentifier = "form_email_textfield"
        return tf
    }()
    
    private let phoneTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "手机号"
        tf.borderStyle = .roundedRect
        tf.keyboardType = .phonePad
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.accessibilityIdentifier = "form_phone_textfield"
        return tf
    }()
    
    private let genderSegment: UISegmentedControl = {
        let sg = UISegmentedControl(items: ["男", "女", "其他"])
        sg.selectedSegmentIndex = 0
        sg.translatesAutoresizingMaskIntoConstraints = false
        sg.accessibilityIdentifier = "form_gender_segment"
        return sg
    }()
    
    private let ageSlider: UISlider = {
        let sl = UISlider()
        sl.minimumValue = 0
        sl.maximumValue = 100
        sl.value = 25
        sl.translatesAutoresizingMaskIntoConstraints = false
        sl.accessibilityIdentifier = "form_age_slider"
        return sl
    }()
    
    private let ageLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "年龄: 25"
        lbl.font = UIFont.systemFont(ofSize: 14)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.accessibilityIdentifier = "form_age_label"
        return lbl
    }()
    
    private let notificationSwitch: UISwitch = {
        let sw = UISwitch()
        sw.isOn = true
        sw.translatesAutoresizingMaskIntoConstraints = false
        sw.accessibilityIdentifier = "form_notification_switch"
        return sw
    }()
    
    private let notificationLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "接收通知"
        lbl.font = UIFont.systemFont(ofSize: 14)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.accessibilityIdentifier = "form_notification_label"
        return lbl
    }()
    
    private let datePicker: UIDatePicker = {
        let dp = UIDatePicker()
        dp.datePickerMode = .date
        dp.translatesAutoresizingMaskIntoConstraints = false
        dp.accessibilityIdentifier = "form_date_picker"
        return dp
    }()
    
    private let submitButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("提交", for: .normal)
        btn.backgroundColor = .systemGreen
        btn.setTitleColor(.white, for: .normal)
        btn.layer.cornerRadius = 8
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.accessibilityIdentifier = "form_submit_button"
        return btn
    }()
    
    private let resultLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "等待提交..."
        lbl.font = UIFont.systemFont(ofSize: 14)
        lbl.textColor = .gray
        lbl.textAlignment = .center
        lbl.numberOfLines = 0
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.accessibilityIdentifier = "form_result_label"
        return lbl
    }()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupActions()
    }
    
    // MARK: - Setup
    private func setupUI() {
        view.backgroundColor = .white
        title = "表单测试"
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(nameTextField)
        contentView.addSubview(emailTextField)
        contentView.addSubview(phoneTextField)
        contentView.addSubview(genderSegment)
        contentView.addSubview(ageSlider)
        contentView.addSubview(ageLabel)
        contentView.addSubview(notificationSwitch)
        contentView.addSubview(notificationLabel)
        contentView.addSubview(datePicker)
        contentView.addSubview(submitButton)
        contentView.addSubview(resultLabel)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            nameTextField.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            nameTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            nameTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            nameTextField.heightAnchor.constraint(equalToConstant: 44),
            
            emailTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 12),
            emailTextField.leadingAnchor.constraint(equalTo: nameTextField.leadingAnchor),
            emailTextField.trailingAnchor.constraint(equalTo: nameTextField.trailingAnchor),
            emailTextField.heightAnchor.constraint(equalToConstant: 44),
            
            phoneTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 12),
            phoneTextField.leadingAnchor.constraint(equalTo: nameTextField.leadingAnchor),
            phoneTextField.trailingAnchor.constraint(equalTo: nameTextField.trailingAnchor),
            phoneTextField.heightAnchor.constraint(equalToConstant: 44),
            
            genderSegment.topAnchor.constraint(equalTo: phoneTextField.bottomAnchor, constant: 20),
            genderSegment.leadingAnchor.constraint(equalTo: nameTextField.leadingAnchor),
            genderSegment.trailingAnchor.constraint(equalTo: nameTextField.trailingAnchor),
            
            ageSlider.topAnchor.constraint(equalTo: genderSegment.bottomAnchor, constant: 20),
            ageSlider.leadingAnchor.constraint(equalTo: nameTextField.leadingAnchor),
            ageSlider.trailingAnchor.constraint(equalTo: nameTextField.trailingAnchor),
            
            ageLabel.topAnchor.constraint(equalTo: ageSlider.bottomAnchor, constant: 8),
            ageLabel.leadingAnchor.constraint(equalTo: nameTextField.leadingAnchor),
            
            notificationSwitch.topAnchor.constraint(equalTo: ageLabel.bottomAnchor, constant: 20),
            notificationSwitch.leadingAnchor.constraint(equalTo: nameTextField.leadingAnchor),
            
            notificationLabel.centerYAnchor.constraint(equalTo: notificationSwitch.centerYAnchor),
            notificationLabel.leadingAnchor.constraint(equalTo: notificationSwitch.trailingAnchor, constant: 8),
            
            datePicker.topAnchor.constraint(equalTo: notificationSwitch.bottomAnchor, constant: 20),
            datePicker.leadingAnchor.constraint(equalTo: nameTextField.leadingAnchor),
            datePicker.trailingAnchor.constraint(equalTo: nameTextField.trailingAnchor),
            
            submitButton.topAnchor.constraint(equalTo: datePicker.bottomAnchor, constant: 30),
            submitButton.leadingAnchor.constraint(equalTo: nameTextField.leadingAnchor),
            submitButton.trailingAnchor.constraint(equalTo: nameTextField.trailingAnchor),
            submitButton.heightAnchor.constraint(equalToConstant: 50),
            
            resultLabel.topAnchor.constraint(equalTo: submitButton.bottomAnchor, constant: 20),
            resultLabel.leadingAnchor.constraint(equalTo: nameTextField.leadingAnchor),
            resultLabel.trailingAnchor.constraint(equalTo: nameTextField.trailingAnchor),
            resultLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
    }
    
    private func setupActions() {
        submitButton.addTarget(self, action: #selector(submitTapped), for: .touchUpInside)
        ageSlider.addTarget(self, action: #selector(ageChanged(_:)), for: .valueChanged)
    }
    
    // MARK: - Actions
    @objc private func submitTapped() {
        let name = nameTextField.text ?? ""
        let email = emailTextField.text ?? ""
        let phone = phoneTextField.text ?? ""
        let gender = genderSegment.titleForSegment(at: genderSegment.selectedSegmentIndex) ?? ""
        let age = Int(ageSlider.value)
        let notification = notificationSwitch.isOn
        let date = DateFormatter.localizedString(from: datePicker.date, dateStyle: .medium, timeStyle: .none)
        
        let result = """
        提交成功！
        姓名: \(name)
        邮箱: \(email)
        手机: \(phone)
        性别: \(gender)
        年龄: \(age)
        通知: \(notification ? "是" : "否")
        日期: \(date)
        """
        
        resultLabel.text = result
        resultLabel.textColor = .systemGreen
        
        // 清空表单
        nameTextField.text = ""
        emailTextField.text = ""
        phoneTextField.text = ""
    }
    
    @objc private func ageChanged(_ sender: UISlider) {
        let age = Int(sender.value)
        ageLabel.text = "年龄: \(age)"
    }
}
