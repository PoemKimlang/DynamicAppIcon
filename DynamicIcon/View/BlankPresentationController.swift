//
//  BlankPresentationController.swift
//  DynamicIcon
//
//  Created by Poem Kimlang on 24/3/25.
//

import UIKit

class BlankViewControllerTransitioningDelegate: NSObject, UIViewControllerTransitioningDelegate {

    func presentationController(forPresented presented: UIViewController,
                                presenting: UIViewController?,
                                source: UIViewController) -> UIPresentationController? {
        BlankPresentationController(presentedViewController: presented, presenting: presenting)
    }
}

final class BlankPresentationController: UIPresentationController {

    private lazy var dimmingView: UIView = {
        let dimmingView = UIView()
        dimmingView.translatesAutoresizingMaskIntoConstraints = false
        dimmingView.backgroundColor = .clear
        
        return dimmingView
    }()
    
    override func presentationTransitionWillBegin() {
        guard let containerView = containerView else {
            return
        }
        containerView.insertSubview(dimmingView, at: 0)
        
        NSLayoutConstraint.activate([
            dimmingView.topAnchor.constraint(equalTo: containerView.topAnchor),
            dimmingView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            dimmingView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            dimmingView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
        
        guard let coordinator = presentedViewController.transitionCoordinator else {
            dimmingView.alpha = 1
            return
        }
        
        coordinator.animate(alongsideTransition: { _ in
            self.dimmingView.alpha = 1
        })
    }
    
    override func dismissalTransitionWillBegin() {
        guard let coordinator = presentedViewController.transitionCoordinator else {
            dimmingView.alpha = 0
            return
        }
        
        coordinator.animate(alongsideTransition: { _ in
            self.dimmingView.alpha = 0
        })
    }
}
