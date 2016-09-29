## NKSimpleTable

Class for quickly creating tables on macOS. No data sources, no delegates.

Create table containing a bunch of buttons:

```swift
let table = NKSimpleTable<String, NSButton>()
table.build = { NSButton() }
table.update = { view, item in
  view.title = item
}

table.items = ["Foo", "Bar", "Baz"]
```

More complicated table with custom struct and custom view:

```swift
class MyView: NSView {
  override init(frame frameRect: NSRect) {
    super.init(frame: frameRect) 

    let button = NSButton()
    addSubview(button)
    // TODO: Layout
  }
}

struct MyStruct {
  title: String
}

let table = NKSimpleTable<MyStruct, MyView>()
table.build = { MyView() }
table.update = { view, item in
  view.button.title = item.title
}

table.items = [
  MyStruct(title: "Foo"),
  MyStruct(title: "Bar"),
  MyStruct(title: "Baz")
]
```