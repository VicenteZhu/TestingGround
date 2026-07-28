import UIKit

class AlertTestViewController: UIViewController {
    
    // MARK: - UI Components (带测试ID)
    private let alertButton1: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("简单弹窗", for: .normal)
        btn.backgroundColor = .systemBlue
        btn.setTitleColor(.white, for: .normal)
        btn.layer.cornerRadius = 8
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.accessibilityIdentifier = "alert_simple_button"
        return btn
    }()
    
    private let alertButton2: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("确认弹窗", for: .normal)
        btn.backgroundColor = .systemOrange
        btn.setTitleColor(.white, for: .normal)
        btn.layer.cornerRadius = 8
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.accessibilityIdentifier = "alert_confirm_button"
        return btn
    }()
    
    private let alertButton3: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("输入弹窗", for: .normal)
        btn.backgroundColor = .systemGreen
        btn.setTitleColor(.white, for: .normal)
        btn.layer.cornerRadius = 8
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.accessibilityIdentifier = "alert_input_button"
        return btn
    }()
    
    private let actionSheetButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("操作表", for: .normal)
        btn.backgroundColor = .systemPurple
        btn.setTitleColor(.white, for: .normal)
        btn.layer.cornerRadius = 8
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.accessibilityIdentifier = "alert_actionsheet_button"
        return btn
    }()
    
    private let customAlertButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("自定义弹窗", for: .normal)
        btn.backgroundColor = .systemPink
        btn.setTitleColor(.white, for: .normal)
        btn.layer.cornerRadius = 8
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.accessibilityIdentifier = "alert_custom_button"
        return btn
    }()
    
    private let resultLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "点击按钮测试弹窗"
        lbl.font = UIFont.systemFont(ofSize: 14)
        lbl.textColor = .gray
        lbl.textAlignment = .center
        lbl.numberOfLines = 0
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.accessibilityIdentifier = "alert_result_label"
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
        title = "弹窗测试"
        
        let stackView = UIStackView(arrangedSubviews: [
            alertButton1, alertButton2, alertButton3,
            actionSheetButton, customAlertButton
        ])
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stackView)
        view.addSubview(resultLabel)
        
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            stackView.heightAnchor.constraint(equalToConstant: 300),
            
            resultLabel.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 30),
            resultLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            resultLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    private func setupActions() {
        alertButton1.addTarget(self, action: #selector(showSimpleAlert), for: .touchUpInside)
        alertButton2.addTarget(self, action: #selector(showConfirmAlert), for: .touchUpInside)
        alertButton3.addTarget(self, action: #selector(showInputAlert), for: .touchUpInside)
        actionSheetButton.addTarget(self, action: #selector(showActionSheet), for: .touchUpInside)
        customAlertButton.addTarget(self, action: #selector(showCustomAlert), for: .touchUpInside)
    }
    
    // MARK: - Alert Actions
    @objc private func showSimpleAlert() {
        let alert = UIAlertController(title: "提示", message: "这是一个简单的弹窗", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "确定", style: .default, handler: { _ in
            self.resultLabel.text = "点击了简单弹窗的确定按钮"
        }))
        present(alert, animated: true, completion: nil)
    }
    
    @objc private func showConfirmAlert() {
        let alert = UIAlertController(title: "确认", message: "您确定要执行此操作吗？", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "取消", style: .cancel, handler: { _ in
            self.resultLabel.text = "点击了取消按钮"
        }))
        alert.addAction(UIAlertAction(title: "确定", style: .destructive, handler: { _ in
            self.resultLabel.text = "点击了确定按钮（ destructive ）"
        }))
        present(alert, animated: true, completion: nil)
    }
    
    @objc private func showInputAlert() {
        let alert = UIAlertController(title: "输入", message: "请输入您的信息", preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = "请输入姓名"
            textField.accessibilityIdentifier = "alert_input_textfield"
        }
        alert.addAction(UIAlertAction(title: "取消", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "确定", style: .default, handler: { _ in
            let text = alert.textFields?.first?.text ?? ""
            self.resultLabel.text = "输入的内容: \(text)"
        }))
        present(alert, animated: true, completion: nil)
    }
    
    @objc private func showActionSheet() {
        let actionSheet = UIAlertController(title: "操作表", message: "请选择一个操作", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "拍照", style: .default, handler: { _ in
            self.resultLabel.text = "选择了拍照"
        }))
        actionSheet.addAction(UIAlertAction(title: "从相册选择", style: .default, handler: { _ in
            self.resultLabel.text = "选择了从相册选择"
        }))
        actionSheet.addAction(UIAlertAction(title: "取消", style: .cancel, handler: { _ in
            self.resultLabel.text = "取消了操作表"
        }))
        present(actionSheet, animated: true, completion: nil)
    }
    
    @objc private func showCustomAlert() {
        // 自定义弹窗 (使用 UIAlertController 的自定义方式)
        let alert = UIAlertController(title: "\n\n\n", message: nil, preferredStyle: .alert)
        
        let iconImageView = UIImageView(image: UIImage(systemName: "checkmark.circle.fill"))
        iconImageView.tintColor = .systemGreen
        iconImageView.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        iconImageView.center = CGPoint(x: 135, y: 40)
        alert.view.addSubview(iconImageView)
        
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 70, width: 270, height: 30))
        messageLabel.text = "操作成功完成！"
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont.boldSystemFont(ofSize: 16)
        alert.view.addSubview(messageLabel)
        
        alert.addAction(UIAlertAction(title: "确定", style: .default, handler: { _ in
            self.resultLabel.text = "点击了自定义弹窗的确定按钮"
        }))
        
        present(alert, animated: true, completion: nil)
    }
}
