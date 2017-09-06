<p align="center">
  <a href="https://github.com/lucdion/LayoutFrameworkBenchmark"><img src="docs_markdown/images/logo.png" alt="FlexLayout" width="270"/></a>
</p>

<h1 align="center" style="color: #376C9D; font-family: Arial Black, Gadget, sans-serif; font-size: 2em">Layout Framework Benchmark</h1>
 
<p align="center">
  <a href=""><img src="https://img.shields.io/cocoapods/p/FlexLayout.svg?style=flat" /></a>
  <a href="https://travis-ci.org/lucdion/LayoutFrameworkBenchmark"><img src="https://travis-ci.org/lucdion/LayoutFrameworkBenchmark.svg?branch=master" /></a>
  <a href="https://raw.githubusercontent.com/lucdion/LayoutFrameworkBenchmark/master/LICENSE"><img src="https://img.shields.io/badge/license-New%20BSD-blue.svg?style=flat" /></a>
</p>

<br>

Benchmark the performances of various Swift layout frameworks.

### Requirements
* iOS 8.0+
* Xcode 8.0+
* Swift 3.0+

# History <a name="history"></a>
This project is a spin-off of the excellent [LayoutKit benchmark](https://github.com/linkedin/LayoutKit). The benchmark has been extracted to add other iOS layout frameworks and to compare them.

<br>

# Why?
Choosing the right layout framework for your project is an important decision. The frameworks API is quite important, but its performance is also important. To help you with that decision, this benchmark compare different layout frameworks.

<br>

# Layout frameworks  <a name="layout_frameworks"></a>

**The benchmark currently includes the following layout frameworks:**  
(ordered alphabetically and use the framework GitHub's description):

* **Auto layout**  
Apple's auto layout constraints.  
[Auto layout benchmark's source code](https://github.com/lucdion/LayoutFrameworkBenchmark/blob/master/LayoutFrameworkBenchmark/Benchmarks/AutoLayout/FeedItemAutoLayoutView.swift)

* [**FlexLayout**](https://github.com/lucdion/FlexLayout)  
FlexLayout adds a nice Swift interface to the highly optimized [Yoga](https://github.com/facebook/yoga) flexbox implementation. Concise, intuitive & chainable syntax.  
[FlexLayout benchmark's source code](https://github.com/lucdion/LayoutFrameworkBenchmark/blob/master/LayoutFrameworkBenchmark/Benchmarks/FlexLayout/FeedItemFlexLayoutView.swift)

* [**LayoutKit**](https://github.com/linkedin/LayoutKit)  
LayoutKit is a fast view layout library for iOS, macOS, and tvOS.   
[LayoutKit benchmark's source code](https://github.com/lucdion/LayoutFrameworkBenchmark/tree/master/LayoutFrameworkBenchmark/Benchmarks/LayoutKit)

* **Manual layout**  
Layout is done by setting UIView's frame property directly.  
[Manual layout benchmark's source code](https://github.com/lucdion/LayoutFrameworkBenchmark/blob/master/LayoutFrameworkBenchmark/Benchmarks/ManualLayout/FeedItemManualView.swift)

* [**PinLayout**](https://github.com/mirego/PinLayout)  
Fast Swift UIViews layouting without auto layout. No magic, pure code, full control and blazing fast. Concise syntax, intuitive, readable & chainable.  
[PinLayout benchmark's source code](https://github.com/lucdion/LayoutFrameworkBenchmark/blob/master/LayoutFrameworkBenchmark/Benchmarks/PinLayout/FeedItemPinLayoutView.swift)

* **UIStackViews**  
Apple's UIStackViews.  
[UIStackViews benchmark's source code](https://github.com/lucdion/LayoutFrameworkBenchmark/blob/master/LayoutFrameworkBenchmark/Benchmarks/UIStackView/FeedItemUIStackView.swift)

* [**Yoga**](https://github.com/facebook/yoga)  
Yoga's performance hasn't been tested directly, but FlexLayout has. FlexLayout is a light Swift interface for Yoga. 


:pushpin: Anyone who would like to integrate any other layout frameworks to this GitHub project is welcome.

<br>

## Benchmark details
The benchmark layout UICollectionView and UITableView cells in multiple pass, each pass contains more cells than the previous one. 

## Benchmark cell's layout
Here are the benchmark rendering results to compare visual results:
 
* [Auto layout rendering result](docs_markdown/benchmark_result_Autolayout.png)
* [FlexLayout rendering result](docs_markdown/benchmark_result_FlexLayout.png)
* [PinLayout rendering result](docs_markdown/benchmark_result_PinLayout.png)
* [LayoutKit rendering result](docs_markdown/benchmark_result_LayoutKit.png)

:pushpin: Some work would be required to adjust the layout so that they all match perfectly. 

<br>

# Results <a name="results"></a>

## Benchmark data  
You can see the benchmark's raw data in this [spreadsheet](docs_markdown/benchmark.xlsx).

<br>

## Benchmark charts  

The **X axis** in following charts indicates the **number of cells** contained for each pass. The **Y axis** indicates the **number of seconds** to render all cells from one pass.

<p align="center">
  <a href="docs_markdown/benchmark_iphone7.png"><img src="docs_markdown/benchmark_iphone7.png"/></a>

<p align="center">
  <a href="docs_markdown/benchmark_iphone6s.png"><img src="docs_markdown/benchmark_iphone6s.png"/></a>

<p align="center">
  <a href="docs_markdown/benchmark_iphone6.png"><img src="docs_markdown/benchmark_iphone6.png"/></a>

<p align="center">
  <a href="docs_markdown/benchmark_iphone5.png"><img src="docs_markdown/benchmark_iphone5.png"/></a>

<br>

## Project's TODO list

* Create a reference layout and update layout codes to match that reference.
* Automate the benchmark to run all layout frameworks automatically.
* Display benchmark charts inside the app and being to able to export them.
* Export benchmark data to a spreadsheet.
* Add more layout frameworks.
* OSX support.
* tvOS support.
* ...

<br>

## Contributing, comments, ideas, suggestions, issues, .... <a name="comments"></a>
For any **comments**, **ideas**, **suggestions**, simply open an [issue](https://github.com/lucdion/LayoutFrameworkBenchmark/issues). 

If you'd like to contribute by adding other layout framework, you're welcome!

<br>

## Adding another layout framework

The process is currently tedious...
 
* Add an implementation of the reference view.
* Run on all reference devices (or at least the two latest generation) in **Release mode**.
* Select the new layout from the Benchmark App.
* Update the XLSX document.
* Add a new chart
* Save the chart using "Save as Picture..."
* Update the README.md
* Create a pull request.

## License
BSD 3-Clause License 
