import XCTest

class TestingGroundUITests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
    
    override func tearDown() {
        app = nil
        super.tearDown()
    }
    
    // MARK: - 登录页面测试
    func testLoginPageElements() {
        // 验证登录页面元素存在
        XCTAssertTrue(app.images["login_logo_image"].exists)
        XCTAssertTrue(app.textFields["login_username_textfield"].exists)
        XCTAssertTrue(app.secureTextFields["login_password_textfield"].exists)
        XCTAssertTrue(app.buttons["login_submit_button"].exists)
        XCTAssertTrue(app.switches["login_remember_switch"].exists)
        XCTAssertTrue(app.staticTexts["login_status_label"].exists)
    }
    
    func testLoginSuccess() {
        // 输入正确的用户名和密码
        let usernameField = app.textFields["login_username_textfield"]
        usernameField.tap()
        usernameField.typeText("admin")
        
        let passwordField = app.secureTextFields["login_password_textfield"]
        passwordField.tap()
        passwordField.typeText("123456")
        
        // 点击登录按钮
        app.buttons["login_submit_button"].tap()
        
        // 等待登录结果
        let statusLabel = app.staticTexts["login_status_label"]
        let predicate = NSPredicate(format: "label == '登录成功！'")
        expectation(for: predicate, evaluatedWith: statusLabel, handler: nil)
        waitForExpectations(timeout: 3, handler: nil)
    }
    
    func testLoginFailure() {
        // 输入错误的用户名和密码
        let usernameField = app.textFields["login_username_textfield"]
        usernameField.tap()
        usernameField.typeText("wrong")
        
        let passwordField = app.secureTextFields["login_password_textfield"]
        passwordField.tap()
        passwordField.typeText("wrong")
        
        // 点击登录按钮
        app.buttons["login_submit_button"].tap()
        
        // 验证错误提示
        let statusLabel = app.staticTexts["login_status_label"]
        XCTAssertTrue(statusLabel.label.contains("错误") || statusLabel.label.contains("不能为空"))
    }
    
    // MARK: - 表单页面测试
    func testFormPageElements() {
        // 切换到表单页面
        app.tabBars.buttons["表单"].tap()
        
        // 验证表单元素存在
        XCTAssertTrue(app.textFields["form_name_textfield"].exists)
        XCTAssertTrue(app.textFields["form_email_textfield"].exists)
        XCTAssertTrue(app.textFields["form_phone_textfield"].exists)
        XCTAssertTrue(app.segmentedControls["form_gender_segment"].exists)
        XCTAssertTrue(app.sliders["form_age_slider"].exists)
        XCTAssertTrue(app.switches["form_notification_switch"].exists)
        XCTAssertTrue(app.datePickers["form_date_picker"].exists)
        XCTAssertTrue(app.buttons["form_submit_button"].exists)
    }
    
    func testFormSubmission() {
        // 切换到表单页面
        app.tabBars.buttons["表单"].tap()
        
        // 填写表单
        let nameField = app.textFields["form_name_textfield"]
        nameField.tap()
        nameField.typeText("张三")
        
        let emailField = app.textFields["form_email_textfield"]
        emailField.tap()
        emailField.typeText("zhangsan@example.com")
        
        // 提交表单
        app.buttons["form_submit_button"].tap()
        
        // 验证结果
        let resultLabel = app.staticTexts["form_result_label"]
        XCTAssertTrue(resultLabel.label.contains("提交成功"))
    }
    
    func testAgeSlider() {
        // 切换到表单页面
        app.tabBars.buttons["表单"].tap()
        
        // 调整滑块
        let slider = app.sliders["form_age_slider"]
        slider.adjust(toNormalizedSliderPosition: 0.5) // 50岁
        
        // 验证年龄标签
        let ageLabel = app.staticTexts["form_age_label"]
        XCTAssertTrue(ageLabel.label.contains("50") || ageLabel.label.contains("49") || ageLabel.label.contains("51"))
    }
    
    // MARK: - 列表页面测试
    func testListPageElements() {
        // 切换到列表页面
        app.tabBars.buttons["列表"].tap()
        
        // 验证列表元素存在
        XCTAssertTrue(app.searchFields["list_search_bar"].exists)
        XCTAssertTrue(app.tables["list_table_view"].exists)
        XCTAssertTrue(app.buttons["list_add_button"].exists)
        XCTAssertTrue(app.buttons["list_delete_button"].exists)
    }
    
    func testListAddItem() {
        // 切换到列表页面
        app.tabBars.buttons["列表"].tap()
        
        // 记录初始行数
        let table = app.tables["list_table_view"]
        let initialCount = table.cells.count
        
        // 点击添加按钮
        app.buttons["list_add_button"].tap()
        
        // 验证行数增加
        XCTAssertEqual(table.cells.count, initialCount + 1)
    }
    
    func testListDeleteItem() {
        // 切换到列表页面
        app.tabBars.buttons["列表"].tap()
        
        // 记录初始行数
        let table = app.tables["list_table_view"]
        let initialCount = table.cells.count
        
        guard initialCount > 0 else { return }
        
        // 点击删除按钮
        app.buttons["list_delete_button"].tap()
        
        // 验证行数减少
        XCTAssertEqual(table.cells.count, initialCount - 1)
    }
    
    func testListCellTap() {
        // 切换到列表页面
        app.tabBars.buttons["列表"].tap()
        
        // 点击第一个 cell
        let table = app.tables["list_table_view"]
        if table.cells.count > 0 {
            table.cells.element(boundBy: 0).tap()
            
            // 验证弹窗出现
            XCTAssertTrue(app.alerts["详情"].exists || app.alerts["详情"].waitForExistence(timeout: 2))
            
            // 关闭弹窗
            app.alerts["详情"].buttons["确定"].tap()
        }
    }
    
    // MARK: - 弹窗页面测试
    func testAlertPageElements() {
        // 切换到弹窗页面
        app.tabBars.buttons["弹窗"].tap()
        
        // 验证弹窗测试按钮存在
        XCTAssertTrue(app.buttons["alert_simple_button"].exists)
        XCTAssertTrue(app.buttons["alert_confirm_button"].exists)
        XCTAssertTrue(app.buttons["alert_input_button"].exists)
        XCTAssertTrue(app.buttons["alert_actionsheet_button"].exists)
        XCTAssertTrue(app.buttons["alert_custom_button"].exists)
    }
    
    func testSimpleAlert() {
        // 切换到弹窗页面
        app.tabBars.buttons["弹窗"].tap()
        
        // 点击简单弹窗按钮
        app.buttons["alert_simple_button"].tap()
        
        // 验证弹窗出现
        XCTAssertTrue(app.alerts["提示"].exists || app.alerts["提示"].waitForExistence(timeout: 2))
        
        // 关闭弹窗
        app.alerts["提示"].buttons["确定"].tap()
    }
    
    func testConfirmAlert() {
        // 切换到弹窗页面
        app.tabBars.buttons["弹窗"].tap()
        
        // 点击确认弹窗按钮
        app.buttons["alert_confirm_button"].tap()
        
        // 验证弹窗出现
        let alert = app.alerts["确认"]
        XCTAssertTrue(alert.exists || alert.waitForExistence(timeout: 2))
        
        // 点击取消按钮
        alert.buttons["取消"].tap()
        
        // 验证结果标签
        let resultLabel = app.staticTexts["alert_result_label"]
        XCTAssertTrue(resultLabel.label.contains("取消"))
    }
    
    func testInputAlert() {
        // 切换到弹窗页面
        app.tabBars.buttons["弹窗"].tap()
        
        // 点击输入弹窗按钮
        app.buttons["alert_input_button"].tap()
        
        // 验证弹窗出现
        let alert = app.alerts["输入"]
        XCTAssertTrue(alert.exists || alert.waitForExistence(timeout: 2))
        
        // 输入文本
        let textField = alert.textFields["alert_input_textfield"]
        textField.tap()
        textField.typeText("测试用户")
        
        // 点击确定
        alert.buttons["确定"].tap()
        
        // 验证结果
        let resultLabel = app.staticTexts["alert_result_label"]
        XCTAssertTrue(resultLabel.label.contains("测试用户"))
    }
    
    // MARK: - 设置页面测试
    func testSettingsPageElements() {
        // 切换到设置页面
        app.tabBars.buttons["设置"].tap()
        
        // 验证设置页面元素存在
        XCTAssertTrue(app.tables["settings_table_view"].exists)
    }
    
    func testSettingsThemeSwitch() {
        // 切换到设置页面
        app.tabBars.buttons["设置"].tap()
        
        // 找到主题开关并切换
        let themeSwitch = app.switches["settings_theme_switch"]
        let initialState = themeSwitch.value as! String
        
        themeSwitch.tap()
        
        let newState = themeSwitch.value as! String
        XCTAssertNotEqual(initialState, newState)
    }
    
    func testSettingsClearCache() {
        // 切换到设置页面
        app.tabBars.buttons["设置"].tap()
        
        // 点击清除缓存 cell
        let clearCacheCell = app.cells["settings_cell_0_1"]
        clearCacheCell.tap()
        
        // 验证确认弹窗出现
        let alert = app.alerts["提示"]
        XCTAssertTrue(alert.exists || alert.waitForExistence(timeout: 2))
        
        // 点击确定
        alert.buttons["确定"].tap()
        
        // 等待弹窗关闭
        sleep(1)
    }
    
    // MARK: - 综合流程测试
    func testFullUserFlow() {
        // 1. 登录
        let usernameField = app.textFields["login_username_textfield"]
        usernameField.tap()
        usernameField.typeText("admin")
        
        let passwordField = app.secureTextFields["login_password_textfield"]
        passwordField.tap()
        passwordField.typeText("123456")
        
        app.buttons["login_submit_button"].tap()
        
        // 等待登录完成
        sleep(2)
        
        // 2. 切换到表单页面并填写
        app.tabBars.buttons["表单"].tap()
        
        let nameField = app.textFields["form_name_textfield"]
        nameField.tap()
        nameField.typeText("测试用户")
        
        app.buttons["form_submit_button"].tap()
        
        // 3. 切换到列表页面并添加项目
        app.tabBars.buttons["列表"].tap()
        app.buttons["list_add_button"].tap()
        
        // 4. 切换到设置页面并切换主题
        app.tabBars.buttons["设置"].tap()
        app.switches["settings_theme_switch"].tap()
        
        // 验证流程完成（无崩溃）
        XCTAssertTrue(true)
    }
}
