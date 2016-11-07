//
//  Created by Pete Smith
//  http://www.petethedeveloper.com
//
//
//  License
//  Copyright © 2016-present Pete Smith
//  Released under an MIT license: http://opensource.org/licenses/MIT
//

import UIKit

/*
 Activity navigation bar provides a custom navigation bar with a build in
 activity indicator. The activity indicator is styled like a progress bar, 
 but is intended to be used to indicate indeterminate activity time.
 
 To achieve this, the activity is started with a 'waitAt' parameter.
 The activity bar will then animate progress to this point, and stop.
 Then, once our indeterminate activity has finished, we finish the 
 activity indicator.
 
*/
@IBDesignable
public class ActivityNavigationBar: UINavigationBar {
    
    /// Activity bar height
    @IBInspectable public var activityBarHeight: CGFloat? {
        didSet {
            guard let activityBarHeight = activityBarHeight else { return }
            
//            activityBarHeightConstraint?.constant = CGFloat(activityBarHeight)
        }
    }
    
    /// Activity bar color
    @IBInspectable public var activityBarColor: UIColor? {
        didSet {
            guard let activityBarColor = activityBarColor else { return }
            
            activityBarView?.tintColor = activityBarColor
        }
    }
    
    // MARK: - Properties (Private)
    private var activityBarView: UIProgressView?
    private var activityBarHeightConstraint: NSLayoutConstraint?
    
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
    
    
    /// Start the activity bar from progress 0, specifying a value to wait/stop at
    ///
    /// - Parameter waitValue: Value between 0 and 1
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
    
    
    /// Finish the activity bar, animating to a progress of 1, 
    /// using the specified animation duration
    ///
    /// - Parameter duration: The animation duration
    public func finishActivity(withDuration duration: Double, andCompletion completion: (() -> Void)? = nil) {
        
        startTimer?.invalidate()
        
        activityBarView?.progress = 1
        
        UIView.animateWithDuration(duration, animations: {
            self.activityBarView?.layoutIfNeeded()
        }, completion: { finished in
            if finished {
                self.activityBarView?.hidden = true
                self.activityBarView?.progress = 0.0
                
                completion?()
            }
        })
    }
    
    /// Reset the activity bar to 0 progress
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
        
        let containerView = UIView(frame: CGRect(x: 0, y: bounds.height - 3, width: bounds.width, height: 3))
        
        activityBarView = UIProgressView()
        
        guard let activityBarView = activityBarView else { return }
        
        containerView.addSubview(activityBarView)
        
        // Add to the navigation bar
        addSubview(containerView)
        
        // Appearance
        
        // Initially hide the progress view
        activityBarView.hidden = true
        
        // Color
        activityBarView.tintColor = .orangeColor()
        activityBarView.trackTintColor = .clearColor()
        
        // Constraints
        activityBarView.translatesAutoresizingMaskIntoConstraints = false
        
        activityBarView.leftAnchor.constraintEqualToAnchor(containerView.leftAnchor).active = true
        
        // The progress view sits at the bottom of the navigation bar
        activityBarView.bottomAnchor.constraintEqualToAnchor(containerView.bottomAnchor).active = true
        
        // The progress view is always full width
        activityBarView.widthAnchor.constraintEqualToAnchor(containerView.widthAnchor).active = true
        
        // The height can be changed
        activityBarHeightConstraint = activityBarView.heightAnchor.constraintEqualToConstant(3)
        activityBarHeightConstraint?.active = true
    }
}
