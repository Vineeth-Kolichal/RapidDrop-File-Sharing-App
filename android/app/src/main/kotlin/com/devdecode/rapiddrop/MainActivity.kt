package com.devdecode.rapiddrop

import android.content.ContentValues
import android.os.Build
import android.os.Environment
import android.provider.MediaStore
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.io.File
import java.io.FileInputStream
import java.io.FileOutputStream
import java.io.IOException

class MainActivity: FlutterActivity() {
    private val CHANNEL = "com.devdecode.rapiddrop/files"

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "saveFileToDownloads") {
                val path = call.argument<String>("path")
                val name = call.argument<String>("name")

                if (path != null && name != null) {
                    saveFileToDownloads(path, name, result)
                } else {
                    result.error("INVALID_ARGUMENTS", "Path or name is null", null)
                }
            } else {
                result.notImplemented()
            }
        }
    }

    private fun saveFileToDownloads(sourcePath: String, fileName: String, result: MethodChannel.Result) {
        try {
            val sourceFile = File(sourcePath)
            if (!sourceFile.exists()) {
                result.error("FILE_NOT_FOUND", "Source file does not exist", null)
                return
            }

            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
                // Use MediaStore for Android 10+
                val contentValues = ContentValues().apply {
                    put(MediaStore.MediaColumns.DISPLAY_NAME, fileName)
                    // Try to determine mime type or default to binary
                    // put(MediaStore.MediaColumns.MIME_TYPE, "application/octet-stream") 
                    put(MediaStore.MediaColumns.RELATIVE_PATH, Environment.DIRECTORY_DOWNLOADS)
                }

                val resolver = context.contentResolver
                val uri = resolver.insert(MediaStore.Downloads.EXTERNAL_CONTENT_URI, contentValues)

                if (uri != null) {
                    resolver.openOutputStream(uri).use { outputStream ->
                        FileInputStream(sourceFile).use { inputStream ->
                            inputStream.copyTo(outputStream!!)
                        }
                    }
                    result.success(uri.toString())
                } else {
                    result.error("MEDIA_STORE_ERROR", "Failed to create MediaStore entry", null)
                }
            } else {
                // Legacy storage for Android 9 and below
                val downloadsDir = Environment.getExternalStoragePublicDirectory(Environment.DIRECTORY_DOWNLOADS)
                if (!downloadsDir.exists()) {
                    downloadsDir.mkdirs()
                }

                val destFile = File(downloadsDir, fileName)
                
                // Handle duplicate names if necessary, but simple copy for now
                FileInputStream(sourceFile).use { inputStream ->
                    FileOutputStream(destFile).use { outputStream ->
                        inputStream.copyTo(outputStream)
                    }
                }
                result.success(destFile.absolutePath)
            }
        } catch (e: Exception) {
            result.error("SAVE_ERROR", e.message, null)
        }
    }
}