package ir.am3n.persian.tts.sample

import android.os.Bundle
import android.os.Handler
import android.os.Looper
import android.util.Log
import android.widget.Toast
import androidx.activity.ComponentActivity
import ir.am3n.persian.tts.PersianTextToSpeech
import ir.am3n.persian.tts.UtteranceProgressListener

class MainActivity : ComponentActivity() {

    private lateinit var textToSpeech: PersianTextToSpeech

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        val now = System.currentTimeMillis()

        textToSpeech = PersianTextToSpeech(context = this) { state ->
            Handler(Looper.getMainLooper()).postDelayed({

                Log.d("Meeee", "initialized after ${System.currentTimeMillis() - now} ms")

                if (state == 0) {

                    textToSpeech.speak(
                        text = "سلام وقت بخیر، چطوری خوبی؟",
                        queueMode = PersianTextToSpeech.QUEUE_ADD,
                        params = null,
                        utteranceId = "1"
                    )

                    Handler(Looper.getMainLooper()).postDelayed({

                        textToSpeech.playSilentUtterance(
                            durationInMs = 3_000,
                            queueMode = PersianTextToSpeech.QUEUE_FLUSH,
                            utteranceId = "2"
                        )

                        Handler(Looper.getMainLooper()).postDelayed({
                            textToSpeech.speak(
                                text = "نام من متن به گفتار فارسی است",
                                queueMode = PersianTextToSpeech.QUEUE_FLUSH,
                                params = null,
                                utteranceId = "3"
                            )
                        }, 1000)

                    }, 2000)

                } else {
                    Toast.makeText(this, "Error $state", Toast.LENGTH_SHORT).show()
                }

            }, 700)
        }

        textToSpeech.setOnUtteranceProgressListener(object : UtteranceProgressListener() {

            override fun onStart(utteranceId: String) {
                Log.d("Meeee", "onStart()   utterance= $utteranceId")
            }

            override fun onDone(utteranceId: String) {
                Log.d("Meeee", "onDone()   utterance= $utteranceId")
            }

            @Deprecated("Deprecated in Java", ReplaceWith("utteranceProgressListener.onError(utteranceId, errorCode"))
            override fun onError(utteranceId: String) {}

            override fun onError(utteranceId: String, errorCode: Int) {
                super.onError(utteranceId, errorCode)
                Log.d("Meeee", "onError()   utterance= $utteranceId   error= $errorCode")
            }

        })

    }

}
