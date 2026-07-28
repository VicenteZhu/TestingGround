import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewControllers()
    }
    
    private func setupViewControllers() {
        let loginVC = createNavController(
            rootViewController: LoginViewController(),
            title: "登录",
            imageName: "person.circle"
        )
        
        let formVC = createNavController(
            rootViewController: FormTestViewController(),
            title: "表单",
            imageName: "list.bullet"
        )
        
        let listVC = createNavController(
            rootViewController: ListTestViewController(),
            title: "列表",
            imageName: "list.number"
        )
        
        let alertVC = createNavController(
            rootViewController: AlertTestViewController(),
            title: "弹窗",
            imageName: "exclamationmark.bubble"
        )
        
        let settingVC = createNavController(
            rootViewController: SettingsViewController(),
            title: "设置",
            imageName: "gear"
        )
        
        viewControllers = [loginVC, formVC, listVC, alertVC, settingVC]
    }
    
    private func createNavController(rootViewController: UIViewController, title: String, imageName: String) -> UINavigationController {
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem = UITabBarItem(title: title, image: UIImage(systemName: imageName), tag: 0)
        return navController
    }
}
