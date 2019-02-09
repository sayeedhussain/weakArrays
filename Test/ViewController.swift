
import UIKit

final class WeakBox<T: AnyObject> {
    weak var unbox: T?
    init(_ value: T) {//constructor with non-optional AnyObject
        unbox = value
    }
}

struct WeakArray<Element: AnyObject> {
    private let items: [WeakBox<Element>]
    init(_ elements: [Element]) {
        items = elements.map { WeakBox($0) }
    }
}

extension WeakArray: Collection {
    var startIndex: Int { return items.startIndex}
    var endIndex: Int { return items.endIndex}
    subscript(_ index: Int) -> Element? {
        return items[index].unbox
    }
    func index(after idx: Int) -> Int {
        return items.index(after: idx)
    }
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let view = UIView()
        let a = WeakBox(view)
        /*strong var view goes nil after the function exits the scope as it's a local variable.
         Hence printing with dispatch_async gives nil*/
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()) {
            print(a.unbox)
        }
    }
}

