package com.k2fsa.sherpa.onnx

import androidx.annotation.Keep

@Keep
class GeneratedAudio(
    val samples: FloatArray,
    val sampleRate: Int,
) {

    fun save(filename: String) =
        saveImpl(filename = filename, samples = samples, sampleRate = sampleRate)

    private external fun saveImpl(
        filename: String,
        samples: FloatArray,
        sampleRate: Int
    ): Boolean

}