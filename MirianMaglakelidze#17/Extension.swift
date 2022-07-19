import Foundation
import UIKit

extension UIView {
    func setTriangle(color: UIColor){
        let heightWidth = self.frame.size.width
        let path = CGMutablePath()
        
        path.move(to: CGPoint(x: 0, y: heightWidth))
        path.addLine(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: heightWidth, y: heightWidth / 2))

        let shape = CAShapeLayer()
        shape.path = path
        shape.fillColor = color.cgColor
        
        self.layer.insertSublayer(shape, at: 0)
    }
}
