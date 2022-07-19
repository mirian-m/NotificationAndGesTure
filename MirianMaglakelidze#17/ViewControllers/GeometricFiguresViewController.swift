import UIKit

class GeometricFiguresViewController: UIViewController {
    
    @IBOutlet weak var blueCyrcle: UIView! {
        didSet {
            blueCyrcle.layer.cornerRadius = blueCyrcle.frame.size.height / 2
            blueCyrcle.backgroundColor = UIColor.blue
        }
    }
    @IBOutlet weak var redCyrcle: UIView! {
        didSet {
            redCyrcle.layer.cornerRadius = redCyrcle.frame.size.height / 2
            redCyrcle.backgroundColor = UIColor.red
        }
    }
    
    @IBOutlet weak var purpelTriangle: UIView! {
        didSet {
            purpelTriangle.backgroundColor = .none
            purpelTriangle.setTriangle(color: UIColor.purple)
        }
    }
    @IBOutlet weak var blackTriangle: UIView! {
        didSet {
            blackTriangle.backgroundColor = .none
            blackTriangle.setTriangle(color: UIColor.black)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        addGestures()
        NotificationCenter.default.addObserver(self, selector: #selector(chanegeBackgorundColor), name: Notification.Name("Mirian-maglakelidze.MirianMaglakelidze-17.changeBackground"), object: nil)
    }

    func addGestures() {
        redCyrcle.addGestureRecognizer(createTapGesture())
        blueCyrcle.addGestureRecognizer(createTapGesture())
        blackTriangle.addGestureRecognizer(createTapGesture())
        purpelTriangle.addGestureRecognizer(createTapGesture())
    }

    // Notification func
    @objc func chanegeBackgorundColor(notification: Notification) {
        if let color = notification.object as? UIColor {
            self.view.backgroundColor = color
        }
        
    }

    // Creation of Tap gesture
    func createTapGesture() -> UITapGestureRecognizer {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(navigateNextPage))
        return tapGesture
    }
    
    // Tap gesture func
    @objc func navigateNextPage(tapGesture: UITapGestureRecognizer) {
        guard let cv = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ImageViewVc") as? ImageViewVc else { return }
        cv.transporterViewIdentifaier = tapGesture.view?.tag
        self.navigationController?.pushViewController(cv, animated: true)
    }
}

