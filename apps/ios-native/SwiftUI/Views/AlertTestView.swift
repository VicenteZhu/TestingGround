import SwiftUI

struct AlertTestView: View {
    @State private var showSimpleAlert = false
    @State private var showConfirmAlert = false
    @State private var showInputAlert = false
    @State private var showActionSheet = false
    @State private var inputText = ""
    @State private var resultMessage = "点击按钮测试弹窗"
    
    var body: some View {
        NavigationView {
            VStack(spacing: 16) {
                Button(action: { showSimpleAlert = true }) {
                    Text("简单弹窗")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .accessibilityIdentifier("alert_simple_button")
                .alert(isPresented: $showSimpleAlert) {
                    Alert(
                        title: Text("提示"),
                        message: Text("这是一个简单的弹窗"),
                        dismissButton: .default(Text("确定")) {
                            resultMessage = "点击了简单弹窗的确定按钮"
                        }
                    )
                }
                
                Button(action: { showConfirmAlert = true }) {
                    Text("确认弹窗")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.orange)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .accessibilityIdentifier("alert_confirm_button")
                .alert(isPresented: $showConfirmAlert) {
                    Alert(
                        title: Text("确认"),
                        message: Text("您确定要执行此操作吗？"),
                        primaryButton: .destructive(Text("确定")) {
                            resultMessage = "点击了确定按钮（destructive）"
                        },
                        secondaryButton: .cancel(Text("取消")) {
                            resultMessage = "点击了取消按钮"
                        }
                    )
                }
                
                Button(action: { showInputAlert = true }) {
                    Text("输入弹窗")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .accessibilityIdentifier("alert_input_button")
                .alert("输入", isPresented: $showInputAlert, actions: {
                    TextField("请输入姓名", text: $inputText)
                        .accessibilityIdentifier("alert_input_textfield")
                    Button("取消", role: .cancel) { }
                    Button("确定") {
                        resultMessage = "输入的内容: \(inputText)"
                        inputText = ""
                    }
                }, message: {
                    Text("请输入您的信息")
                })
                
                Button(action: { showActionSheet = true }) {
                    Text("操作表")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.purple)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .accessibilityIdentifier("alert_actionsheet_button")
                .actionSheet(isPresented: $showActionSheet) {
                    ActionSheet(
                        title: Text("操作表"),
                        message: Text("请选择一个操作"),
                        buttons: [
                            .default(Text("拍照")) {
                                resultMessage = "选择了拍照"
                            },
                            .default(Text("从相册选择")) {
                                resultMessage = "选择了从相册选择"
                            },
                            .cancel(Text("取消")) {
                                resultMessage = "取消了操作表"
                            }
                        ]
                    )
                }
                
                Button(action: showCustomAlert) {
                    Text("自定义弹窗")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.pink)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .accessibilityIdentifier("alert_custom_button")
                
                Spacer()
                
                Text(resultMessage)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .padding()
                    .accessibilityIdentifier("alert_result_label")
            }
            .padding()
            .navigationTitle("弹窗测试")
        }
    }
    
    private func showCustomAlert() {
        // In SwiftUI, we can use .alert or .sheet for custom alerts
        // For this example, we'll use a simple alert
        resultMessage = "自定义弹窗功能（可以使用 .sheet 实现更复杂的效果）"
    }
}

struct AlertTestView_Previews: PreviewProvider {
    static var previews: some View {
        AlertTestView()
    }
}
