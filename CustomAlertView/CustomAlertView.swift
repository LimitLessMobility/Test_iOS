//
//  CustomAlertView.swift
//  CustomAlertView
//
//  Created by Brijesh Singh on 06/04/22.
//

import UIKit

enum AlertButtonType {
    case `default`
    case warning
}

class CustomAlertView: UIViewController {

    @IBOutlet var subView: UIView!
    @IBOutlet var lblMessage: UILabel!
    @IBOutlet var btnSecondary: UIButton!
    @IBOutlet var btnPrimary: UIButton!
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet weak var buttonStackView: UIStackView!

    private var primaryButtonOriginalWidth = 0.0
    private var secondaryButtonOriginalWidth = 0.0

    var firstButtonBGColor: UIColor = UIColor.lightText
    var secondButtonBGColor: UIColor = UIColor.red
    
    private var secondaryButtonClickCallback:(()->Void)?
    private var primaryButtonClickCallback:(()->Void)?

    //MARK: - Initailizers
    init() {
        super.init(nibName: "CustomAlertView", bundle: Bundle(for: CustomAlertView.self))
        self.modalPresentationStyle = .overFullScreen
        self.modalTransitionStyle = .crossDissolve
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("Deallocated: ",self)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.btnPrimary.sizeToFit()
            if self.btnPrimary.bounds.size.width > (self.buttonStackView.bounds.size.width - 15)/2 {
                self.buttonStackView.axis = .vertical
            }
            
            self.btnSecondary.sizeToFit()
            if self.btnSecondary.bounds.size.width > (self.buttonStackView.bounds.size.width - 15)/2 {
                self.buttonStackView.axis = .vertical
            }
        }
    }
    
    //MARK: - View Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.subView.isHidden = true
        DispatchQueue.main.asyncAfter(deadline: .now()+0.1) {
            self.subView.isHidden = false
            self.subView.transform = CGAffineTransform(scaleX: 0.70, y: 0.70)
            UIView.animate(withDuration:0.25,
                           delay: 0.0,
                           usingSpringWithDamping: 0.5,
                           initialSpringVelocity: 1.0,
                           options: .curveEaseInOut,
                           animations: {
                self.subView.transform = .identity
            }, completion: nil)
            
        }
        setupAlert()
    }
   
    
    //MARK: - Private Methods
    private func dismiss(completion:@escaping ()->Void){
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseOut, animations: {() -> Void in
            self.subView.transform = CGAffineTransform(scaleX: 0.90, y: 0.90)
        }, completion: {(finished: Bool) -> Void in
            
        })
        
        DispatchQueue.main.asyncAfter(deadline: .now()+0.1) {
            self.dismiss(animated: true, completion: completion)
        }
    }
    
    private func setupAlert() {
        subView.layer.masksToBounds = true
        subView.layer.cornerRadius = 10
        
        lblTitle.text = nil
        lblMessage.text = nil
        
        btnSecondary.isHidden = true
        btnSecondary.layer.masksToBounds = true
        btnSecondary.layer.cornerRadius = 5
        btnSecondary.backgroundColor = firstButtonBGColor

        btnPrimary.isHidden = true
        btnPrimary.layer.masksToBounds = true
        btnPrimary.layer.cornerRadius = 5
        btnPrimary.backgroundColor = secondButtonBGColor
    }

    //MARK: - Button Actions
    @IBAction func tapSecondaryButton(_ sender: UIButton) {
        self.dismiss {
            self.secondaryButtonClickCallback?()
        }
    }
    
    @IBAction func tapPrimaryButton(_ sender: UIButton) {
        self.dismiss {
            self.primaryButtonClickCallback?()
        }
    }
    
    //MARK: - Public Methods
    @discardableResult func presentAlert(on viewController:UIViewController) -> Self {
        viewController.present(self, animated: true) {
            
        }
        return self
    }

    @discardableResult func addTitle(title: String?, message:String?) -> Self {
        DispatchQueue.main.async { [weak self] in
            self?.lblTitle.text = title
            self?.lblMessage.text = message
        }
        return self
    }
    
    @discardableResult func addPrimaryButton(title:String, type: AlertButtonType = .default, completion:(()->Void)? = nil) -> Self {
        
        DispatchQueue.main.async { [weak self] in
            switch type {
            case .default:
                self?.btnPrimary.backgroundColor = .systemBlue
            case .warning:
                self?.btnPrimary.backgroundColor = .systemRed
            }
            self?.btnPrimary.setTitle(title, for: .normal)
            self?.btnPrimary.isHidden = false
        }
        primaryButtonClickCallback = completion
        return self
    }
    
    @discardableResult func addSecondaryButton(title:String, type: AlertButtonType = .default, completion:(()->Void)? = nil) -> Self  {
        
        DispatchQueue.main.async { [weak self] in
            switch type {
            case .default:
                self?.btnSecondary.backgroundColor = .systemGray6
            case .warning:
                self?.btnSecondary.backgroundColor = .systemRed
            }
            self?.btnSecondary.setTitle(title, for: .normal)
            self?.btnSecondary.isHidden = false
        }
        secondaryButtonClickCallback = completion
        return self
    }

}

