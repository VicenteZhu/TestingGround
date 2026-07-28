import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            LoginView()
                .tabItem {
                    Label("登录", systemImage: "person.circle")
                }
            
            FormTestView()
                .tabItem {
                    Label("表单", systemImage: "list.bullet")
                }
            
            ListTestView()
                .tabItem {
                    Label("列表", systemImage: "list.number")
                }
            
            AlertTestView()
                .tabItem {
                    Label("弹窗", systemImage: "exclamationmark.bubble")
                }
            
            SettingsView()
                .tabItem {
                    Label("设置", systemImage: "gear")
                }
        }
    }
}
