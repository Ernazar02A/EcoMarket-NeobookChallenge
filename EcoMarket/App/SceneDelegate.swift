//
//  SceneDelegate.swift
//  EcoMarket
//
//  Created by Ernazar on 14/12/23.
//

import UIKit

class TriangleButton: UIButton {
    
//    var path: UIBezierPath!
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        //self.backgroundColor = .white
//        //simpleShapeLayer()]
//        maskVsSublayer()
//    }
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//
//
//    }
    
//    func maskVsSublayer() {
//
//        self.createTriangles()
//
//        let shapeLayer = CAShapeLayer()
//        shapeLayer.path = path.cgPath
//        shapeLayer.fillColor = UIColor.yellow.cgColor
//
//        self.layer.addSublayer(shapeLayer)
//    }
//
//    func createTriangles() {
//        let width = self.frame.size.width
//        let height = self.frame.size.height
//        path = UIBezierPath()
//
//        path.move(to: CGPoint(x: 5, y: height / 2))
//        path.addLine(to: CGPoint(x: width, y: 0))
//        path.addLine(to: CGPoint(x: width, y: height))
//
//        path.close()
//
//    }
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let cornerRadius: CGFloat = 10.0

        guard let context = UIGraphicsGetCurrentContext() else { return }

        let width = rect.width
        let height = rect.height

        let path = UIBezierPath()
        path.move(to: CGPoint(x: 5, y: height / 2))
        path.addLine(to: CGPoint(x: width, y: 0))
        path.addLine(to: CGPoint(x: width, y: height))
        path.close()
    }
}

class LogoViewController: UIViewController {
    
    let logoImageView: UIImageView = {
        let view = UIImageView(image: UIImage(named: "logo"))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let captionLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.text = "Eventic"
        view.textAlignment = .center
        view.textColor = #colorLiteral(red: 0.6941176471, green: 0.2901960784, blue: 0.9294117647, alpha: 1)
        view.font = UIFont.systemFont(ofSize: 50, weight: .regular)
        view.alpha = 0 // Изначально скрыть надпись
        return view
    }()
    
    let triangleButton: TriangleButton = {
        let view = TriangleButton(frame: CGRect(x: 100, y: 100, width: 76, height: 159))
        view.setTitle("Press me", for: .normal)
        view.setTitleColor(.black, for: .normal)
        //view.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return view
    }()
    
    var logoWidthConstraint: NSLayoutConstraint!
    var logoHeightConstraint: NSLayoutConstraint!
    var logoCenterYConstraint: NSLayoutConstraint!
    var captionLabelTopConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Добавьте логотип на ваш экран
        view.addSubview(logoImageView)
        view.addSubview(captionLabel)
        view.addSubview(triangleButton)
        
        // Установите начальные ограничения
        logoWidthConstraint = logoImageView.widthAnchor.constraint(equalToConstant: 27)
        logoHeightConstraint = logoImageView.heightAnchor.constraint(equalToConstant: 36)
        logoCenterYConstraint = logoImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        captionLabelTopConstraint = captionLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: -30)
        
        NSLayoutConstraint.activate([
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoCenterYConstraint,
            logoWidthConstraint,
            logoHeightConstraint,
            
            captionLabelTopConstraint,
            captionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animateLogo()
    }
    
    func animateLogo() {
        // Используйте UIViewPropertyAnimator для анимации
        let animator = UIViewPropertyAnimator(duration: 1.0, curve: .easeInOut) {
            // Появление надписи после окончания анимации логотипа
            self.captionLabel.alpha = 1
            // Изменение ограничений для перемещения надписи вниз
            self.captionLabelTopConstraint.constant = 15
            // Пересчитайте ограничения для применения изменений
            self.view.layoutIfNeeded()
        }
        
        // Используйте UIView.animate для изменения размера логотипа
        UIView.animate(withDuration: 1.0, delay: 0.5, options: .curveEaseInOut, animations: {
            self.logoWidthConstraint.constant = 73
            self.logoHeightConstraint.constant = 97
            self.logoCenterYConstraint.constant = -20
            // Пересчитайте ограничения для применения изменений
            
            self.captionLabelTopConstraint.isActive = true
            
            self.view.layoutIfNeeded()
        }) { _ in
            // Завершение анимации логотипа
        }
        
        // Запустите анимацию логотипа
        animator.startAnimation(afterDelay: 2)
    }
}

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        let tabBarContoller = TabBarBuilder().buildTabBarController()
        window?.rootViewController = tabBarContoller
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.

        // Save changes in the application's managed object context when the application transitions to the background.
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }


}

