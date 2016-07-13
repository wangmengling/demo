//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

enum Media {
    case Book(title: String, author: String, year: Int)
    case Movie(title: String, director: String, year: Int)
    case WebSite(url: NSURL, title: String)
}

extension Media {
    var mediaTitle: String {
        switch self {
        case .Book(title: let aTitle, author: _, year: _):
            return aTitle
        case .Movie(title: let aTitle, director: _, year: _):
            return aTitle
        case .WebSite(url: _, title: let aTitle):
            return aTitle
        }
    }
}

let book = Media.Book(title: "20,000 leagues under the sea", author: "Jules Verne", year: 1870)
book.mediaTitle

import XCPlayground

typealias DoneBlock = () -> ()
typealias WorkBlock = (DoneBlock) -> ()

class AsyncSerialWorker {
    private let serialQueue = dispatch_queue_create("com.khanlou.serial.queue", DISPATCH_QUEUE_SERIAL)
    
    func enqueueWork(work: WorkBlock) {
        dispatch_async(serialQueue) {
            let semaphore = dispatch_semaphore_create(0)
            work({
                dispatch_semaphore_signal(semaphore)
            })
            dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER)
        }
    }
}

let a = AsyncSerialWorker()

for i in 1...5 {
    a.enqueueWork { doneBlock in
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            sleep(arc4random_uniform(4)+1)
            print(i)
            doneBlock()
        }
    }
}

XCPlaygroundPage.currentPage.needsIndefiniteExecution = true

extension UIViewController {
    private struct AssociatedKeys {
        static var DescriptiveName = "nsh_DescriptiveName"
    }
}

var o1:Int? = 2

var o1m = o1.map({$0 * 2})

var o2m = o1.map { (value) -> String in
    String(value * 2)
    }.map({$0+"asdf"})

let ao1:[Int?] = [1,nil,3,4,5,6]

var ao1m = ao1.map({$0! * 2})

var a1ms = ao1.map({ (value) -> String in
    String(value! * 2)
}).map { (stringValue) -> Int? in
    Int(stringValue)
}

CFRunLoopSource
