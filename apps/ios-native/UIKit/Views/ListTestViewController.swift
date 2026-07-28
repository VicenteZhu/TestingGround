import UIKit

struct ListItem {
    let id: Int
    let title: String
    let subtitle: String
    let icon: String
}

class ListTestViewController: UIViewController {
    
    // MARK: - Data
    private var items: [ListItem] = []
    
    // MARK: - UI Components (带测试ID)
    private let searchBar: UISearchBar = {
        let sb = UISearchBar()
        sb.placeholder = "搜索..."
        sb.translatesAutoresizingMaskIntoConstraints = false
        sb.accessibilityIdentifier = "list_search_bar"
        return sb
    }()
    
    private let tableView: UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.accessibilityIdentifier = "list_table_view"
        return tv
    }()
    
    private let emptyLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "暂无数据"
        lbl.font = UIFont.systemFont(ofSize: 16)
        lbl.textColor = .gray
        lbl.textAlignment = .center
        lbl.isHidden = true
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.accessibilityIdentifier = "list_empty_label"
        return lbl
    }()
    
    private let addButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(systemName: "plus.circle.fill"), for: .normal)
        btn.tintColor = .systemBlue
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.accessibilityIdentifier = "list_add_button"
        return btn
    }()
    
    private let deleteButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(systemName: "trash.circle.fill"), for: .normal)
        btn.tintColor = .systemRed
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.accessibilityIdentifier = "list_delete_button"
        return btn
    }()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupData()
        setupActions()
    }
    
    // MARK: - Setup
    private func setupUI() {
        view.backgroundColor = .white
        title = "列表测试"
        
        view.addSubview(searchBar)
        view.addSubview(tableView)
        view.addSubview(emptyLabel)
        view.addSubview(addButton)
        view.addSubview(deleteButton)
        
        tableView.register(ListItemCell.self, forCellReuseIdentifier: "ListItemCell")
        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate = self
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            emptyLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emptyLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            addButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            addButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            addButton.widthAnchor.constraint(equalToConstant: 50),
            addButton.heightAnchor.constraint(equalToConstant: 50),
            
            deleteButton.bottomAnchor.constraint(equalTo: addButton.topAnchor, constant: -20),
            deleteButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            deleteButton.widthAnchor.constraint(equalToConstant: 50),
            deleteButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func setupData() {
        // 生成测试数据
        for i in 1...20 {
            let item = ListItem(
                id: i,
                title: "项目 \(i)",
                subtitle: "这是项目 \(i) 的描述信息",
                icon: ["star", "heart", "bell", "flag", "tag"][i % 5]
            )
            items.append(item)
        }
        tableView.reloadData()
        updateEmptyState()
    }
    
    private func setupActions() {
        addButton.addTarget(self, action: #selector(addItem), for: .touchUpInside)
        deleteButton.addTarget(self, action: #selector(deleteItem), for: .touchUpInside)
    }
    
    private func updateEmptyState() {
        emptyLabel.isHidden = !items.isEmpty
        tableView.isHidden = items.isEmpty
    }
    
    // MARK: - Actions
    @objc private func addItem() {
        let newId = (items.last?.id ?? 0) + 1
        let item = ListItem(
            id: newId,
            title: "新项目 \(newId)",
            subtitle: "新增的项目描述",
            icon: ["star", "heart", "bell", "flag", "tag"][newId % 5]
        )
        items.append(item)
        tableView.insertRows(at: [IndexPath(row: items.count - 1, section: 0)], with: .automatic)
        updateEmptyState()
    }
    
    @objc private func deleteItem() {
        guard !items.isEmpty else { return }
        items.removeLast()
        tableView.deleteRows(at: [IndexPath(row: items.count, section: 0)], with: .automatic)
        updateEmptyState()
    }
}

// MARK: - UITableView DataSource & Delegate
extension ListTestViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListItemCell", for: indexPath) as! ListItemCell
        cell.configure(with: items[indexPath.row])
        cell.accessibilityIdentifier = "list_item_cell_\(indexPath.row)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = items[indexPath.row]
        
        let alert = UIAlertController(title: "详情", message: "\(item.title)\n\(item.subtitle)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "确定", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

// MARK: - UISearchBar Delegate
extension ListTestViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // 实际项目中应该在这里做搜索过滤
        print("搜索: \(searchText)")
    }
}

// MARK: - ListItemCell
class ListItemCell: UITableViewCell {
    
    private let iconImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    private let titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.boldSystemFont(ofSize: 16)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private let subtitleLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 14)
        lbl.textColor = .gray
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
        contentView.addSubview(iconImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(subtitleLabel)
        
        NSLayoutConstraint.activate([
            iconImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            iconImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 30),
            iconImageView.heightAnchor.constraint(equalToConstant: 30),
            
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            titleLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            subtitleLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            subtitleLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            subtitleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12)
        ])
    }
    
    func configure(with item: ListItem) {
        iconImageView.image = UIImage(systemName: item.icon)
        iconImageView.tintColor = .systemBlue
        titleLabel.text = item.title
        subtitleLabel.text = item.subtitle
    }
}
