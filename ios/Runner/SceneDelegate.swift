import Flutter
import UIKit

class SceneDelegate: FlutterSceneDelegate {
  // نفس لون ColorManager.background (#F8FAFC) كي لا تظهر نافذة iOS بيضاء خلف Flutter.
  private let appBackground = UIColor(
    red: 248.0 / 255.0, green: 250.0 / 255.0, blue: 252.0 / 255.0, alpha: 1.0)

  override func scene(
    _ scene: UIScene,
    willConnectTo session: UISceneSession,
    options connectionOptions: UIScene.ConnectionOptions
  ) {
    super.scene(scene, willConnectTo: session, options: connectionOptions)
    window?.backgroundColor = appBackground
    window?.rootViewController?.view.backgroundColor = appBackground
  }
}
