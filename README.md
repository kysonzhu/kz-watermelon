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

add package.zip to your project(this zip file is your local cache of package setted in ver.json)

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


## Discussion
You can add comments here : [Hybrid 框架Watermelon详解](http://kyson.cn/index.php/archives/91/)

or join the chat group

![Github](https://github.com/kysonzhu/kz-watermelon/blob/master/wechat_group.jpg?raw=true)



## Sponsor
![Github](http://outgtntjo.bkt.clouddn.com/alipay.jpg?imageView2/2/w/200)
![Github](http://outgtntjo.bkt.clouddn.com/wechatpay.jpg?imageView2/2/w/200/)

