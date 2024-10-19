package com.k2fsa.sherpa.onnx

data class OfflineTtsModelConfig(
    var vits: OfflineTtsVitsModelConfig,
    var numThreads: Int = 1,
    var debug: Boolean = false,
    var provider: String = "cpu"
)
