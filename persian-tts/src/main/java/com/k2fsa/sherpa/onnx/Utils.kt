package com.k2fsa.sherpa.onnx

import android.content.Context
import android.util.Log
import java.io.File
import java.io.FileOutputStream

object Utils {

    internal fun copyDataDir(context: Context, dataDir: String): String {
        copyAssets(context, dataDir)
        return context.getExternalFilesDir(null)!!.absolutePath
    }

    private fun copyAssets(context: Context, path: String) {
        try {
            val assets = context.assets.list(path)
            if (assets!!.isEmpty()) {
                val newPath = context.getExternalFilesDir(null).toString() + "/" + path
                if (!File(newPath).isFile) {
                    copyFile(context, path, newPath)
                }
            } else {
                File("${context.getExternalFilesDir(null)}/$path").apply { mkdirs() }
                for (asset in assets.iterator()) {
                    copyAssets(context, "${if (path == "") "" else "$path/"}$asset")
                }
            }
        } catch (t: Throwable) {
            Log.e("SherpaOnnxTts", "Utils > Failed to copy $path. $t")
        }
    }

    private fun copyFile(context: Context, path: String, newPath: String) {
        try {
            val istream = context.assets.open(path)
            val ostream = FileOutputStream(newPath)
            val buffer = ByteArray(64 * 1024)
            var read = 0
            while (read != -1) {
                ostream.write(buffer, 0, read)
                read = istream.read(buffer)
            }
            istream.close()
            ostream.flush()
            ostream.close()
        } catch (t: Throwable) {
            Log.e("SherpaOnnxTts", "Utils > Failed to copy $path, $t")
        }
    }

}