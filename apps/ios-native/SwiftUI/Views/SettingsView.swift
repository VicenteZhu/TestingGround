import SwiftUI

struct SettingsView: View {
    @State private var darkMode = false
    @State private var notifications = true
    @State private var cacheSize = "23.5 MB"
    @State private var showClearCacheAlert = false
    @State private var showAbout = false
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("通用设置")) {
                    Toggle("深色模式", isOn: $darkMode)
                        .accessibilityIdentifier("settings_theme_switch")
                        .onChange(of: darkMode) { newValue in
                            // Handle theme change
                            print("Theme changed to: \(newValue ? "Dark" : "Light")")
                        }
                    
                    HStack {
                        Text("清除缓存")
                        Spacer()
                        Text(cacheSize)
                            .foregroundColor(.gray)
                            .accessibilityIdentifier("settings_cache_label")
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        showClearCacheAlert = true
                    }
                    .alert(isPresented: $showClearCacheAlert) {
                        Alert(
                            title: Text("提示"),
                            message: Text("确定要清除缓存吗？"),
                            primaryButton: .destructive(Text("确定")) {
                                cacheSize = "0 MB"
                            },
                            secondaryButton: .cancel(Text("取消"))
                        )
                    }
                    
                    HStack {
                        Text("版本")
                        Spacer()
                        Text("v1.0.0")
                            .foregroundColor(.gray)
                            .accessibilityIdentifier("settings_version_label")
                    }
                }
                
                Section(header: Text("关于")) {
                    Button(action: { showAbout = true }) {
                        HStack {
                            Text("关于我们")
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundColor(.gray)
                        }
                    }
                    .accessibilityIdentifier("settings_about_cell")
                    .sheet(isPresented: $showAbout) {
                        AboutView()
                    }
                    
                    Button(action: {
                        // Privacy policy
                    }) {
                        HStack {
                            Text("隐私政策")
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundColor(.gray)
                        }
                    }
                    .accessibilityIdentifier("settings_privacy_cell")
                    
                    Button(action: {
                        // User agreement
                    }) {
                        HStack {
                            Text("用户协议")
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundColor(.gray)
                        }
                    }
                    .accessibilityIdentifier("settings_agreement_cell")
                }
            }
            .navigationTitle("设置")
            .listStyle(InsetGroupedListStyle())
        }
    }
}

struct AboutView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Image(systemName: "info.circle.fill")
                    .resizable()
                    .frame(width: 80, height: 80)
                    .foregroundColor(.blue)
                
                Text("TestingGround")
                    .font(.title)
                    .fontWeight(.bold)
                
                Text("版本 1.0.0")
                    .foregroundColor(.gray)
                
                Text("一个 iOS UI 自动化测试应用")
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .padding()
                
                Spacer()
            }
            .padding()
            .navigationTitle("关于")
            .navigationBarItems(
                trailing: Button("关闭") {
                    presentationMode.wrappedValue.dismiss()
                }
            )
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
