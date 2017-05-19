import UIKit
import FaceTracker

class ViewController: UIViewController, FaceTrackerViewControllerDelegate, UICollectionViewDelegate, UICollectionViewDataSource {
    var hatView = UIImageView()
    var faceTrackerViewController: FaceTrackerViewController?
    var pointViews = [UIView]()
   
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
    
    let layer = CAShapeLayer()
    var hairOverlay: Int = -1
    var eyeOverlay: Int = 0
    var noseOverlay: Int = 0
    var mouthOverlay: Int = 0
    var overlay: Int = 0
    
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var optionsButton: UIButton!
    @IBOutlet var faceTrackerContainerView: UIView!
    
    let icons = [UIImage(named:"black_hat"), UIImage(named:"hair"), UIImage(named:"monocle2"), UIImage(named:"eyeglasses1"), UIImage(named:"clown-nose1"), UIImage(named:"moustache"), UIImage(named:"smilingmouth1"), UIImage(named:"rain1"), UIImage(named:"codes1"), UIImage(named:"fish1")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let rain = UIImage.animatedImage(with: [UIImage(named:"rain1")!, UIImage(named:"rain2")!, UIImage(named:"rain3")!, UIImage(named:"rain4")!, UIImage(named:"rain5")!], duration: 0.5)
        rainView = UIImageView(image: rain)
        rainView.isHidden = true
        self.view.insertSubview(rainView, aboveSubview: faceTrackerContainerView)
        
        let codes = UIImage.animatedImage(with: [UIImage(named:"codes1")!, UIImage(named:"codes2")!, UIImage(named:"codes3")!, UIImage(named:"codes4")!, UIImage(named:"codes5")!, UIImage(named:"codes6")!, UIImage(named:"codes7")!, UIImage(named:"codes8")!, UIImage(named:"codes9")!], duration: 0.5)
        codesView = UIImageView(image: codes)
        codesView.isHidden = true
        self.view.insertSubview(codesView, aboveSubview: faceTrackerContainerView)
        
        let fish = UIImage.animatedImage(with: [UIImage(named:"fish1")!, UIImage(named:"fish2")!, UIImage(named:"fish3")!, UIImage(named:"fish4")!, UIImage(named:"fish5")!, UIImage(named:"fish5")!, UIImage(named:"fish7")!], duration: 1.0)
        fishView = UIImageView(image: fish)
        fishView.isHidden = true
        self.view.insertSubview(fishView, aboveSubview: faceTrackerContainerView)
        
        self.view.insertSubview(hatView, aboveSubview: faceTrackerContainerView)
        hatView.image = UIImage(named: "hat")
        
        self.view.insertSubview(monocleView, aboveSubview: faceTrackerContainerView)
        monocleView.image = UIImage(named: "monocle1")
        
        self.view.insertSubview(lensSwirlView, aboveSubview: faceTrackerContainerView)
        lensSwirlView.image = UIImage(named: "lens swirl")
        
        self.view.insertSubview(lensView, aboveSubview: faceTrackerContainerView)
        lensView.image = UIImage(named: "lens")
        
        let clownNose = UIImage.animatedImage(with: [UIImage(named:"clown-nose1")!, UIImage(named:"clown-nose2")!, UIImage(named:"clown-nose3")!, UIImage(named:"clown-nose4")!, UIImage(named:"clown-nose5")!], duration: 2)
        noseView = UIImageView(image: clownNose)
        noseView.isHidden = true
        self.view.insertSubview(noseView, aboveSubview: faceTrackerContainerView)
        
        let mouth = UIImage.animatedImage(with: [UIImage(named:"smilingmouth1")!, UIImage(named:"smilingmouth2")!, UIImage(named:"smilingmouth3")!, UIImage(named:"smilingmouth4")!, UIImage(named:"smilingmouth5")!, UIImage(named:"smilingmouth6")!], duration: 1.0)
        mouthView = UIImageView(image: mouth)
        mouthView.isHidden = true
        self.view.insertSubview(mouthView, aboveSubview: faceTrackerContainerView)
        
        self.view.insertSubview(eyeglassesView, aboveSubview: faceTrackerContainerView)
        eyeglassesView.image = UIImage(named: "eyeglasses1")
        
        self.view.insertSubview(eyeglassesView, aboveSubview: faceTrackerContainerView)
        monocleView.image = UIImage(named: "monocle1")
        
        let eyeglassesLens = UIImage.animatedImage(with: [UIImage(named:"eyeglasses1lens1")!, UIImage(named:"eyeglasses1lens2")!, UIImage(named:"eyeglasses1lens3")!, UIImage(named:"eyeglasses1lens4")!, UIImage(named:"eyeglasses1lens5")!, UIImage(named:"eyeglasses1lens6")!], duration: 1.5)
        eyeglassesLensView = UIImageView(image: eyeglassesLens)
        eyeglassesLensView.isHidden = true
        self.view.insertSubview(eyeglassesLensView, aboveSubview: faceTrackerContainerView)
        
        //self.view.insertSubview(noseView, aboveSubview: faceTrackerContainerView)
        //noseView.image = UIImage(named: "nose")
        
        self.view.insertSubview(hairView, aboveSubview: faceTrackerContainerView)
        hairView.image = UIImage(named: "hair")
        
        self.view.insertSubview(moustacheView, aboveSubview: faceTrackerContainerView)
        moustacheView.image = UIImage(named: "moustache")
        
        self.view.insertSubview(blackHatView, aboveSubview: faceTrackerContainerView)
        blackHatView.image = UIImage(named: "black_hat")
        
        //let layerY = eyeglassesHeight / 2 + 40
        //let layerX = eyeglassesWidth / 2 + 40
        
        //layer.anchorPoint = CGPoint(0.0, 100.5)
        /*
        layer.path = UIBezierPath(roundedRect: CGRect(x:CGRectGetMinX(eyeglassesView.bounds),y:CGRectGetMinY(eyeglassesView.bounds),width: 80,height: 80), cornerRadius: 80).CGPath
        layer.position = CGPoint(0.0, 150)
        layer.fillColor = UIColor(white: 1, alpha: 0.08).CGColor
 
        eyeglassesView.layer.addSublayer(layer)
        */
        //setAnchorPoint(CGPoint(0.5, 1.0), forView: layer)
        
        //layer.masksToBounds = true
        
        //layer.transform = CATransform3DMakeTranslation(0,0,0)

        //layer.transform = CATransform3DMakeScale(1, 1, 1)

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        faceTrackerViewController!.startTracking { () -> Void in
            self.activityIndicator.stopAnimating()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func prepare(for segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "embedFaceTrackerViewController") {
            faceTrackerViewController = segue.destination as? FaceTrackerViewController
            faceTrackerViewController!.delegate = self
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if (indexPath.row == 0 || indexPath.row == 1) {
            if (hairOverlay == indexPath.row) {
                hairOverlay = -1
            } else {
                hairOverlay = Int(indexPath.row)
            }
        } else if (indexPath.row == 2 || indexPath.row == 3) {
            if (eyeOverlay == indexPath.row) {
                eyeOverlay = 0
            } else {
                eyeOverlay = Int(indexPath.row)
            }
        } else if (indexPath.row == 4) {
            if (noseOverlay == indexPath.row) {
                noseOverlay = 0
            } else {
                noseOverlay = Int(indexPath.row)
            }
        } else if (indexPath.row == 5 || indexPath.row == 6) {
            if (mouthOverlay == indexPath.row) {
                mouthOverlay = 0
            } else {
                mouthOverlay = Int(indexPath.row)
            }
        } else if (indexPath.row == 7 || indexPath.row == 8 || indexPath.row == 9) {
            if (overlay == indexPath.row) {
                overlay = 0
            } else {
                overlay = Int(indexPath.row)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return icons.count
    }
    
    internal func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EffectsOverlay", for: indexPath as IndexPath) as! Cell
        
        cell.icon.image = icons[indexPath.row]
        
        return cell
    }
    
    @IBAction func optionsButtonPressed(sender: UIButton) {
        let alert = UIAlertController()
        alert.popoverPresentationController?.sourceView = optionsButton
        
        alert.addAction(UIAlertAction(title: "Swap Camera", style: .default, handler: { (action) -> Void in
            self.faceTrackerViewController!.swapCamera()
        }))
        /*
        alert.addAction(UIAlertAction(title: "Capture Screen", style: .Default, handler: { (action) -> Void in
            self.screenShotMethod()
        }))
        */
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func screenCapture(sender: AnyObject) {
        screenShotMethod()
    }
    
    @IBAction func swapCamera(sender: AnyObject) {
        self.faceTrackerViewController!.swapCamera()
    }
    
    func screenShotMethod() {
        /*let view = self.faceTrackerContainerView
        
        UIGraphicsBeginImageContext(CGSizeMake(view.bounds.size.width, view.bounds.size.height))
        UIGraphicsGetCurrentContext()!
        self.view?.drawViewHierarchyInRect(view.frame, afterScreenUpdates: true)
        let screenshot = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
 
        UIImageWriteToSavedPhotosAlbum(screenshot, nil, nil, nil)*/
        
        /*
        let view = self.faceTrackerContainerView
        let scale = UIScreen.mainScreen().scale
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, false, scale);
        
        view.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let screenshot = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        */
        
        /*
        let screenshot = view.snapshotViewAfterScreenUpdates(true)
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, false, 0);
        screenshot.drawViewHierarchyInRect(view.bounds, afterScreenUpdates: true)
        var image: UIImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        */
        
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 450, height: 500), view.isOpaque, 0.0)
        view!.drawHierarchy(in: CGRect(x: -15, y: -100, width: view.bounds.size.width * 1.5, height: view.bounds.size.height * 1.4), afterScreenUpdates: true)
        let snapshotImageFromMyView = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        UIImageWriteToSavedPhotosAlbum(snapshotImageFromMyView!, nil, nil, nil)
        
        /*
        let layer = UIApplication.sharedApplication().keyWindow!.layer
        let scale = UIScreen.mainScreen().scale
        UIGraphicsBeginImageContextWithOptions(layer.frame.size, false, scale);
        
        layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let screenshot = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        UIImageWriteToSavedPhotosAlbum(screenshot, nil, nil, nil)
        */
    }
    
    func setAnchorPoint(anchorPoint: CGPoint, forView view: UIView) {
        var newPoint = CGPoint(x: view.bounds.size.width * anchorPoint.x, y: view.bounds.size.height * anchorPoint.y)
        var oldPoint = CGPoint(x: view.bounds.size.width * view.layer.anchorPoint.x, y: view.bounds.size.height * view.layer.anchorPoint.y)
        
        newPoint = newPoint.applying(view.transform)
        oldPoint = oldPoint.applying(view.transform)
        
        var position = view.layer.position
        position.x -= oldPoint.x
        position.x += newPoint.x
        
        position.y -= oldPoint.y
        position.y += newPoint.y
        
        view.layer.position = position
        view.layer.anchorPoint = anchorPoint
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
        
        //setAnchorPoint(CGPoint(0.5, 1.0), forView: eyeglassesView)
        
        //let angle = atan2(points.rightEye[5].y - points.leftEye[0].y, points.rightEye[5].x - points.leftEye[0].x)
        //eyeglassesView.transform = CGAffineTransformMakeRotation(angle)
        
        lensView.transform = CGAffineTransform.identity
        
        lensView.frame = CGRect(x: eyeToEyeCenter.x - eyeglassesWidth / 2, y: eyeToEyeCenter.y - 0.5 * eyeglassesHeight, width: eyeglassesWidth, height: eyeglassesHeight)
        
        lensView.isHidden = false
        
        //let angle = atan2(points.rightEye[5].y - points.leftEye[0].y, points.rightEye[5].x - points.leftEye[0].x)
        
        UIView.animate(withDuration: 5, animations: {
            self.lensView.alpha = 1
        })
        
        // Compute the lens swirl frame
        lensSwirlView.transform = CGAffineTransform.identity
        
        lensSwirlView.frame = CGRect(x:eyeToEyeCenter.x - eyeglassesWidth / 2, y: eyeToEyeCenter.y - 0.5 * eyeglassesHeight, width: eyeglassesWidth, height: eyeglassesHeight)
        
        UIView.animate(withDuration: 8, animations: {
            self.lensSwirlView.isHidden = false
            self.lensSwirlView.alpha = 1
            
            //setAnchorPoint(CGPoint(0.5, 1.0), forView: lensSwirlView)
            //lensSwirlView.transform = CGAffineTransformMakeRotation(angle)
            
            let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
            rotationAnimation.fromValue = 0.0
            rotationAnimation.toValue = M_PI * 100
            //rotationAnimation.duration = 100
            //rotationAnimation.speed = 0.2
            self.lensSwirlView.layer.add(rotationAnimation, forKey: nil)
        })
        
        /*
        if (angle > 0) {
            UIView.animateWithDuration(2, animations: {
                self.lensView.alpha = 1
            })
            
            // Compute the lens swirl frame
            lensSwirlView.transform = CGAffineTransform.identity
            
            lensSwirlView.frame = CGRect(eyeToEyeCenter.x - eyeglassesWidth / 2, eyeToEyeCenter.y - 0.5 * eyeglassesHeight, eyeglassesWidth, eyeglassesHeight)
            
            UIView.animateWithDuration(5, animations: {
                self.lensSwirlView.hidden = false
                self.lensSwirlView.alpha = 1
                
                //setAnchorPoint(CGPoint(0.5, 1.0), forView: lensSwirlView)
                //lensSwirlView.transform = CGAffineTransformMakeRotation(angle)
                
                let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
                rotationAnimation.fromValue = 0.0
                rotationAnimation.toValue = M_PI * 100
                //rotationAnimation.duration = 100
                //rotationAnimation.speed = 0.2
                self.lensSwirlView.layer.addAnimation(rotationAnimation, forKey: nil)
            })
        } else {
            UIView.animateWithDuration(1, animations: {
                self.lensView.alpha = 0.5
            })
            
            UIView.animateWithDuration(3, animations: {
                self.lensSwirlView.alpha = 0
            }) { completed in
                if completed == true {
                    self.lensSwirlView.hidden = true
                }
            }
        }
        */
        
        //setAnchorPoint(CGPoint(0.5, 1.0), forView: lensView)
        //lensView.transform = CGAffineTransformMakeRotation(angle)
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
        
        //rainView.transform = CGAffineTransform.identity
        
        rainView.frame = CGRect(x: eyeToEyeCenter.x - rainWidth / 2, y: eyeToEyeCenter.y - 0.6 * rainHeight, width: rainWidth, height: rainHeight)
        rainView.isHidden = false
        
        //setAnchorPoint(CGPoint(0.5, 1.0), forView: rainView)
        //let angle = atan2(points.rightEye[5].y - points.leftEye[0].y, points.rightEye[5].x - points.leftEye[0].x)
        
        //rainView.transform = CGAffineTransformMakeRotation(angle)
    }
    
    func showCodes(points: FacePoints) {
        codesView.frame = CGRect(x: 0, y: 0, width: self.faceTrackerContainerView.bounds.size.width, height: self.faceTrackerContainerView.bounds.size.height - 58)
        codesView.isHidden = false
    }
    
    func showFish(points: FacePoints) {
        fishView.frame = CGRect(x: 0, y: 0, width: self.faceTrackerContainerView.bounds.size.width, height: self.faceTrackerContainerView.bounds.size.height - 58)
        fishView.isHidden = false
    }
    
    func faceTrackerDidUpdate(_ points: FacePoints?) {
        if let points = points {
            // Allocate some views for the points if needed
            if (pointViews.count == 0) {
                let numPoints = points.getTotalNumberOFPoints()
                for _ in 0...numPoints {
                    let view = UIView()
                    view.backgroundColor = UIColor.green
                    self.view.addSubview(view)
                    
                    pointViews.append(view)
                }
            }
            
            /*
            // Set frame for each point view
            points.enumeratePoints({ (point, index) -> Void in
                let pointView = self.pointViews[index]
                let pointSize: CGFloat = 4
                
                pointView.hidden = false
                pointView.frame = CGRectIntegral(CGRect(point.x - pointSize / 2, point.y - pointSize / 2, pointSize, pointSize))
            })
            */
 
            /*
            // Compute the eyeglasses frame
            let eyeCornerDist = sqrt(pow(points.leftEye[0].x - points.rightEye[5].x, 2) + pow(points.leftEye[0].y - points.rightEye[5].y, 2))
            let eyeToEyeCenter = CGPoint((points.leftEye[0].x + points.rightEye[5].x) / 2, (points.leftEye[0].y + points.rightEye[5].y) / 2)
            
            let eyeglassesWidth = 1.5 * eyeCornerDist
            let eyeglassesHeight = (eyeglassesView.image!.size.height / eyeglassesView.image!.size.width) * eyeglassesWidth
            
            eyeglassesView.transform = CGAffineTransform.identity
            
            eyeglassesView.frame = CGRect(eyeToEyeCenter.x - eyeglassesWidth / 2, eyeToEyeCenter.y - 0.5 * eyeglassesHeight, eyeglassesWidth, eyeglassesHeight)
            
            eyeglassesView.hidden = false
            
            setAnchorPoint(CGPoint(0.5, 1.0), forView: eyeglassesView)
            
            let angle = atan2(points.rightEye[5].y - points.leftEye[0].y, points.rightEye[5].x - points.leftEye[0].x)
            eyeglassesView.transform = CGAffineTransformMakeRotation(angle)
            */
            
            /*
            var toPoint: CGPoint = CGPoint(0.0, -10.0)
            var fromPoint : CGPoint = CGPointZero
            
            var movement = CABasicAnimation(keyPath: "movement")
            movement.additive = true
            movement.fromValue =  NSValue(CGPoint: fromPoint)
            movement.toValue =  NSValue(CGPoint: toPoint)
            movement.duration = 0.3
            
            view.layer.addAnimation(movement, forKey: "move")
            */
            
            if (hairOverlay == 0) {
                hairView.isHidden = true
                showHat(points: points)
            } else if (hairOverlay == 1) {
                blackHatView.isHidden = true
                showHair(points: points)
            } else {
                hairView.isHidden = true
                blackHatView.isHidden = true
            }
            
            if (eyeOverlay == 2) {
                eyeglassesView.isHidden = true
                eyeglassesLensView.isHidden = true
                showMonocle(points: points)
            } else if (eyeOverlay == 3) {
                monocleView.isHidden = true
                lensView.alpha = 0
                lensSwirlView.alpha = 0
                lensView.isHidden = true
                lensSwirlView.isHidden = true
                showGlasses(points: points)
            } else {
                eyeglassesView.isHidden = true
                eyeglassesLensView.isHidden = true
                monocleView.isHidden = true
                lensView.alpha = 0
                lensSwirlView.alpha = 0
                lensView.isHidden = true
                lensSwirlView.isHidden = true
            }
            
            if (noseOverlay == 4) {
                showClownNose(points: points)
            } else {
                noseView.isHidden = true
            }
            
            if (mouthOverlay == 5) {
                mouthView.isHidden = true
                showMoustache(points: points)
            } else if (mouthOverlay == 6) {
                moustacheView.isHidden = true
                showMouth(points: points)
            } else {
                mouthView.isHidden = true
                moustacheView.isHidden = true
            }
            
            if (overlay == 7) {
                codesView.isHidden = true
                fishView.isHidden = true
                showRain(points: points)
            } else if (overlay == 8) {
                rainView.isHidden = true
                fishView.isHidden = true
                showCodes(points: points)
            } else if (overlay == 9) {
                codesView.isHidden = true
                rainView.isHidden = true
                showFish(points: points)
            } else {
                codesView.isHidden = true
                rainView.isHidden = true
                fishView.isHidden = true
            }
            
            
            /*
            let colorTop: AnyObject = UIColor(red: 255.0/255.0, green: 213.0/255.0, blue: 63.0/255.0, alpha: 1.0).CGColor
            let colorBottom: AnyObject = UIColor(red: 255.0/255.0, green: 198.0/255.0, blue: 5.0/255.0, alpha: 1.0).CGColor
            let arrayOfColors: [AnyObject] = [colorTop, colorBottom]
            layer.colors = arrayOfColors
            */
            
            
            /*
            // Compute the nose frame
            let noseCornerDist = sqrt(pow(points.leftEye[0].x - points.rightEye[5].x, 2) + pow(points.leftEye[0].y - points.rightEye[5].y, 2))
            let noseToEyeCenter = CGPoint((points.leftEye[0].x + points.rightEye[5].x) / 2, (points.leftEye[0].y + points.rightEye[5].y) / 1.4)
            
            let noseWidth = noseCornerDist / 2
            let noseHeight = (noseView.image!.size.height / noseView.image!.size.width) * noseWidth / 1.2
            
            noseView.transform = CGAffineTransform.identity
            
            noseView.frame = CGRect(noseToEyeCenter.x - noseWidth / 2, noseToEyeCenter.y - 0.5 * noseHeight, noseWidth, noseHeight)
            noseView.hidden = false
            
            setAnchorPoint(CGPoint(0.5, 1.0), forView: noseView)
            
            let angle1 = atan2(points.rightEye[5].y - points.leftEye[0].y, points.rightEye[5].x - points.leftEye[0].x)
            noseView.transform = CGAffineTransformMakeRotation(angle1)
            */
            
            /*
            // Compute the hat frame
            let eyeCornerDist = sqrt(pow(points.leftEye[0].x - points.rightEye[5].x, 2) + pow(points.leftEye[0].y - points.rightEye[5].y, 2))
            let eyeToEyeCenter = CGPoint((points.leftEye[0].x + points.rightEye[5].x) / 2, (points.leftEye[0].y + points.rightEye[5].y) / 2)
            
            let hatWidth = 2.0 * eyeCornerDist
            let hatHeight = (hatView.image!.size.height / hatView.image!.size.width) * hatWidth
            
            hatView.transform = CGAffineTransform.identity
            
            hatView.frame = CGRect(eyeToEyeCenter.x - hatWidth / 2, eyeToEyeCenter.y - 1.3 * hatHeight, hatWidth, hatHeight)
            hatView.hidden = false
            
            setAnchorPoint(CGPoint(0.5, 1.0), forView: hatView)
            
            let angle = atan2(points.rightEye[5].y - points.leftEye[0].y, points.rightEye[5].x - points.leftEye[0].x)
            hatView.transform = CGAffineTransformMakeRotation(angle)
             */
        }
        else {
            hatView.isHidden = true
            monocleView.isHidden = true
            lensView.alpha = 0
            lensSwirlView.alpha = 0
            lensView.isHidden = true
            lensSwirlView.isHidden = true
            eyeglassesView.isHidden = true
            eyeglassesLensView.isHidden = true
            noseView.isHidden = true
            moustacheView.isHidden = true
            hairView.isHidden = true
            blackHatView.isHidden = true
            mouthView.isHidden = true
            rainView.isHidden = true
            codesView.isHidden = true
            
            for view in pointViews {
                view.isHidden = true
            }
        }
    }
}

