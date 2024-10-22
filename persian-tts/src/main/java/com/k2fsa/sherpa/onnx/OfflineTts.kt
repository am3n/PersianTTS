package com.k2fsa.sherpa.onnx

import android.content.res.AssetManager
import androidx.annotation.Keep

@Keep
class OfflineTts(
    assetManager: AssetManager? = null,
    private var config: OfflineTtsConfig
) {

    companion object {
        init {
            System.loadLibrary("sherpa-onnx-jni")
        }
    }

    private var ptr: Long

    init {
        ptr = if (assetManager != null) {
            newFromAsset(assetManager, config)
        } else {
            newFromFile(config)
        }
    }

    fun sampleRate() = getSampleRate(ptr)

    fun numSpeakers() = getNumSpeakers(ptr)

    fun generate(
        text: String,
        sid: Int = 0,
        speed: Float = 1.0f
    ): GeneratedAudio {
        val objArray = generateImpl(ptr, text = text, sid = sid, speed = speed)
        return GeneratedAudio(
            samples = objArray[0] as FloatArray,
            sampleRate = objArray[1] as Int
        )
    }

    fun generateWithCallback(
        text: String,
        sid: Int = 0,
        speed: Float = 1.0f,
        callback: (samples: FloatArray) -> Int
    ): GeneratedAudio {
        val objArray = generateWithCallbackImpl(
            ptr,
            text = text,
            sid = sid,
            speed = speed,
            callback = object : (FloatArray) -> Int {
                override fun invoke(samples: FloatArray): Int {
                    return callback.invoke(samples)
                }
            }
        )
        return GeneratedAudio(
            samples = objArray[0] as FloatArray,
            sampleRate = objArray[1] as Int
        )
    }

    private fun applyBabyEffect(samples: FloatArray, originalSampleRate: Int): FloatArray {
        val newSampleRate = (originalSampleRate * 2.0).toInt()
        return changeSampleRate(samples, originalSampleRate, newSampleRate)
    }

    private fun applyMagicChordsEffect(samples: FloatArray, originalSampleRate: Int): FloatArray {
        val newSampleRate = (originalSampleRate * 1.25).toInt()
        return changeSampleRate(samples, originalSampleRate, newSampleRate)
    }

    private fun applyReverseEffect(samples: FloatArray): FloatArray {
        return samples.reversedArray()
    }

    private fun applyRobotEffect(samples: FloatArray, frequency: Int = 44100 / 40): FloatArray {
        val output = samples.copyOf()
        for (i in samples.indices) {
            if (i % frequency < frequency / 2) {
                output[i] = 0.0f
            }
        }
        return output
    }

    private fun applyEchoEffect(samples: FloatArray, delay: Int = 44100 / 4, decay: Float = 0.5f): FloatArray {
        val output = samples.copyOf()
        for (i in samples.indices) {
            if (i >= delay) {
                output[i] += decay * samples[i - delay]
            }
        }
        return output
    }

    private fun applyDeepVoiceEffect(samples: FloatArray, originalSampleRate: Int): FloatArray {
        val newSampleRate = (originalSampleRate * 0.75).toInt()
        return changeSampleRate(samples, originalSampleRate, newSampleRate)
    }

    private fun applyChipmunkEffect(samples: FloatArray, originalSampleRate: Int): FloatArray {
        val newSampleRate = (originalSampleRate * 1.5).toInt()
        return changeSampleRate(samples, originalSampleRate, newSampleRate)
    }

    private fun changeSampleRate(audioData: FloatArray, originalSampleRate: Int, newSampleRate: Int): FloatArray {
        val ratio = newSampleRate.toFloat() / originalSampleRate
        val newLength = (audioData.size / ratio).toInt()
        val newAudioData = FloatArray(newLength)

        for (i in newAudioData.indices) {
            val oldIndex = (i * ratio).toInt()
            newAudioData[i] = audioData[oldIndex]
        }

        return newAudioData
    }

    fun allocate(assetManager: AssetManager? = null) {
        if (ptr == 0L) {
            ptr = if (assetManager != null) {
                newFromAsset(assetManager, config)
            } else {
                newFromFile(config)
            }
        }
    }

    fun release() {
        if (ptr != 0L) {
            delete(ptr)
            ptr = 0
        }
    }

    private external fun newFromAsset(assetManager: AssetManager, config: OfflineTtsConfig): Long

    private external fun newFromFile(config: OfflineTtsConfig): Long

    private external fun delete(ptr: Long)
    private external fun getSampleRate(ptr: Long): Int
    private external fun getNumSpeakers(ptr: Long): Int

    // The returned array has two entries:
    //  - the first entry is an 1-D float array containing audio samples.
    //    Each sample is normalized to the range [-1, 1]
    //  - the second entry is the sample rate

    private external fun generateImpl(
        ptr: Long,
        text: String,
        sid: Int = 0,
        speed: Float = 1.0f
    ): Array<Any>

    private external fun generateWithCallbackImpl(
        ptr: Long,
        text: String,
        sid: Int = 0,
        speed: Float = 1.0f,
        callback: (samples: FloatArray) -> Int
    ): Array<Any>

}
