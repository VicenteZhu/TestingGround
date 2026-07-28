import UIKit

class LoginViewController: UIViewController {
    
    // MARK: - UI Components (带测试ID)
    private let logoImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "person.circle.fill")
        iv.tintColor = .systemBlue
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.accessibilityIdentifier = "login_logo_image"
        return iv
    }()
    
    private let usernameTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "请输入用户名"
        tf.borderStyle = .roundedRect
        tf.autocapitalizationType = .none
        tf.autocorrectionType = .no
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.accessibilityIdentifier = "login_username_textfield"
        return tf
    }()
    
    private let passwordTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "请输入密码"
        tf.borderStyle = .roundedRect
        tf.isSecureTextEntry = true
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.accessibilityIdentifier = "login_password_textfield"
        return tf
    }()
    
    private let loginButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("登录", for: .normal)
        btn.backgroundColor = .systemBlue
        btn.setTitleColor(.white, for: .normal)
        btn.layer.cornerRadius = 8
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.accessibilityIdentifier = "login_submit_button"
        return btn
    }()
    
    private let rememberSwitch: UISwitch = {
        let sw = UISwitch()
        sw.isOn = true
        sw.translatesAutoresizingMaskIntoConstraints = false
        sw.accessibilityIdentifier = "login_remember_switch"
        return sw
    }()
    
    private let rememberLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "记住我"
        lbl.font = UIFont.systemFont(ofSize: 14)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.accessibilityIdentifier = "login_remember_label"
        return lbl
    }()
    
    private let statusLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "请输入登录信息"
        lbl.font = UIFont.systemFont(ofSize: 14)
        lbl.textColor = .gray
        lbl.textAlignment = .center
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.accessibilityIdentifier = "login_status_label"
        return lbl
    }()
    
    private let activityIndicator: UIActivityIndicatorView = {
        let ai = UIActivityIndicatorView(style: .medium)
        ai.hidesWhenStopped = true
        ai.translatesAutoresizingMaskIntoConstraints = false
        ai.accessibilityIdentifier = "login_activity_indicator"
        return ai
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
        title = "登录测试"
        
        view.addSubview(logoImageView)
        view.addSubview(usernameTextField)
        view.addSubview(passwordTextField)
        view.addSubview(loginButton)
        view.addSubview(rememberSwitch)
        view.addSubview(rememberLabel)
        view.addSubview(statusLabel)
        view.addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.widthAnchor.constraint(equalToConstant: 80),
            logoImageView.heightAnchor.constraint(equalToConstant: 80),
            
            usernameTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 40),
            usernameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            usernameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            usernameTextField.heightAnchor.constraint(equalToConstant: 44),
            
            passwordTextField.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 16),
            passwordTextField.leadingAnchor.constraint(equalTo: usernameTextField.leadingAnchor),
            passwordTextField.trailingAnchor.constraint(equalTo: usernameTextField.trailingAnchor),
            passwordTextField.heightAnchor.constraint(equalToConstant: 44),
            
            rememberSwitch.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
            rememberSwitch.leadingAnchor.constraint(equalTo: usernameTextField.leadingAnchor),
            
            rememberLabel.centerYAnchor.constraint(equalTo: rememberSwitch.centerYAnchor),
            rememberLabel.leadingAnchor.constraint(equalTo: rememberSwitch.trailingAnchor, constant: 8),
            
            loginButton.topAnchor.constraint(equalTo: rememberSwitch.bottomAnchor, constant: 30),
            loginButton.leadingAnchor.constraint(equalTo: usernameTextField.leadingAnchor),
            loginButton.trailingAnchor.constraint(equalTo: usernameTextField.trailingAnchor),
            loginButton.heightAnchor.constraint(equalToConstant: 50),
            
            statusLabel.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 20),
            statusLabel.leadingAnchor.constraint(equalTo: usernameTextField.leadingAnchor),
            statusLabel.trailingAnchor.constraint(equalTo: usernameTextField.trailingAnchor),
            
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.topAnchor.constraint(equalTo: statusLabel.bottomAnchor, constant: 20)
        ])
    }
    
    private func setupActions() {
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - Actions
    @objc private func loginButtonTapped() {
        guard let username = usernameTextField.text, !username.isEmpty,
              let password = passwordTextField.text, !password.isEmpty else {
            statusLabel.text = "用户名或密码不能为空"
            statusLabel.textColor = .red
            return
        }
        
        // 模拟登录
        activityIndicator.startAnimating()
        statusLabel.text = "登录中..."
        statusLabel.textColor = .gray
        loginButton.isEnabled = false
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { [weak self] in
            guard let self = self else { return }
            self.activityIndicator.stopAnimating()
            self.loginButton.isEnabled = true
            
            if username == "admin" && password == "123456" {
                self.statusLabel.text = "登录成功！"
                self.statusLabel.textColor = .systemGreen
                
                // 保存登录状态
                UserDefaults.standard.set(true, forKey: "isLoggedIn")
                UserDefaults.standard.set(username, forKey: "username")
            } else {
                self.statusLabel.text = "用户名或密码错误"
                self.statusLabel.textColor = .red
            }
        }
    }
}
