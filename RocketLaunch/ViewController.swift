//
//  ViewController.swift
//  RocketLaunch
//
//  Created by Anastasia on 24.04.2022.
//

import UIKit


class RocketViewController: UIViewController {
    
    let shapeLayer: CAShapeLayer = {
        let shapeLayer = CAShapeLayer()
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = UIColor.black.cgColor
        return shapeLayer
    }()
    
    let circle: CAShapeLayer = {
        let circle = CAShapeLayer()
        circle.fillColor = UIColor.clear.cgColor
        circle.strokeColor = UIColor.clear.cgColor
        return circle
    }()

    let button: UIButton = {
        let button = UIButton()
        button.setTitle("Launch", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 25)
        button.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(launchingRocket), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.layer.addSublayer(shapeLayer)
        view.layer.addSublayer(circle)
        view.addSubview(button)
        makeConstraints()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let rocketPath = UIBezierPath()
        let circlePath = UIBezierPath()
        
        let startedPoint = CGPoint(x: view.frame.minX + 200, y: view.frame.maxY - 300)
        let secondPoint = CGPoint(x: startedPoint.x - 30, y: startedPoint.y + 200)
        
        rocketPath.move(to: startedPoint)
        rocketPath.addCurve(
            to: CGPoint(x: startedPoint.x + 58, y: startedPoint.y + 120),
            controlPoint1: CGPoint(x: startedPoint.x + 30, y: startedPoint.y + 40),
            controlPoint2: CGPoint(x: startedPoint.x + 50, y: startedPoint.y + 70)
        )
        rocketPath.addLine(to: CGPoint(x: startedPoint.x + 80, y: startedPoint.y + 220))
        rocketPath.addLine(to: CGPoint(x: startedPoint.x + 41, y: startedPoint.y + 170))
        rocketPath.addLine(to: CGPoint(x: startedPoint.x - 41, y: startedPoint.y + 170))
        rocketPath.addLine(to: CGPoint(x: startedPoint.x - 80, y: startedPoint.y + 220))
        rocketPath.addLine(to: CGPoint(x: startedPoint.x - 58, y: startedPoint.y + 120))
        rocketPath.addCurve(
            to: startedPoint,
            controlPoint1: CGPoint(x: startedPoint.x - 50, y: startedPoint.y + 70),
            controlPoint2: CGPoint(x: startedPoint.x - 30, y: startedPoint.y + 40))
        rocketPath.move(to: secondPoint)
        rocketPath.addLine(to: CGPoint(x: secondPoint.x + 60, y: secondPoint.y))
        rocketPath.addCurve(
            to: CGPoint(x: secondPoint.x + 30, y: secondPoint.y + 60),
            controlPoint1: CGPoint(x: secondPoint.x + 60 , y: secondPoint.y + 20),
            controlPoint2: CGPoint(x: secondPoint.x + 40, y: secondPoint.y + 50))
        rocketPath.addCurve(
            to: secondPoint,
            controlPoint1: CGPoint(x: secondPoint.x + 20 , y: secondPoint.y + 50),
            controlPoint2: CGPoint(x: secondPoint.x, y: secondPoint.y + 20))
        
        circlePath.move(to: CGPoint(x: startedPoint.x, y: startedPoint.y + 100))
        circlePath.addArc(withCenter: CGPoint(x: startedPoint.x, y: startedPoint.y + 100), radius: 25, startAngle: 0.0, endAngle: .pi * 2.0, clockwise: true)
        
        shapeLayer.fillColor = UIColor.black.cgColor
        circle.fillColor = UIColor.white.cgColor
        
        shapeLayer.path = rocketPath.cgPath
        circle.path = circlePath.cgPath
    }
}


extension RocketViewController {
    func makeConstraints() {
        button.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        button.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20)
        ])
    }
}


extension RocketViewController {
    func addShakingAnimation(to layer: CAShapeLayer) {
        let animation = CABasicAnimation(keyPath: "position.x")
        animation.fromValue = CGPoint.zero
        animation.toValue = CGPoint(x: 5, y: 0)
        animation.duration = 0.1
        animation.beginTime = CACurrentMediaTime() + 0.3
        animation.repeatCount = 6
        layer.add(animation, forKey: nil)
    }

    func addFlyingAnimation(to layer: CAShapeLayer) {
        let animation = CABasicAnimation(keyPath: "transform.scale")
        animation.fromValue = 1
        animation.toValue = view.frame
        animation.duration = 3
        animation.beginTime = CACurrentMediaTime() + 0.6
        animation.repeatCount = 1
        layer.add(animation, forKey: nil)
    }
    
    @objc func launchingRocket() {
        addShakingAnimation(to: shapeLayer)
        addFlyingAnimation(to: shapeLayer)
        addShakingAnimation(to: circle)
        addFlyingAnimation(to: circle)
    }
}
