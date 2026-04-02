# 🔐 SoftLab Auth

A complete **Flutter authentication flow** built with **BLoC state management**, featuring a clean event-driven architecture migrated from GetX.

---

## 📱 Screens

| Screen | Description |
|---|---|
| Splash | Auto-redirect based on session state |
| Onboarding | First-time user introduction slides |
| Login | Email & password with validation |
| Register (Multi-step) | 4-step registration flow |
| Forgot Password | Send OTP to email |
| Verify OTP | OTP verification screen |
| Reset Password | Update new password |
| Registration Complete | Success confirmation screen |

---

## 🏗️ Architecture

```
lib/
└── features/
    ├── splash/
    ├── onboarding/
    └── auth/
        ├── bloc/
        │   ├── auth_bloc.dart
        │   ├── auth_event.dart
        │   └── auth_state.dart
        └── screens/
            ├── login/
            ├── register/
            └── reset_password/
```

### State Management — BLoC Pattern

```
User Action → Event → AuthBloc → State → UI Update
```

**Events**
- `LoginSubmitted` — email & password
- `RegisterSubmitted` — multi-step registration data
- `SendOtpRequested` — forgot password OTP
- `OtpVerified` — OTP verification
- `ResetPasswordSubmitted` — new password

**States**
- `AuthInitial` — default
- `AuthLoading` — API call in progress
- `AuthSuccess` — API success
- `AuthFailure` — API error
- `AuthValidationError` — form validation error

---

## 🛠️ Tech Stack

| | |
|---|---|
| Framework | Flutter |
| Language | Dart |
| State Management | BLoC / flutter_bloc |
| HTTP | http |
| Local Storage | SharedPreferences |
| UI Utilities | flutter_screenutil, keyboard_actions |

---

## 🚀 Getting Started

### Prerequisites
- Flutter SDK `^3.7.0`
- Dart SDK `^3.7.0`

### Installation

```bash
# Clone the repo
git clone https://github.com/nareshgupta99/softlab_auth.git

# Navigate to project
cd softlab_auth

# Install dependencies
flutter pub get

# Run the app
flutter run
```

---

## 📦 Dependencies

```yaml
flutter_bloc: ^9.1.1
bloc: ^9.2.0
http: ^1.6.0
shared_preferences: ^2.5.3
flutter_screenutil: ^5.9.3
keyboard_actions: ^4.2.1
device_info_plus: ^12.3.0
```

---

## 🔄 Migration — GetX → BLoC

This project was migrated from GetX to BLoC. Key changes:

| GetX | BLoC |
|---|---|
| `GetxController` | `Bloc<Event, State>` |
| `isLoading.obs` | `AuthLoading` state |
| `Get.toNamed()` | `Navigator.pushNamed()` |
| `Obx(() => ...)` | `BlocBuilder` |


---

## 👤 Author

**Naresh Gupta**  
[linktr.ee/nareshgupta99](https://linktr.ee/nareshgupta99)  
nareshgupta0899@gmail.com
