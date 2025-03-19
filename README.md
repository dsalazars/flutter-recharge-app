# 📱 Flutter Recharge App

A mobile application for managing mobile recharges using Flutter. This app integrates with the Puntored API, uses SQLite for local storage, and manages state using Riverpod.

## 🚀 Features

- **User Authentication**: Login using Puntored API credentials.
- **Mobile Recharge**: Perform mobile recharges with available suppliers.
- **Transaction History**: Display the latest successful recharges from local storage.
- **State Management**: Powered by Riverpod.
- **Database**: SQLite for saving recharge history.
- **API Integration**: Consumes Puntored API for authentication, suppliers, and recharges.

## 📋 Prerequisites

Ensure you have the following installed:

- **Flutter** (Latest Stable Version): [Install Flutter](https://docs.flutter.dev/get-started/install)
- **Dart**: Included with Flutter
- **IDE**: Visual Studio Code or Android Studio (recommended)

## 🛠️ Setup Instructions

1. **Clone the repository:**

```bash
https://github.com/dsalazars/flutter-recharge-app.git
cd flutter-recharge-app
```

2. **Install dependencies:**

```bash
flutter pub get
```

3. **Configure Launcher Icon (Optional):**

Ensure the app icon is located at `utils/resources/icon.png`.

Run the following command:

```bash
flutter pub run flutter_launcher_icons:main
```

## ▶️ Run the App

1. Ensure a device or emulator is running:

```bash
flutter devices
```

2. Start the app:

```bash
flutter run
```

## 📊 API Integration

This app integrates with the Puntored API for managing mobile recharges.

### 1. Authentication

**Endpoint:** `/auth`

- **Method:** POST
- **Headers:**
  ```
  x-api-key: YOUR_API_KEY
  ```
- **Body:**

```json
{
  "user": "user",
  "password": "password"
}
```

- **Response:**

```json
{
  "token": "Bearer YOUR_TOKEN"
}
```

### 2. Get Suppliers

**Endpoint:** `/getSuppliers`

- **Method:** GET
- **Headers:**
  ```
  authorization: Bearer YOUR_TOKEN
  ```

- **Response:**

```json
[
  { "id": "8753", "name": "Claro" },
  { "id": "9773", "name": "Movistar" },
  { "id": "3398", "name": "Tigo" },
  { "id": "4689", "name": "WOM" }
]
```

### 3. Perform Recharge

**Endpoint:** `/buy`

- **Method:** POST
- **Headers:**
  ```
  authorization: Bearer YOUR_TOKEN
  ```

- **Body:**

```json
{
  "supplierId": "8753",
  "cellPhone": "3112222222",
  "value": 10000
}
```

## 📌 Additional Commands

- **Clean project:**

```bash
flutter clean
flutter pub get
```

- **Check for issues:**

```bash
flutter doctor
```


