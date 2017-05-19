//
//  OverlayEffects.swift
//  FaceFun
//
//  Created by James Ong on 2016-10-16.
//  Copyright © 2017 ModiFace Inc. All rights reserved.
//

import Foundation

class OverlayEffects {
    
    var hatView = UIImageView()
    var monocleView = UIImageView()
    var eyeglassesView = UIImageView()
    var eyeglassesLensView = UIImageView()
    var noseView = UIImageView()
    var hairView = UIImageView()
    var moustacheView = UIImageView()
    var mouthView = UIImageView()
    var blackHatView = UIImageView()
    var lensView = UIImageView()
    var lensSwirlView = UIImageView()
    var rainView = UIImageView()
    var codesView = UIImageView()
    var fishView = UIImageView()
    
    var hairOverlay: Int {
        set { self.hairOverlay = hairOverlay }
        get { return hairOverlay }
    }
    var eyeOverlay: Int {
        set { self.eyeOverlay = eyeOverlay }
        get { return eyeOverlay }
    }
    var noseOverlay: Int {
        set { self.noseOverlay = noseOverlay }
        get { return noseOverlay }
    }
    var mouthOverlay: Int {
        set { self.mouthOverlay = mouthOverlay }
        get { return mouthOverlay }
    }
    var overlay: Int {
        set { self.overlay = overlay }
        get { return overlay }
    }
    
    let rain = UIImage.animatedImage(with: [UIImage(named:"rain1")!, UIImage(named:"rain2")!, UIImage(named:"rain3")!, UIImage(named:"rain4")!, UIImage(named:"rain5")!], duration: 0.5)
    
    let codes = UIImage.animatedImage(with: [UIImage(named:"codes1")!, UIImage(named:"codes2")!, UIImage(named:"codes3")!, UIImage(named:"codes4")!, UIImage(named:"codes5")!, UIImage(named:"codes6")!, UIImage(named:"codes7")!, UIImage(named:"codes8")!, UIImage(named:"codes9")!], duration: 0.5)
    
    let fish = UIImage.animatedImage(with: [UIImage(named:"fish1")!, UIImage(named:"fish2")!, UIImage(named:"fish3")!, UIImage(named:"fish4")!, UIImage(named:"fish5")!, UIImage(named:"fish5")!, UIImage(named:"fish7")!], duration: 1.0)
    
    let clownNose = UIImage.animatedImage(with: [UIImage(named:"clown-nose1")!, UIImage(named:"clown-nose2")!, UIImage(named:"clown-nose3")!, UIImage(named:"clown-nose4")!, UIImage(named:"clown-nose5")!], duration: 2)
    
    let mouth = UIImage.animatedImage(with: [UIImage(named:"smilingmouth1")!, UIImage(named:"smilingmouth2")!, UIImage(named:"smilingmouth3")!, UIImage(named:"smilingmouth4")!, UIImage(named:"smilingmouth5")!, UIImage(named:"smilingmouth6")!], duration: 1.0)

    let eyeglassesLens = UIImage.animatedImage(with: [UIImage(named:"eyeglasses1lens1")!, UIImage(named:"eyeglasses1lens2")!, UIImage(named:"eyeglasses1lens3")!, UIImage(named:"eyeglasses1lens4")!, UIImage(named:"eyeglasses1lens5")!, UIImage(named:"eyeglasses1lens6")!], duration: 1.5)

    
    init() {
        hairOverlay = -1
        eyeOverlay = 0
        noseOverlay = 0
        mouthOverlay = 0
        overlay = 0
        
        rainView = UIImageView(image: rain)
        rainView.isHidden = true
        codesView = UIImageView(image: codes)
        codesView.isHidden = true
        fishView = UIImageView(image: fish)
        fishView.isHidden = true
        
        hatView.image = UIImage(named: "hat")
        monocleView.image = UIImage(named: "monocle1")
        lensSwirlView.image = UIImage(named: "lens swirl")
        lensView.image = UIImage(named: "lens")
        
        noseView = UIImageView(image: clownNose)
        noseView.isHidden = true
        mouthView = UIImageView(image: mouth)
        mouthView.isHidden = true
        
        eyeglassesView.image = UIImage(named: "eyeglasses1")
        monocleView.image = UIImage(named: "monocle1")
        
        eyeglassesLensView = UIImageView(image: eyeglassesLens)
        eyeglassesLensView.isHidden = true
        
        hairView.image = UIImage(named: "hair")
        moustacheView.image = UIImage(named: "moustache")
        blackHatView.image = UIImage(named: "black_hat")

    }
    
    func showMonocle(points: FacePoints) {
        // Compute the monocle frame
        let eyeCornerDist = sqrt(pow(points.rightEye[0].x - points.rightEye[5].x, 2) + pow(points.rightEye[0].y - points.rightEye[5].y, 2))
        let eyeToEyeCenter = CGPoint(x: (points.rightEye[0].x + points.rightEye[5].x) / 2, y: (points.rightEye[0].y + points.rightEye[5].y) / 2)
        
        let eyeglassesWidth = 2.5 * eyeCornerDist
        let eyeglassesHeight = (monocleView.image!.size.height / monocleView.image!.size.width) * eyeglassesWidth
        
        monocleView.transform = CGAffineTransform.identity
        
        monocleView.frame = CGRect(x: eyeToEyeCenter.x - eyeglassesWidth / 2, y: eyeToEyeCenter.y - 0.5 * eyeglassesHeight, width: eyeglassesWidth, height: eyeglassesHeight)
        
        monocleView.isHidden = false
        
        lensView.transform = CGAffineTransform.identity
        
        lensView.frame = CGRect(x: eyeToEyeCenter.x - eyeglassesWidth / 2, y: eyeToEyeCenter.y - 0.5 * eyeglassesHeight, width: eyeglassesWidth, height: eyeglassesHeight)
        
        lensView.isHidden = false
        
        UIView.animate(withDuration: 5, animations: {
            self.lensView.alpha = 1
        })
        
        lensSwirlView.transform = CGAffineTransform.identity
        
        lensSwirlView.frame = CGRect(x:eyeToEyeCenter.x - eyeglassesWidth / 2, y: eyeToEyeCenter.y - 0.5 * eyeglassesHeight, width: eyeglassesWidth, height: eyeglassesHeight)
        
        UIView.animate(withDuration: 8, animations: {
            self.lensSwirlView.isHidden = false
            self.lensSwirlView.alpha = 1
            
            let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
            rotationAnimation.fromValue = 0.0
            rotationAnimation.toValue = M_PI * 100
            self.lensSwirlView.layer.add(rotationAnimation, forKey: nil)
        })
        
    }
    
    func showGlasses(points: FacePoints) {
        // Compute the eyeglasses frame
        let eyeCornerDist = sqrt(pow(points.leftEye[0].x - points.rightEye[5].x, 2) + pow(points.leftEye[0].y - points.rightEye[5].y, 2))
        let eyeToEyeCenter = CGPoint(x: (points.leftEye[0].x + points.rightEye[5].x) / 2, y: (points.leftEye[0].y + points.rightEye[5].y) / 2)
        
        let eyeglassesWidth = 1.5 * eyeCornerDist
        let eyeglassesHeight = (eyeglassesView.image!.size.height / eyeglassesView.image!.size.width) * eyeglassesWidth
        
        eyeglassesView.transform = CGAffineTransform.identity
        
        eyeglassesView.frame = CGRect(x: eyeToEyeCenter.x - eyeglassesWidth / 2, y: eyeToEyeCenter.y - 0.5 * eyeglassesHeight, width: eyeglassesWidth, height: eyeglassesHeight)
        
        eyeglassesView.isHidden = false
        
        setAnchorPoint(anchorPoint: CGPoint(x: 0.5, y: 1.0), forView: eyeglassesView)
        
        let angle = atan2(points.rightEye[5].y - points.leftEye[0].y, points.rightEye[5].x - points.leftEye[0].x)
        eyeglassesView.transform = CGAffineTransform(rotationAngle: angle)
        
        eyeglassesLensView.transform = CGAffineTransform.identity
        
        eyeglassesLensView.frame = CGRect(x: eyeToEyeCenter.x - eyeglassesWidth / 2, y: eyeToEyeCenter.y - 0.5 * eyeglassesHeight, width: eyeglassesWidth, height: eyeglassesHeight)
        
        eyeglassesLensView.isHidden = false
        eyeglassesLensView.alpha = 0.3
        
        setAnchorPoint(anchorPoint: CGPoint(x: 0.5, y: 1.0), forView: eyeglassesLensView)
        
        eyeglassesLensView.transform = CGAffineTransform(rotationAngle: angle)
    }
    
    func showHat(points: FacePoints) {
        // Compute the black hat frame
        let eyeCornerDist = sqrt(pow(points.leftEye[0].x - points.rightEye[5].x, 2) + pow(points.leftEye[0].y - points.rightEye[5].y, 2))
        let eyeToEyeCenter = CGPoint(x: (points.leftEye[0].x + points.rightEye[5].x) / 2, y: (points.leftEye[0].y + points.rightEye[5].y) / 2)
        
        let blackHatWidth = 2.2 * eyeCornerDist
        let blackHatHeight = (blackHatView.image!.size.height / blackHatView.image!.size.width) * blackHatWidth
        
        blackHatView.transform = CGAffineTransform.identity
        
        blackHatView.frame = CGRect(x: eyeToEyeCenter.x - blackHatWidth / 2, y: eyeToEyeCenter.y - 1.4 * blackHatHeight, width: blackHatWidth, height: blackHatHeight)
        blackHatView.isHidden = false
        
        setAnchorPoint(anchorPoint: CGPoint(x: 0.5, y: 1.0), forView: blackHatView)
        let angle = atan2(points.rightEye[5].y - points.leftEye[0].y, points.rightEye[5].x - points.leftEye[0].x)
        
        blackHatView.transform = CGAffineTransform(rotationAngle: angle)
    }
    
    func showHair(points: FacePoints) {
        // Compute the hair frame
        let eyeCornerDist = sqrt(pow(points.leftEye[0].x - points.rightEye[5].x, 2) + pow(points.leftEye[0].y - points.rightEye[5].y, 2))
        let eyeToEyeCenter = CGPoint(x: (points.leftEye[0].x + points.rightEye[5].x) / 2, y: (points.leftEye[0].y + points.rightEye[5].y) / 2)
        
        let hairWidth = 2.6 * eyeCornerDist
        let hairHeight = (hairView.image!.size.height / hairView.image!.size.width) * hairWidth
        
        hairView.transform = CGAffineTransform.identity
        
        hairView.frame = CGRect(x: eyeToEyeCenter.x - hairWidth / 2, y: eyeToEyeCenter.y - 0.7 * hairHeight, width: hairWidth, height: hairHeight)
        hairView.isHidden = false
        
        setAnchorPoint(anchorPoint: CGPoint(x: 0.5, y: 1.0), forView: hairView)
        let angle = atan2(points.rightEye[5].y - points.leftEye[0].y, points.rightEye[5].x - points.leftEye[0].x)
        
        hairView.transform = CGAffineTransform(rotationAngle: angle)
    }
    
    func showClownNose(points: FacePoints) {
        // Compute the nose frame
        let noseCornerDist = sqrt(pow(points.nose[0].x - points.nose[5].x, 2) + pow(points.nose[0].y - points.nose[0].y, 2))
        let noseCenter = CGPoint(x: (points.nose[0].x + points.nose[5].x) / 2, y: (points.nose[0].y + points.nose[5].y) / 2)
        
        let noseWidth = noseCornerDist * 1.2
        let noseHeight = (noseView.image!.size.height / noseView.image!.size.width) * noseWidth
        
        noseView.transform = CGAffineTransform.identity
        
        noseView.frame = CGRect(x: noseCenter.x - noseWidth / 2, y: noseCenter.y - 0.7 * noseHeight, width: noseWidth, height: noseHeight)
        noseView.isHidden = false
        
        setAnchorPoint(anchorPoint: CGPoint(x: 0.5, y: 1.0), forView: noseView)
        let angle = atan2(points.rightEye[5].y - points.leftEye[0].y, points.rightEye[5].x - points.leftEye[0].x)
        
        noseView.transform = CGAffineTransform(rotationAngle: angle)
    }
    
    func showMoustache(points: FacePoints) {
        // Compute the moustache frame
        let noseCornerDist = sqrt(pow(points.nose[0].x - points.nose[5].x, 2) + pow(points.nose[0].y - points.nose[0].y, 2))
        let noseCenter = CGPoint(x: (points.nose[0].x + points.nose[5].x) / 2, y: (points.nose[0].y + points.nose[5].y) / 2)
        
        let noseWidth = noseCornerDist * 2.2
        let noseHeight = (moustacheView.image!.size.height / moustacheView.image!.size.width) * noseWidth / 1.1
        
        moustacheView.transform = CGAffineTransform.identity
        
        moustacheView.frame = CGRect(x: noseCenter.x - noseWidth / 2, y: noseCenter.y - 0.1 * noseHeight, width: noseWidth, height: noseHeight)
        moustacheView.isHidden = false
        
        setAnchorPoint(anchorPoint: CGPoint(x: 0.5, y: 1.0), forView: moustacheView)
        let angle = atan2(points.rightEye[5].y - points.leftEye[0].y, points.rightEye[5].x - points.leftEye[0].x)
        
        moustacheView.transform = CGAffineTransform(rotationAngle: angle)
    }
    
    func showMouth(points: FacePoints) {
        // Compute the mouth frame
        let mouthCornerDist = sqrt(pow(points.outerMouth[0].x - points.outerMouth[5].x, 2) + pow(points.outerMouth[0].y - points.outerMouth[0].y, 2))
        let mouthCenter = CGPoint(x: (points.outerMouth[0].x + points.outerMouth[5].x) / 2, y: (points.outerMouth[0].y + points.outerMouth[5].y) / 2)
        
        let mouthWidth = mouthCornerDist * 2.0
        let mouthHeight = (mouthView.image!.size.height / mouthView.image!.size.width) * mouthWidth
        
        mouthView.transform = CGAffineTransform.identity
        
        mouthView.frame = CGRect(x: mouthCenter.x - mouthWidth / 2, y: mouthCenter.y - 0.4 * mouthHeight, width: mouthWidth, height: mouthHeight)
        mouthView.isHidden = false
        
        setAnchorPoint(anchorPoint: CGPoint(x: 0.5, y: 1.0), forView: mouthView)
        let angle = atan2(points.rightEye[5].y - points.leftEye[0].y, points.rightEye[5].x - points.leftEye[0].x)
        
        mouthView.transform = CGAffineTransform(rotationAngle: angle)
    }
    
    func showRain(points: FacePoints) {
        // Compute the rain frame
        let eyeCornerDist = sqrt(pow(points.leftEye[0].x - points.rightEye[5].x, 2) + pow(points.leftEye[0].y - points.rightEye[5].y, 2))
        let eyeToEyeCenter = CGPoint(x: (points.leftEye[0].x + points.rightEye[5].x) / 2, y: (points.leftEye[0].y + points.rightEye[5].y) / 2)
        
        let rainWidth = 2.6 * eyeCornerDist
        let rainHeight = (rainView.image!.size.height / rainView.image!.size.width) * rainWidth
        
        rainView.frame = CGRect(x: eyeToEyeCenter.x - rainWidth / 2, y: eyeToEyeCenter.y - 0.6 * rainHeight, width: rainWidth, height: rainHeight)
        rainView.isHidden = false
    }
    
    func showCodes(points: FacePoints) {
        codesView.frame = CGRect(x: 0, y: 0, width: self.faceTrackerContainerView.bounds.size.width, height: self.faceTrackerContainerView.bounds.size.height - 58)
        codesView.isHidden = false
    }
    
    func showFish(points: FacePoints) {
        fishView.frame = CGRect(x: 0, y: 0, width: self.faceTrackerContainerView.bounds.size.width, height: self.faceTrackerContainerView.bounds.size.height - 58)
        fishView.isHidden = false
    }

}
