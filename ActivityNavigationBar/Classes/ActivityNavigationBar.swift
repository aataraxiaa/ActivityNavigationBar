import UIKit

@IBDesignable
public class ActivityNavigationBar: UINavigationBar {
    
    /// Activity bar height
    public var activityBarHeight: CGFloat? {
        didSet {
            guard let activityBarHeight = activityBarHeight else { return }
            
            activityBarView?.heightAnchor.constraintEqualToConstant(activityBarHeight).active = true
        }
    }
    
    /// Activity bar color
    public var activityBarColor: UIColor? {
        didSet {
            guard let activityBarColor = activityBarColor else { return }
            
            activityBarView?.tintColor = activityBarColor
        }
    }
    
    // MARK: - Properties (Private)
    private var activityBarView: UIProgressView?
    private var startTimer: NSTimer?
    private var waitValue: Float = 0.8
    private var finishTimer: NSTimer?
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        commonInit()
    }
    
    // MARK: API
    
    public func startActivity(andWaitAt waitValue: Float) {
        
        guard waitValue > 0 && waitValue < 1 else {
            fatalError("The waitValue must be between 0 and 1")
        }
        
        activityBarView?.hidden = false
        activityBarView?.progress = 0.0
        
        self.waitValue = waitValue
        
        startTimer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self,
                                                            selector: #selector(updateStartProgress),
                                                            userInfo: nil, repeats: true)
    }
    
    public func finishActivity(withDuration duration: Double) {
        
        startTimer?.invalidate()
        
        activityBarView?.progress = 1
        
        UIView.animateWithDuration(duration, animations: {
            self.activityBarView?.layoutIfNeeded()
        }, completion: { finished in
            self.activityBarView?.hidden = true
            self.activityBarView?.progress = 0.0
        })
    
    }
    
    public func reset() {
        
        activityBarView?.hidden = true
        activityBarView?.setProgress(0, animated: false)
    }
    
    // MARK: - Activity bar progress
    
    @objc
    private func updateStartProgress() {
        
        guard let activityBarView = activityBarView else { return }
        
        guard let startTimer = startTimer where startTimer.valid else { return }
        
        guard activityBarView.progress < waitValue else {
            startTimer.invalidate()
            return
        }
        
        activityBarView.setProgress(activityBarView.progress + 0.1, animated: true)
    }
    
    // MARK: - Initialization
    
    private func commonInit() {
        
        addActivityView()
    }
    
    private func addActivityView() {
        
        let activityBarView = UIProgressView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        
        self.activityBarView = activityBarView
        
        // Add to the navigation bar
        clipsToBounds = false
        addSubview(activityBarView)
        
        // Appearance
        
        // Initially hide the progress view
        activityBarView.hidden = true
        
        // Color
        activityBarView.tintColor = .orangeColor()
        activityBarView.trackTintColor = .clearColor()
        
        // Constraints
        activityBarView.translatesAutoresizingMaskIntoConstraints = false
        
        activityBarView.leftAnchor.constraintEqualToAnchor(leftAnchor).active = true
        
        // The progress view sits at the bottom of the navigation bar
        activityBarView.bottomAnchor.constraintEqualToAnchor(bottomAnchor).active = true
        
        // The progress view is always full width
        activityBarView.widthAnchor.constraintEqualToAnchor(widthAnchor).active = true
        
        // The height can be changed
        activityBarView.heightAnchor.constraintEqualToConstant(3).active = true
    }
}
