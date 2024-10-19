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
                copyFile(context, path)
            } else {
                val fullPath = "${context.getExternalFilesDir(null)}/$path"
                File(fullPath).apply { mkdirs() }
                for (asset in assets.iterator()) {
                    val p: String = if (path == "") "" else "$path/"
                    copyAssets(context, "$p$asset")
                }
            }
        } catch (t: Throwable) {
            Log.e("SherpaOnnxTts", "Utils > Failed to copy $path. $t")
        }
    }

    private fun copyFile(context: Context, filename: String) {
        try {
            val istream = context.assets.open(filename)
            val newFilename = context.getExternalFilesDir(null).toString() + "/" + filename
            val ostream = FileOutputStream(newFilename)
            // Log.i(TAG, "Copying $filename to $newFilename")
            val buffer = ByteArray(1024)
            var read = 0
            while (read != -1) {
                ostream.write(buffer, 0, read)
                read = istream.read(buffer)
            }
            istream.close()
            ostream.flush()
            ostream.close()
        } catch (t: Throwable) {
            Log.e("SherpaOnnxTts", "Utils > Failed to copy $filename, $t")
        }
    }

}