import SwiftUI

struct ListItem: Identifiable {
    let id = UUID()
    let title: String
    let subtitle: String
    let icon: String
}

struct ListTestView: View {
    @State private var items: [ListItem] = []
    @State private var searchText = ""
    @State private var showEmpty = false
    
    var filteredItems: [ListItem] {
        if searchText.isEmpty {
            return items
        } else {
            return items.filter { $0.title.contains(searchText) || $0.subtitle.contains(searchText) }
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                // Search Bar
                SearchBar(text: $searchText)
                    .accessibilityIdentifier("list_search_bar")
                
                // List
                List {
                    ForEach(filteredItems) { item in
                        ListItemRow(item: item)
                            .accessibilityIdentifier("list_item_\(item.title)")
                            .onTapGesture {
                                // Show detail
                                print("Tapped: \(item.title)")
                            }
                    }
                    .onDelete(perform: deleteItems)
                }
                .accessibilityIdentifier("list_table_view")
                
                if filteredItems.isEmpty && !items.isEmpty {
                    Text("无搜索结果")
                        .foregroundColor(.gray)
                }
                
                if items.isEmpty {
                    Text("暂无数据")
                        .foregroundColor(.gray)
                        .accessibilityIdentifier("list_empty_label")
                }
            }
            .navigationTitle("列表测试")
            .navigationBarItems(
                trailing: HStack {
                    Button(action: addItem) {
                        Image(systemName: "plus.circle.fill")
                            .accessibilityIdentifier("list_add_button")
                    }
                    Button(action: deleteLastItem) {
                        Image(systemName: "trash.circle.fill")
                            .accessibilityIdentifier("list_delete_button")
                    }
                }
            )
            .onAppear(perform: loadData)
        }
    }
    
    private func loadData() {
        // Generate test data
        if items.isEmpty {
            for i in 1...20 {
                let icons = ["star", "heart", "bell", "flag", "tag"]
                let item = ListItem(
                    title: "项目 \(i)",
                    subtitle: "这是项目 \(i) 的描述信息",
                    icon: icons[i % icons.count]
                )
                items.append(item)
            }
        }
    }
    
    private func addItem() {
        let icons = ["star", "heart", "bell", "flag", "tag"]
        let newId = items.count + 1
        let item = ListItem(
            title: "新项目 \(newId)",
            subtitle: "新增的项目描述",
            icon: icons[newId % icons.count]
        )
        items.append(item)
    }
    
    private func deleteItems(at offsets: IndexSet) {
        items.remove(atOffsets: offsets)
    }
    
    private func deleteLastItem() {
        if !items.isEmpty {
            items.removeLast()
        }
    }
}

struct ListItemRow: View {
    let item: ListItem
    
    var body: some View {
        HStack {
            Image(systemName: item.icon)
                .resizable()
                .frame(width: 30, height: 30)
                .foregroundColor(.blue)
            
            VStack(alignment: .leading) {
                Text(item.title)
                    .font(.headline)
                Text(item.subtitle)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
        }
    }
}

// Search Bar Component
struct SearchBar: UIViewRepresentable {
    @Binding var text: String
    
    class Coordinator: NSObject, UISearchBarDelegate {
        @Binding var text: String
        
        init(text: Binding<String>) {
            _text = text
        }
        
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            text = searchText
        }
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(text: $text)
    }
    
    func makeUIView(context: Context) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.delegate = context.coordinator
        searchBar.placeholder = "搜索..."
        searchBar.accessibilityIdentifier = "list_search_bar"
        return searchBar
    }
    
    func updateUIView(_ uiView: UISearchBar, context: Context) {
        uiView.text = text
    }
}

struct ListTestView_Previews: PreviewProvider {
    static var previews: some View {
        ListTestView()
    }
}
