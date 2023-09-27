# ``DPUIKit``

An unobtrusive set of extensions and classes for UIKit.

## Overview
Test text.

```swift
swift package --allow-writing-to-directory /docs \
    generate-documentation --target DPUIKit \
    --disable-indexing \
    --transform-for-static-hosting \
    --hosting-base-path https://dplibs.github.io/DPUIKit-swift/ \
    --output-path /docs

swift package --allow-writing-to-directory ./docs \
    generate-documentation --target DPUIKit --output-path ./docs

$(xcrun --find docc) process-archive transform-for-static-hosting DPUIKit.doccarchive --hosting-base-path DPUIKit-swift --output-path ./docs
```

## Topics

- <doc:MVVM>
- <doc:Coordinators>
- <doc:Table>
- <doc:Xcode_templates>
