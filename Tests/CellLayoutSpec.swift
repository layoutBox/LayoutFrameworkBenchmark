//  Copyright (c) 2017 Luc Dion
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

import Quick
import Nimble
@testable import LayoutFrameworkBenchmark

class CellLayoutSpec: QuickSpec {
    override func spec() {
        var viewController: UIViewController!
        let data = FeedItemData.generate(count: 1)[0]
        
        beforeSuite {
        }

        beforeEach {
            viewController = UIViewController()
            viewController.view = UIView()
        }

        describe("layout all cells with a width of 600 pixels") {
            it("test LayoutKit") {
                let feedItemView = FeedItemLayoutKitView(frame: .zero)
                feedItemView.setData(data)
                feedItemView.layoutIfNeeded()

                let size = feedItemView.sizeThatFits(CGSize(width: 600, height: CGFloat.greatestFiniteMagnitude))
                feedItemView.frame = CGRect(origin: .zero, size: size)

                expect(feedItemView.frame).to(equal(CGRect(x: 0.0, y: 0.0, width: 600, height: 600.0)))
            }

            it("test PinLayout") {
                let feedItemView = FeedItemPinLayoutView(frame: .zero)
                let size = feedItemView.sizeThatFits(CGSize(width: 600, height: CGFloat.greatestFiniteMagnitude))

                feedItemView.frame = CGRect(origin: .zero, size: size)
                expect(feedItemView.frame).to(equal(CGRect(x: 0.0, y: 0.0, width: 600, height: 600.0)))
            }
        }
    }
}
