#!/bin/sh

$(xcrun --find docc) process-archive transform-for-static-hosting DPUIKit.doccarchive --hosting-base-path DPUIKit-swift --output-path ./docs