package com.k2fsa.sherpa.onnx

data class OfflineTtsVitsModelConfig(
    var model: String,
    var lexicon: String = "",
    var tokens: String,
    var dataDir: String = "",
    var dictDir: String = "",
    var noiseScale: Float = 0.667f,
    var noiseScaleW: Float = 0.8f,
    var lengthScale: Float = 1.0f
)