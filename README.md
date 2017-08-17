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

- **[LocalCache](http://www.kyson.cn/demo/watermelon.zip)**

Add your_package.zip to your project(this zip file is your local cache of package setted in ver.json)

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

if your package is yourpackage.zip,and your host address is www.yourhost.com, then your verjson is liked

```objc
{"errorMsg": "", "code": 0, "data": [{"zipDownloadUrl": "http://www.yourhost.com/yourpackage.zip", "version": "1.0.1"}]}
```


## Detail Useage


## Sponsor
![Github](http://outgtntjo.bkt.clouddn.com/alipay.jpg?imageView2/2/w/200)
![Github](http://outgtntjo.bkt.clouddn.com/wechatpay.jpg?imageView2/2/w/200/)
