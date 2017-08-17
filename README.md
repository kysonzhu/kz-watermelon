# Watermelon

A extensibe **Hybrid**  solution.  

## Getting started

### iOS
* integrate to your application
- **[CocoaPods](https://cocoapods.org)**

Add the following line to your Podfile:
```
pod 'Watermelon'
```
run `pod install`
* usage

```objc
[Watermelon registeWatermelonServiceWithVerJsonURL:Your_VER_JSON_URL];
```



### Server


* Setting VerJson File

Your VerJson is liked:

```objc
{"errorMsg": "", "code": 0, "data": [{"zipDownloadUrl": "http://www.kyson.cn/demo/watermelon.zip", "version": "1.0.1"}]}
```

* Setting Your H5 package

if your package is yourpackage.zip,and your host address is www.yourhost.com,then your verjson is liked

```objc
{"errorMsg": "", "code": 0, "data": [{"zipDownloadUrl": "http://www.yourhost.com/yourpackage.zip", "version": "1.0.1"}]}
```


## Detail Useage


## Sponsor

