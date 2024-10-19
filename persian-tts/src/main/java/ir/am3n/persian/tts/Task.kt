package ir.am3n.persian.tts

import androidx.annotation.Keep

@Keep
abstract class Task : Runnable {
    var terminated: Boolean = false
    abstract override fun run()
}