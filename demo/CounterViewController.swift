//
//  CounterViewController.swift
//  demo
//
//  Created by apple on 16/5/13.
//  Copyright © 2016年 jackWang. All rights reserved.
//

import UIKit
import ReSwift

class CounterViewController: UIViewController,StoreSubscriber {
    @IBOutlet var counterLabel: UILabel!

    override func viewWillAppear(animated: Bool) {
        mainStore.subscribe(self)
    }
    
    override func viewWillDisappear(animated: Bool) {
        mainStore.unsubscribe(self)
    }
    
    func newState(state: AppState) {
        counterLabel.text = "\(state.counter)"
    }
    
    @IBAction func increaseButtonTapped(sender: UIButton) {
        mainStore.dispatch(
            CounterActionIncrease()
        )
    }
    
    @IBAction func decreaseButtonTapped(sender: UIButton) {
        mainStore.dispatch(
            CounterActionDecrease()
        )
    }

}
