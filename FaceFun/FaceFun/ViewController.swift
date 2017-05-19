import UIKit
import FaceTracker

class ViewController: UIViewController, FaceTrackerViewControllerDelegate, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var faceTrackerViewController: FaceTrackerViewController?
    var pointViews = [UIView]()

    let layer = CAShapeLayer()
    
    var overlayEffects = OverlayEffects.init()

    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var optionsButton: UIButton!
    @IBOutlet var faceTrackerContainerView: UIView!
    
    let icons = [UIImage(named:"black_hat"), UIImage(named:"hair"), UIImage(named:"monocle2"), UIImage(named:"eyeglasses1"), UIImage(named:"clown-nose1"), UIImage(named:"moustache"), UIImage(named:"smilingmouth1"), UIImage(named:"rain1"), UIImage(named:"codes1"), UIImage(named:"fish1")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.view.insertSubview(overlayEffects.rainView, aboveSubview: faceTrackerContainerView)
        self.view.insertSubview(overlayEffects.codesView, aboveSubview: faceTrackerContainerView)
        self.view.insertSubview(overlayEffects.fishView, aboveSubview: faceTrackerContainerView)
        self.view.insertSubview(overlayEffects.hatView, aboveSubview: faceTrackerContainerView)
        self.view.insertSubview(overlayEffects.monocleView, aboveSubview: faceTrackerContainerView)
        self.view.insertSubview(overlayEffects.lensSwirlView, aboveSubview: faceTrackerContainerView)
        self.view.insertSubview(overlayEffects.lensView, aboveSubview: faceTrackerContainerView)
        self.view.insertSubview(overlayEffects.noseView, aboveSubview: faceTrackerContainerView)
        self.view.insertSubview(overlayEffects.mouthView, aboveSubview: faceTrackerContainerView)
        self.view.insertSubview(overlayEffects.eyeglassesView, aboveSubview: faceTrackerContainerView)
        self.view.insertSubview(overlayEffects.monocleView, aboveSubview: faceTrackerContainerView)
        self.view.insertSubview(overlayEffects.eyeglassesLensView, aboveSubview: faceTrackerContainerView)
        self.view.insertSubview(overlayEffects.hairView, aboveSubview: faceTrackerContainerView)
        self.view.insertSubview(overlayEffects.moustacheView, aboveSubview: faceTrackerContainerView)
        self.view.insertSubview(overlayEffects.blackHatView, aboveSubview: faceTrackerContainerView)

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

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "embedFaceTrackerViewController") {
            faceTrackerViewController = segue.destination as? FaceTrackerViewController
            faceTrackerViewController!.delegate = self
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if (indexPath.row == 0 || indexPath.row == 1) {
            if (overlayEffects.hairOverlay == indexPath.row) {
                overlayEffects.hairOverlay = -1
            } else {
                overlayEffects.hairOverlay = Int(indexPath.row)
            }
        } else if (indexPath.row == 2 || indexPath.row == 3) {
            if (overlayEffects.eyeOverlay == indexPath.row) {
                overlayEffects.eyeOverlay = 0
            } else {
                overlayEffects.eyeOverlay = Int(indexPath.row)
            }
        } else if (indexPath.row == 4) {
            if (overlayEffects.noseOverlay == indexPath.row) {
                overlayEffects.noseOverlay = 0
            } else {
                overlayEffects.noseOverlay = Int(indexPath.row)
            }
        } else if (indexPath.row == 5 || indexPath.row == 6) {
            if (overlayEffects.mouthOverlay == indexPath.row) {
                overlayEffects.mouthOverlay = 0
            } else {
                overlayEffects.mouthOverlay = Int(indexPath.row)
            }
        } else if (indexPath.row == 7 || indexPath.row == 8 || indexPath.row == 9) {
            if (overlayEffects.overlay == indexPath.row) {
                overlayEffects.overlay = 0
            } else {
                overlayEffects.overlay = Int(indexPath.row)
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

        UIGraphicsBeginImageContextWithOptions(CGSize(width: 450, height: 500), view.isOpaque, 0.0)
        view!.drawHierarchy(in: CGRect(x: -15, y: -100, width: view.bounds.size.width * 1.5, height: view.bounds.size.height * 1.4), afterScreenUpdates: true)
        let snapshotImageFromMyView = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        UIImageWriteToSavedPhotosAlbum(snapshotImageFromMyView!, nil, nil, nil)
        
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
            
            if (overlayEffects.hairOverlay == 0) {
                overlayEffects.hairView.isHidden = true
                overlayEffects.showHat(points: points)
            } else if (overlayEffects.hairOverlay == 1) {
                overlayEffects.blackHatView.isHidden = true
                overlayEffects.showHair(points: points)
            } else {
                overlayEffects.hairView.isHidden = true
                overlayEffects.blackHatView.isHidden = true
            }
            
            if (overlayEffects.eyeOverlay == 2) {
                overlayEffects.eyeglassesView.isHidden = true
                overlayEffects.eyeglassesLensView.isHidden = true
                overlayEffects.showMonocle(points: points)
            } else if (overlayEffects.eyeOverlay == 3) {
                overlayEffects.monocleView.isHidden = true
                overlayEffects.lensView.alpha = 0
                overlayEffects.lensSwirlView.alpha = 0
                overlayEffects.lensView.isHidden = true
                overlayEffects.lensSwirlView.isHidden = true
                overlayEffects.showGlasses(points: points)
            } else {
                overlayEffects.eyeglassesView.isHidden = true
                overlayEffects.eyeglassesLensView.isHidden = true
                overlayEffects.monocleView.isHidden = true
                overlayEffects.lensView.alpha = 0
                overlayEffects.lensSwirlView.alpha = 0
                overlayEffects.lensView.isHidden = true
                overlayEffects.lensSwirlView.isHidden = true
            }
            
            if (overlayEffects.noseOverlay == 4) {
                overlayEffects.showClownNose(points: points)
            } else {
                overlayEffects.noseView.isHidden = true
            }
            
            if (overlayEffects.mouthOverlay == 5) {
                overlayEffects.mouthView.isHidden = true
                overlayEffects.showMoustache(points: points)
            } else if (overlayEffects.mouthOverlay == 6) {
                overlayEffects.moustacheView.isHidden = true
                overlayEffects.showMouth(points: points)
            } else {
                overlayEffects.mouthView.isHidden = true
                overlayEffects.moustacheView.isHidden = true
            }
            
            if (overlayEffects.overlay == 7) {
                overlayEffects.codesView.isHidden = true
                overlayEffects.fishView.isHidden = true
                overlayEffects.showRain(points: points)
            } else if (overlayEffects.overlay == 8) {
                overlayEffects.rainView.isHidden = true
                overlayEffects.fishView.isHidden = true
                overlayEffects.showCodes(points: points)
            } else if (overlayEffects.overlay == 9) {
                overlayEffects.codesView.isHidden = true
                overlayEffects.rainView.isHidden = true
                overlayEffects.showFish(points: points)
            } else {
                overlayEffects.codesView.isHidden = true
                overlayEffects.rainView.isHidden = true
                overlayEffects.fishView.isHidden = true
            }
        }
        else {
            overlayEffects.hatView.isHidden = true
            overlayEffects.monocleView.isHidden = true
            overlayEffects.lensView.alpha = 0
            overlayEffects.lensSwirlView.alpha = 0
            overlayEffects.lensView.isHidden = true
            overlayEffects.lensSwirlView.isHidden = true
            overlayEffects.eyeglassesView.isHidden = true
            overlayEffects.eyeglassesLensView.isHidden = true
            overlayEffects.noseView.isHidden = true
            overlayEffects.moustacheView.isHidden = true
            overlayEffects.hairView.isHidden = true
            overlayEffects.blackHatView.isHidden = true
            overlayEffects.mouthView.isHidden = true
            overlayEffects.rainView.isHidden = true
            overlayEffects.codesView.isHidden = true
            
            for view in pointViews {
                view.isHidden = true
            }
        }
    }
}

