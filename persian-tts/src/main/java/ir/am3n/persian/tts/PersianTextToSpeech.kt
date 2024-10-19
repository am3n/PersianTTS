package ir.am3n.persian.tts

import android.content.Context
import android.media.AudioAttributes
import android.media.AudioFormat
import android.media.AudioManager
import android.media.AudioTrack
import android.os.Bundle
import android.speech.tts.TextToSpeech
import android.speech.tts.UtteranceProgressListener
import android.util.Log
import androidx.annotation.Keep
import com.k2fsa.sherpa.onnx.OfflineTts
import com.k2fsa.sherpa.onnx.OfflineTtsConfig
import java.util.concurrent.ExecutorService
import java.util.concurrent.Executors

typealias UtteranceProgressListener = UtteranceProgressListener
typealias OnInitListener = TextToSpeech.OnInitListener

@Keep
class PersianTextToSpeech(
    context: Context,
    onInitListener: OnInitListener
) {

    companion object {
        const val TAG = "PersianTTS"
        const val SUCCESS = TextToSpeech.SUCCESS
        const val ERROR = TextToSpeech.ERROR
        const val QUEUE_ADD = TextToSpeech.QUEUE_ADD
        const val QUEUE_FLUSH = TextToSpeech.QUEUE_FLUSH
    }

    private lateinit var tts: OfflineTts
    private lateinit var track: AudioTrack

    private var utteranceProgressListener: UtteranceProgressListener? = null

    private var speechRate: Float = 1.0f

    private var executor: ExecutorService = Executors.newSingleThreadExecutor()
    private val tasks = mutableListOf<Task>()

    init {
        try {
            val speakers = initOfflineTTS(context)
            if (speakers <= 0) {
                shutdownOfflineTTS()
                throw Exception("TTS number of speakers is zero")
            }
            initAudioTrack()
            onInitListener.onInit(SUCCESS)
        } catch (t: Throwable) {
            Log.e(TAG, "init", t)
            onInitListener.onInit(ERROR)
        }
    }

    private fun initOfflineTTS(context: Context): Int {
        if (::tts.isInitialized) {
            shutdownOfflineTTS()
        }
        Log.i(TAG, "initOfflineTTS()")
        tts = OfflineTts(
            assetManager = null,
            config = OfflineTtsConfig.build(context = context)
        )
        return tts.numSpeakers()
    }

    private fun shutdownOfflineTTS() {
        try {
            tts.release()
        } catch (_: Throwable) {
        }
    }

    private fun initAudioTrack(streamType: Int = AudioManager.STREAM_SYSTEM) {
        val sampleRate = tts.sampleRate()
        Log.i(TAG, "initAudioTrack() > sample-rate: $sampleRate")
        if (::track.isInitialized) {
            shutdownAudioTrack()
        }
        track = AudioTrack(
            AudioAttributes.Builder()
                .apply {
                    when (streamType) {
                        AudioManager.STREAM_MUSIC -> {
                            setContentType(AudioAttributes.CONTENT_TYPE_MUSIC)
                            setUsage(AudioAttributes.USAGE_MEDIA)
                        }
                        AudioManager.STREAM_VOICE_CALL -> {
                            setContentType(AudioAttributes.CONTENT_TYPE_SPEECH)
                            setUsage(AudioAttributes.USAGE_VOICE_COMMUNICATION)
                        }
                        AudioManager.STREAM_NOTIFICATION -> {
                            setContentType(AudioAttributes.CONTENT_TYPE_SONIFICATION)
                            setUsage(AudioAttributes.USAGE_NOTIFICATION)
                        }
                        AudioManager.STREAM_RING -> {
                            setContentType(AudioAttributes.CONTENT_TYPE_SONIFICATION)
                            setUsage(AudioAttributes.USAGE_NOTIFICATION_RINGTONE)
                        }
                        AudioManager.STREAM_ALARM -> {
                            setContentType(AudioAttributes.CONTENT_TYPE_SONIFICATION)
                            setUsage(AudioAttributes.USAGE_ALARM)
                        }
                        else -> {
                            setContentType(AudioAttributes.CONTENT_TYPE_SONIFICATION)
                            setUsage(AudioAttributes.USAGE_ASSISTANCE_SONIFICATION)
                        }
                    }
                }
                .build(),
            AudioFormat.Builder()
                .setEncoding(AudioFormat.ENCODING_PCM_FLOAT)
                .setChannelMask(AudioFormat.CHANNEL_OUT_MONO)
                .setSampleRate(sampleRate)
                .build(),
            AudioTrack.getMinBufferSize(
                sampleRate,
                AudioFormat.CHANNEL_OUT_MONO,
                AudioFormat.ENCODING_PCM_FLOAT
            ),
            AudioTrack.MODE_STREAM,
            AudioManager.AUDIO_SESSION_ID_GENERATE
        )
    }

    private fun setAudioParams(params: Bundle) {
        val streamType = params.getInt(TextToSpeech.Engine.KEY_PARAM_STREAM, -1)
        if (streamType >= 0) {
            if (track.streamType != streamType) {
                initAudioTrack(streamType)
            }
        }
        val streamVolume = params.getFloat(TextToSpeech.Engine.KEY_PARAM_VOLUME, -1f)
        if (streamVolume >= 0) {
            track.setVolume(streamVolume)
        }
    }

    private fun shutdownAudioTrack() {
        try {
            track.pause()
            track.flush()
            track.stop()
        } catch (_: Throwable) {
        }
        try {
            track.release()
        } catch (_: Throwable) {
        }
    }

    var isSpeaking: Boolean = false


    fun setOnUtteranceProgressListener(utteranceProgressListener: UtteranceProgressListener?) {
        this.utteranceProgressListener = utteranceProgressListener
    }

    fun setSpeechRate(speechRate: Float) {
        this.speechRate = speechRate
    }

    @Synchronized
    fun playSilentUtterance(durationInMs: Long, queueMode: Int = QUEUE_ADD, utteranceId: String? = null): Int {
        try {
            Log.i(TAG, "playSilentUtterance()   durationInMs=$durationInMs   queueMode=$queueMode   utteranceId=$utteranceId")
            if (!::track.isInitialized) {
                isSpeaking = false
                return ERROR
            }
            if (queueMode == QUEUE_FLUSH) {
                stop()
            }
            val task = object : Task() {
                override fun run() {
                    try {
                        Log.i(TAG, "playSilentUtterance() > task start")
                        if (utteranceId != null && !terminated) {
                            utteranceProgressListener?.onStart(utteranceId)
                        }
                        if (!terminated) {
                            isSpeaking = true
                        }
                        Thread.sleep(durationInMs)
                        if (utteranceId != null && !terminated) {
                            utteranceProgressListener?.onDone(utteranceId)
                        }
                        Log.i(TAG, "playSilentUtterance() > task done")
                    } catch (t: Throwable) {
                        if (!t.toString().contains("InterruptedException")) {
                            Log.e(TAG, "playSilentUtterance() > task", t)
                            if (utteranceId != null && !terminated) {
                                utteranceProgressListener?.onError(utteranceId, 0)
                            }
                        }
                    } finally {
                        if (!terminated) {
                            isSpeaking = false
                        }
                    }
                }
            }
            tasks.add(task)
            executor.submit(task)
            return SUCCESS
        } catch (t: Throwable) {
            Log.e(TAG, "playSilentUtterance()", t)
            return ERROR
        }
    }

    @Synchronized
    fun speak(text: String, queueMode: Int = QUEUE_ADD, params: Bundle? = null, utteranceId: String? = null): Int {
        try {
            Log.i(TAG, "speak()   text=$text   queueMode=$queueMode   utteranceId=$utteranceId")
            if (!::tts.isInitialized || !::track.isInitialized) {
                isSpeaking = false
                return ERROR
            }
            if (queueMode == QUEUE_FLUSH) {
                stop()
            }
            val task = object : Task() {
                override fun run() {
                    try {
                        Log.i(TAG, "speak() > task start")
                        if (!terminated && params != null) {
                            setAudioParams(params)
                        }
                        if (!terminated && track.playState != AudioTrack.PLAYSTATE_PLAYING) {
                            track.play()
                        }
                        if (!terminated && utteranceId != null) {
                            utteranceProgressListener?.onStart(utteranceId)
                        }
                        if (!terminated) {
                            isSpeaking = true
                        }
                        if (!terminated) {
                            tts.generateWithCallback(
                                text = text,
                                sid = 0,
                                speed = speechRate,
                                callback = { samples ->
                                    if (terminated)
                                        return@generateWithCallback 0
                                    Log.i(TAG, "speak() > generate() > samples.size= ${samples.size}")
                                    track.write(samples.clone(), 0, samples.size, AudioTrack.WRITE_BLOCKING)
                                    return@generateWithCallback 1
                                }
                            )
                        }
                        if (!terminated && utteranceId != null) {
                            utteranceProgressListener?.onDone(utteranceId)
                        }
                        Log.i(TAG, "speak() > task done")
                    } catch (t: Throwable) {
                        Log.e(TAG, "speak() > task", t)
                        if (!terminated && utteranceId != null) {
                            utteranceProgressListener?.onError(utteranceId, 0)
                        }
                    } finally {
                        if (!terminated) {
                            isSpeaking = false
                        }
                    }
                }
            }
            tasks.add(task)
            executor.submit(task)
            return SUCCESS
        } catch (t: Throwable) {
            Log.e(TAG, "speak()", t)
            return ERROR
        }
    }

    @Synchronized
    fun stop() {
        try {
            tasks.onEach { it.terminated = true }
            executor.shutdownNow()
            track.pause()
            track.flush()
            track.stop()
            isSpeaking = false
            executor = Executors.newSingleThreadExecutor()
        } catch (t: Throwable) {
            t.printStackTrace()
        }
    }

    fun shutdown() {
        stop()
        shutdownAudioTrack()
        shutdownOfflineTTS()
    }

}