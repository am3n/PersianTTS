# PersianTTS
![MinAPI](https://img.shields.io/badge/API-21%2B-blue)
[![Release](https://jitpack.io/v/am3n/PersianTTS.svg)](https://jitpack.io/#am3n/PersianTTS)

<b>Persian text to speech android library based on Sherpa ONNX &amp; eSpeak</b>

## Resources

* https://k2-fsa.github.io/sherpa/onnx/android/build-sherpa-onnx.html#download-pre-trained-models
* https://github.com/k2-fsa/sherpa-onnx/issues/524
* https://k2-fsa.github.io/sherpa/onnx/tts/apk.html

## Installation

To use this library in your project add this to your build.gradle:

```gradle
allprojects {
    repositories {
        maven { url 'https://jitpack.io' }
    }
}
dependencies {
    implementation 'com.github.am3n:PersianTTS:NEWEST-VERSION'
}
```
