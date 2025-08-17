// Copyright 2016 LinkedIn Corp.
// Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License.
// You may obtain a copy of the License at http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.

import UIKit

/// Runs benchmarks for different kinds of layouts.
class BenchmarkViewController: UITableViewController {

    private let reuseIdentifier = "cell"

    private let viewControllers: [ViewControllerData] = [
        
        //
        // Ordered alphabetically
        //
        
        ViewControllerData(title: "Auto Layout", factoryBlock: { viewCount in
            let data = FeedItemData.generate(count: viewCount)
            return CollectionViewControllerFeedItemAutoLayoutView(data: data)
        }),
        
        ViewControllerData(title: "FlexLayout 2.2", factoryBlock: { viewCount in
            let data = FeedItemData.generate(count: viewCount)
            return CollectionViewControllerFeedItemFlexLayoutView(data: data)
        }),
        
        ViewControllerData(title: "LayoutKit 10.1", factoryBlock: { viewCount in
            let data = FeedItemData.generate(count: viewCount)
            return CollectionViewControllerFeedItemLayoutKitView(data: data)
        }),

        ViewControllerData(title: "Manual Layout", factoryBlock: { viewCount in
            let data = FeedItemData.generate(count: viewCount)
            return CollectionViewControllerFeedItemManualView(data: data)
        }),
		
		ViewControllerData(title: "NKFrameLayoutKit 2.5", factoryBlock: { viewCount in
			let data = FeedItemData.generate(count: viewCount)
			return CollectionViewControllerFeedItemNKFrameLayoutKitView(data: data)
		}),
        
        ViewControllerData(title: "NotAutoLayout 3.2", factoryBlock: { viewCount in
            let data = FeedItemData.generate(count: viewCount)
            return CollectionViewControllerFeedItemNotAutoLayoutView(data: data)
        }),
        
        ViewControllerData(title: "PinLayout 1.10.6", factoryBlock: { viewCount in
            let data = FeedItemData.generate(count: viewCount)
            return CollectionViewControllerFeedItemPinLayoutView(data: data)
        }),

        ViewControllerData(title: "Texture 3.2", factoryBlock: { viewCount in
            let data = FeedItemData.generate(count: viewCount)
            return TextureCollectionViewController(data: data)
        }),

        ViewControllerData(title: "UIStackView", factoryBlock: { viewCount in
            if #available(iOS 9.0, *) {
                let data = FeedItemData.generate(count: viewCount)
                return CollectionViewControllerFeedItemUIStackView(data: data)
            } else {
                NSLog("UIStackView only supported on iOS 9+")
                return nil
            }
        })
    ]

    convenience init() {
        self.init(style: .grouped)
        title = "Benchmarks"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewControllers.count + 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = UITableViewCell()
            cell.textLabel?.text = "Run all benchmarks"
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
            cell.textLabel?.text = viewControllers[indexPath.row - 1].title
            return cell
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\nseconds/ops for each iterations (10, 20, ..., 100)")
        print("-------------------------------------")

        if indexPath.row == 0 {
            runAllBenchmarks()
        } else {
            let viewControllerData = viewControllers[indexPath.row - 1]
            runBenchmark(viewControllerData: viewControllerData, logResults: true, completed: { (results) in
                self.printResults(name: viewControllerData.title, results: results)
            })
        }
    }

    private func runAllBenchmarks() {
        var benchmarkIndex = 0

        func benchmarkCompleted(_ results: [Result]) {
            printResults(name: viewControllers[benchmarkIndex].title, results: results)

            DispatchQueue.main.async {
                self.navigationController?.popViewController(animated: false)

                benchmarkIndex += 1
                if benchmarkIndex < self.viewControllers.count {
                    self.runBenchmark(viewControllerData: self.viewControllers[benchmarkIndex], logResults: false, completed: benchmarkCompleted)
                } else {
                    print("Completed!")
                }
            }
        }

        runBenchmark(viewControllerData: viewControllers[benchmarkIndex], logResults: false, completed: benchmarkCompleted)
    }

    private func printResults(name: String, results: [Result]) {
        var resultsString = "\(name)\t"
        results.forEach { (result) in
            let a = "\(result.secondsPerOperation)"
            resultsString += String(a.prefix(6))
            resultsString += ","
        }
        print(resultsString)
    }

    private func runBenchmark(viewControllerData: ViewControllerData, logResults: Bool, completed: ((_ results: [Result]) -> Void)?) {
        guard let viewController = viewControllerData.factoryBlock(20) else {
            return
        }

        benchmark(viewControllerData, logResults: logResults, completed: completed)

        viewController.title = viewControllerData.title
        navigationController?.pushViewController(viewController, animated: logResults)
    }

    private func benchmark(_ viewControllerData: ViewControllerData, logResults: Bool, completed: ((_ results: [Result]) -> Void)?) {
//        let iterations = [1]
        let iterations = [10, 20, 30, 40, 50, 60, 70, 80, 90, 100]
        var results: [Result] = []

        for i in iterations {
            let description = "\(i)\tsubviews\t\(viewControllerData.title)"
            let result = Stopwatch.benchmark(description, logResults: logResults, block: { (stopwatch: Stopwatch) -> Void in
                let vc = viewControllerData.factoryBlock(i)
                stopwatch.resume()
                vc?.view.layoutIfNeeded()
                stopwatch.pause()
            })

            results.append(result)
        }

        completed?(results)
    }
}

private struct ViewControllerData {
    let title: String
    let factoryBlock: (_ viewCount: Int) -> UIViewController?
}
