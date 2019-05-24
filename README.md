# BarChart
This is an extremely light-weight, animatable bar chart. The main objective is to help iOS developers to learn how to create their own charts from scratch without using any third-party libraries. 

It is created along with a tutorial on Medium:
[Tutorial on Medium](https://medium.com/@leonardnguyen/build-your-own-chart-in-ios-part-1-bar-chart-e1b7f4789d70)

# Demo

![demo](https://raw.githubusercontent.com/nhatminh12369/BarChart/master/demo.gif)

# Usage
```
let chart = BeautifulBarChart(frame: CGRect(x: 0, y: 0, width: 200, height: 300))
let dataEntries = [
    DataEntry(color: UIColor.red, height: 0.2, textValue: "20", title: "Some title"),
    DataEntry(color: UIColor.green, height: 0.7, textValue: "70", title: "Some title")
]
chart.updateDataEntries(dataEntries: dataEntries, animated: true)
self.view.addSubview(chart) // Assuming that you are writing this code inside a view controller
```

# Authors

Minh Nguyen, nvnminh0@gmail.com

# License

BarChart is available under the MIT license. See the LICENSE file for more info.
