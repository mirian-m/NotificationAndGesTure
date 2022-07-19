import UIKit

class ImageViewVc: UIViewController {
    @IBOutlet weak var image: UIImageView! {
        didSet {
            image.isUserInteractionEnabled = true
            image.layer.cornerRadius = 10
            image.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    public var transporterViewIdentifaier: Int!
    
    private lazy var color = UIColor(red: CGFloat(Double.random(in: 0..<1)), green: CGFloat(Double.random(in: 0..<1)), blue: CGFloat(Double.random(in: 0..<1)), alpha: 1)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        chooseGesture()
    }
    
    // MARK:- Create LongPressGesture gesture
    private func creatLongPressGesture() -> UILongPressGestureRecognizer {
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(doSomthing))
        longPressGesture.minimumPressDuration = Double.random(in: 0...2)
        return longPressGesture
    }
    
    @objc func doSomthing(longPressGesture: UILongPressGestureRecognizer) {
        print(longPressGesture.minimumPressDuration)
        if longPressGesture.minimumPressDuration < 1 && transporterViewIdentifaier == 1 {
            navigationController?.popViewController(animated: true)
        } else if longPressGesture.minimumPressDuration > 1 && transporterViewIdentifaier == 2 {
            UIView.animate(withDuration: 4) { self.image.alpha = 0 }
        }
    }
    
    // MARK:- Create Swipe gesture
    private func createSwipeGesture() -> [UISwipeGestureRecognizer] {
        let rightSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(changeImageWidth))
        rightSwipeGesture.direction = .right
        
        let leftSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(changeImageWidth))
        leftSwipeGesture.direction = .left
        
        let upSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(changeImageWidth))
        upSwipeGesture.direction = .up
        
        let downSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(changeImageWidth))
        downSwipeGesture.direction = .down
        
        return [rightSwipeGesture, leftSwipeGesture, upSwipeGesture, downSwipeGesture]
    }
    
    @objc func changeImageWidth(swipeGesture: UISwipeGestureRecognizer) {
        // Check direction of swipeGesture
        switch swipeGesture.direction {
        case .down, .left  :
            self.image.frame.size.width -= 50
        case .right, .up :
            self.image.frame.size.width += 50
        default:
            break
        }
    }
    
    // MARK:- Creation of pinch gesture
    private func creatPinchGesture() -> UIPinchGestureRecognizer {
        UIPinchGestureRecognizer(target: self, action: #selector(scaleImage))
    }
    
    @objc func scaleImage(pinchGesture: UIPinchGestureRecognizer) {
        pinchGesture.view?.transform = (pinchGesture.view?.transform.scaledBy(x: pinchGesture.scale, y: pinchGesture.scale))!
        pinchGesture.scale = 1
        if isImageViewBoundsOutOfTheView(pinchGesture.view as? UIImageView ?? UIImageView()) {
            self.image.transform = CGAffineTransform.identity
            createNotification()
        }
        
    }
    
    private func isImageViewBoundsOutOfTheView(_ imageView: UIImageView) -> Bool {
        imageView.frame.size.width  > self.view.frame.size.width ||
            imageView.frame.size.height > self.view.frame.size.height
    }
    
    private func createNotification() {
        NotificationCenter.default.post(name: Notification.Name("Mirian-maglakelidze.MirianMaglakelidze-17.changeBackground"), object: color, userInfo: nil)
    }
    // ADD ImageView Gesture
    private func chooseGesture() {
        switch transporterViewIdentifaier {
        case 1, 2 :
            image.addGestureRecognizer(creatLongPressGesture())
        case 3    :
            createSwipeGesture().forEach { image.addGestureRecognizer($0) }
        case 4    :
            image.addGestureRecognizer(creatPinchGesture())
        default   :
            break
        }
    }
}
