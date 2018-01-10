// Copyright 2016 LinkedIn Corp.
// Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License.
// You may obtain a copy of the License at http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.

import Foundation

struct Result {
    var iterationCount: Int
    var opsPerSecond: Double
    var secondsPerOperation: Double
}

/// A stopwatch that can record elapsed time and benchmark closures.
class Stopwatch {

    let name: String
    private(set) var startTime: CFAbsoluteTime? = nil
    private(set) var elapsedTime: CFAbsoluteTime = 0

    init(name: String) {
        self.name = name
    }

    private func reset() {
        elapsedTime = 0
        startTime = nil
    }

    func resume() {
        if startTime == nil {
            startTime = CFAbsoluteTimeGetCurrent()
        }
    }

    func pause() {
        if let startTime = startTime {
            elapsedTime += CFAbsoluteTimeGetCurrent() - startTime
            self.startTime = nil
        }
    }

    /**
     Benchmarks the block and logs the result.
     The block is responsible for calling `resume()` and `pause()` on the stopwatch.
     */
    static func benchmark(_ name: String, logResults: Bool, block: @escaping (_ stopwatch: Stopwatch) -> Void) -> Result {
        return autoreleasepool { () -> Result in 
            let stopwatch = Stopwatch(name: name)

            // Make sure we collect enough samples.
            let minimumBenchmarkTime: CFAbsoluteTime = 1.0
            let minimumIterationCount = 5
            
            var iterationCount = 1
            while true {
                autoreleasepool {
                    block(stopwatch)
                }
                if stopwatch.elapsedTime >= minimumBenchmarkTime && iterationCount >= minimumIterationCount {
                    break
                }
                iterationCount += 1
            }
            stopwatch.pause()

            if logResults {
                let iterations = NSString(format: "%6d", iterationCount)
                let opsPerSecond = NSString(format: "%8.2f", Double(iterationCount)/stopwatch.elapsedTime)
                let secondsPerOperation = NSString(format: "%8.3f", stopwatch.elapsedTime / Double(iterationCount))
                print("\(opsPerSecond)\tops/s\t\(secondsPerOperation)\tseconds/ops\t\(iterations)\titerations\t\(name)")
            }

            return Result(iterationCount: iterationCount,
                          opsPerSecond: Double(iterationCount) / stopwatch.elapsedTime,
                          secondsPerOperation: stopwatch.elapsedTime / Double(iterationCount))
        }
    }
}
