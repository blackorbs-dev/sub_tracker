# 📱 Smart Subscription Tracker App

A Flutter application that simulates subscription management with authentication, biometric login, wallet billing, notifications, and location-based history — built using **Clean Architecture** and **feature-based structure**.

---

## ⚙️ Setup & Installation

1. **Clone the repository**
```
git clone https://github.com/blackorbs-dev/sub_tracker.git
cd sub_tracker
```

2. **Get dependencies**
```
flutter pub get
```

3. **Run with Google Maps API key**
```
flutter run --dart-define MAPS_API_KEY="YOUR_GOOGLE_MAPS_API_KEY"
```

---

## 🔑 Testing Biometric Login
1. Ensure biometrics are enabled on your device/emulator.
2. On login, tap **Biometric Login**.
3. Authenticate with your saved fingerprint or Face ID.

---

## 🔔 Testing Notifications
1. Subscribe to a plan.
2. Toggle **Dark Mode** → simulates 1 day passing.
3. Notifications appear when subscription nears expiry or fails renewal.
4. Tap the notification to navigate back into the app.

---

## 🎥 Demo Video

[![Watch the demo](assets/screenshots/demo-thumbnail.png)](https://drive.google.com/file/d/1nzIiTaicC4u0XVI2jHVMWd-_yrk2Qp-x/view?usp=sharing)

---

## 📸 Screenshots

### Mobile (iPhone 16 Simulator)
<div style="display: flex; overflow-x: auto; gap: 10px; padding: 10px;">
    <img src="assets/screenshots/login-iphone.png" alt="Mobile Dashboard" width="350"/> 
    <img src="assets/screenshots/dashboard-iphone.png" alt="Mobile Dashboard" width="350"/> 
    <img src="assets/screenshots/wallet-iphone.png" alt="Mobile Dashboard" width="350"/> 
    <img src="assets/screenshots/subscribe-iphone.png" alt="Mobile Dashboard" width="350"/> 
    <img src="assets/screenshots/map-iphone.png" alt="Mobile Dashboard" width="350"/>
</div>

### Tablet (Pixel Emulator Api 34)
<div style="display: flex; overflow-x: auto; gap: 10px; padding: 10px;">
    <img src="assets/screenshots/login-tablet.png" alt="Tablet Dashboard" width="650"/>
    <img src="assets/screenshots/dashboard-wallet-tablet.png" alt="Tablet Dashboard" width="650"/>
    <img src="assets/screenshots/dashboard-subscribe-tablet.png" alt="Tablet Dashboard" width="650"/>
</div>
---

## 📜 Background Task Logs

Console logs show background simulation activity:

```
D/WM-WorkerWrapper(11267): Starting work for dev.fluttercommunity.workmanager.BackgroundWorker
D/WM-SystemJobService(11267): onStartJob for WorkGenerationalId(workSpecId=cc0fc086-6559-45ce-846e-ac5721596490, generation=0)
D/WM-Processor(11267): Work WorkGenerationalId(workSpecId=cc0fc086-6559-45ce-846e-ac5721596490, generation=0) is already enqueued for processing
D/WM-SystemJobScheduler(11267): Scheduling work ID cc0fc086-6559-45ce-846e-ac5721596490Job ID 7
D/WM-SystemJobService(11267): onStopJob for WorkGenerationalId(workSpecId=cc0fc086-6559-45ce-846e-ac5721596490, generation=0)
I/WM-WorkerWrapper(11267): Worker result SUCCESS for Work [ id=baad0a27-7746-4267-a9c6-723065cb3466, tags={ dev.fluttercommunity.workmanager.BackgroundWorker } ]
D/WM-Processor(11267): Processor baad0a27-7746-4267-a9c6-723065cb3466 executed; reschedule = false
D/WM-SystemJobService(11267): baad0a27-7746-4267-a9c6-723065cb3466 executed on JobScheduler
D/WM-GreedyScheduler(11267): Cancelling work ID baad0a27-7746-4267-a9c6-723065cb3466
```
