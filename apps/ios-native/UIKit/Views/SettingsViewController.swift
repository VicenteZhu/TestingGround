import UIKit

class SettingsViewController: UIViewController {
    
    // MARK: - UI Components (带测试ID)
    private let tableView: UITableView = {
        let tv = UITableView(frame: .zero, style: .grouped)
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.accessibilityIdentifier = "settings_table_view"
        return tv
    }()
    
    private let themeSwitch: UISwitch = {
        let sw = UISwitch()
        sw.isOn = false
        sw.translatesAutoresizingMaskIntoConstraints = false
        sw.accessibilityIdentifier = "settings_theme_switch"
        return sw
    }()
    
    private let cacheLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "计算缓存中..."
        lbl.font = UIFont.systemFont(ofSize: 14)
        lbl.textColor = .gray
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.accessibilityIdentifier = "settings_cache_label"
        return lbl
    }()
    
    private let versionLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "v1.0.0"
        lbl.font = UIFont.systemFont(ofSize: 14)
        lbl.textColor = .gray
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.accessibilityIdentifier = "settings_version_label"
        return lbl
    }()
    
    // MARK: - Data
    private let settingsItems: [[String]] = [
        ["主题设置", "清除缓存", "关于我们"],
        ["隐私政策", "用户协议"]
    ]
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupActions()
        calculateCache()
    }
    
    // MARK: - Setup
    private func setupUI() {
        view.backgroundColor = .white
        title = "设置"
        
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(SettingsCell.self, forCellReuseIdentifier: "SettingsCell")
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func setupActions() {
        themeSwitch.addTarget(self, action: #selector(themeChanged(_:)), for: .valueChanged)
    }
    
    private func calculateCache() {
        // 模拟计算缓存
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            self?.cacheLabel.text = "23.5 MB"
        }
    }
    
    // MARK: - Actions
    @objc private func themeChanged(_ sender: UISwitch) {
        let style = sender.isOn ? "深色模式" : "浅色模式"
        showAlert(message: "已切换到\(style)")
    }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "提示", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "确定", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    private func clearCache() {
        let alert = UIAlertController(title: "提示", message: "确定要清除缓存吗？", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "取消", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "确定", style: .destructive, handler: { [weak self] _ in
            self?.cacheLabel.text = "0 MB"
            self?.showAlert(message: "缓存已清除")
        }))
        present(alert, animated: true, completion: nil)
    }
}

// MARK: - UITableView DataSource & Delegate
extension SettingsViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return settingsItems.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingsItems[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsCell", for: indexPath) as! SettingsCell
        let title = settingsItems[indexPath.section][indexPath.row]
        cell.configure(title: title)
        cell.accessibilityIdentifier = "settings_cell_\(indexPath.section)_\(indexPath.row)"
        
        // 为特定 cell 添加 accessory
        if title == "主题设置" {
            cell.accessoryView = themeSwitch
        } else if title == "清除缓存" {
            let label = cacheLabel
            cell.accessoryView = label
        } else if title == "关于我们" {
            cell.accessoryType = .disclosureIndicator
        } else if title == "隐私政策" || title == "用户协议" {
            cell.accessoryType = .disclosureIndicator
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let title = settingsItems[indexPath.section][indexPath.row]
        
        switch title {
        case "清除缓存":
            clearCache()
        case "关于我们":
            showAlert(message: "TestingGround v1.0.0\n一个 iOS UI 测试应用")
        case "隐私政策":
            showAlert(message: "这是隐私政策内容...")
        case "用户协议":
            showAlert(message: "这是用户协议内容...")
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "通用设置" : "关于"
    }
}

// MARK: - SettingsCell
class SettingsCell: UITableViewCell {
    
    private let titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 16)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
    }
    
    func configure(title: String) {
        titleLabel.text = title
    }
}
