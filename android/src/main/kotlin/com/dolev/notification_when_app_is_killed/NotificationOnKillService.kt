package com.dolev.notification_when_app_is_killed

import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.PendingIntent
import android.app.Service
import android.content.Context
import android.content.Intent
import android.os.Build
import android.os.IBinder
import android.provider.Settings
import androidx.annotation.RequiresApi
import androidx.core.app.NotificationCompat
import io.flutter.Log

class NotificationOnKillService: Service() {
    private lateinit var title: String
    private lateinit var description: String
    private var icon: String? = null

    override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int {
        title = intent?.getStringExtra("title") ?: "Your alarms may not ring"
        description = intent?.getStringExtra("description") ?: "You killed the app. Please reopen so your alarms can be rescheduled."
        icon = intent?.getStringExtra("icon")
        return START_STICKY
    }

    @RequiresApi(Build.VERSION_CODES.O)
    override fun onTaskRemoved(rootIntent: Intent?) {
        try {

            val notificationIntent = packageManager.getLaunchIntentForPackage(packageName)
            val pendingIntent = PendingIntent.getActivity(this, 0, notificationIntent, PendingIntent.FLAG_IMMUTABLE)

            val defaultIconResId =
                packageManager.getApplicationInfo(packageName, 0).icon

            val iconResId = if (icon != null) {
                val resId = resources.getIdentifier(
                    icon,
                    "mipmap",
                    packageName
                )
                if (resId != 0) resId else defaultIconResId
            } else {
                defaultIconResId
            }

            val notificationBuilder = NotificationCompat.Builder(this, "com.dolev.notification_when_app_is_killed")
                .setSmallIcon(iconResId)
                .setContentTitle(title)
                .setContentText(description)
                .setAutoCancel(true)
                .setPriority(NotificationCompat.PRIORITY_MAX)
                .setCategory(NotificationCompat.CATEGORY_ERROR)
                .setContentIntent(pendingIntent)
                .setSound(Settings.System.DEFAULT_NOTIFICATION_URI)
                .setVisibility(NotificationCompat.VISIBILITY_PUBLIC)

            val name = "Alarm notification service on application kill"
            val descriptionText = "If an alarm was set and the app is killed, a notification will show to warn the user the alarm will not ring as long as the app is killed"
            val importance = NotificationManager.IMPORTANCE_HIGH
            val channel = NotificationChannel("com.dolev.notification_when_app_is_killed", name, importance).apply {
                description = descriptionText
            }

            // Register the channel with the system
            val notificationManager: NotificationManager =
                getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager
            notificationManager.createNotificationChannel(channel)
            notificationManager.notify(123, notificationBuilder.build())
        } catch (e: Exception) {
            Log.d("NotificationOnKillService", "Error showing notification", e)
        }
        super.onTaskRemoved(rootIntent)
    }

    override fun onBind(intent: Intent?): IBinder? {
        return null
    }
}
