import UIKit
import Turbolinks

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var navigationController = UINavigationController()
    var session = Session()
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        window?.rootViewController = navigationController
        startApplication()
        return true
    }
    
    func startApplication() {
        session.delegate = self
        visit(NSURL(string: "https://acadmi-staging-pr-109.herokuapp.com/")!)
    }
    
    func visit(URL: NSURL) {
        let visitableViewController = VisitableViewController(URL: URL)
        navigationController.pushViewController(visitableViewController, animated: true)
        session.visit(visitableViewController)
    }
}

extension AppDelegate: SessionDelegate {
    func session(session: Session, didProposeVisitToURL URL: NSURL, withAction action: Action) {
        visit(URL)
    }
    
    func session(session: Session, didFailRequestForVisitable visitable: Visitable, withError error: NSError) {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
        navigationController.presentViewController(alert, animated: true, completion: nil)
    }
}