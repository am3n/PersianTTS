package com.k2fsa.sherpa.onnx

import android.content.Context

data class OfflineTtsConfig(
    var model: OfflineTtsModelConfig,
    var ruleFsts: String = "",
    var ruleFars: String = "",
    var maxNumSentences: Int = 3
) {

    companion object {

        fun build(
            context: Context,
            debug: Boolean = true,
            maxNumSentences: Int = 3
        ): OfflineTtsConfig {

            var modelDir = "vits-piper-fa_IR-gyro-medium"
            val modelName = "fa_IR-gyro-medium.onnx"
            var dataDir = "espeak-ng-data"

            modelDir = "${Utils.copyDataDir(context, modelDir)}/$modelDir"
            dataDir = "${Utils.copyDataDir(context, dataDir)}/$dataDir"

            return OfflineTtsConfig(
                model = OfflineTtsModelConfig(
                    vits = OfflineTtsVitsModelConfig(
                        model = "$modelDir/$modelName",
                        lexicon = "$modelDir/",
                        tokens = "$modelDir/tokens.txt",
                        dataDir = dataDir
                    ),
                    debug = debug
                ),
                maxNumSentences = maxNumSentences
            )
        }

    }

}