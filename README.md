# Flutter E-commerce Poc app

## Table of Contents
1. [Getting Started](#getting-started)
2. [How to Run](#how-to-run)
    - [Clone](#clone)
    - [Android](#android)
    - [iOS](#ios)
    - [Web](#web)
3. [Folder Structure](#folder-structure)
4. [Screenshots & Screen Records](#screenshots--screen-records)

---

## Getting Started
To get started with the app, ensure you have the following prerequisites installed:

- Flutter SDK (version 3.x or higher)
- Android Studio or Xcode for Android/iOS development
- Google Chrome (for web development)

## How to Run
Clone:
```bash
git clone https://github.com/AhmedAbdEllatiif/ecommerce-poc.git
cd /ecommerce_poc
```

Android:
- Connect an Android device or start an Android Emulator.
- Run the following command in the terminal
```bash
flutter run
```

iOS:
- Connect an iOS device or start the iOS Simulator.
- Ensure that Xcode is installed and set up.
- Run the following command in the terminal
```bash
flutter run
```

Web:
```bash
flutter run -d chrome
```

## Folder Structure
```bash
lib/
├── base/
│   ├── base_material.dart         # Common configurations and themes for the app.
│   └── main.dart                  # Entry point of the application.
├── domain/
│   └── entities/
│       └── order_insight_entity.dart  # Data structure for managing order insights.
├── logic/
│   └── load_orders/
│       ├── load_orders_cubit.dart    # Business logic for loading orders using Cubit.
│       └── load_orders_state.dart    # States associated with the LoadOrders Cubit.
├── presentation/
│   ├── components/
│   │   └── app_text.dart            # Shared widget for displaying styled text.
│   ├── journey/
│   │   ├── home_screen/             # Contains all files related to the Home Screen.
│   │   └── orders_graph/            # Contains all files related to the Orders Graph.
├── resources/                       # Placeholder for static assets (e.g., colors, fonts).
└── widgets/                         # Shared or reusable widgets across the app.
```

## Screenshots & Screen Records

Screen Records:
[Find app screen records](https://drive.google.com/file/d/1s-5ZZvJ99JilcHZEcJR4FGsn0KARN6dC/view?usp=sharing)

Screenshots:
<img width="1533" alt="Screenshot 2024-12-07 at 1 03 41 PM" src="https://github.com/user-attachments/assets/b97d9cd4-404a-491a-a822-8d396045da89">
<img width="1525" alt="Screenshot 2024-12-07 at 1 04 34 PM" src="https://github.com/user-attachments/assets/68499c00-89e8-4ada-92a0-d4d0457f1c72">
<img width="1710" alt="Screenshot 2024-12-07 at 1 05 14 PM" src="https://github.com/user-attachments/assets/89932b71-49c4-4f69-8507-b3fd9eb733e5">
<img width="1710" alt="Screenshot 2024-12-07 at 1 05 23 PM" src="https://github.com/user-attachments/assets/134e9147-bea1-4784-b2be-0664efcca419">
<img width="612" alt="Screenshot 2024-12-07 at 1 07 52 PM" src="https://github.com/user-attachments/assets/4d16b574-19a1-4e61-a53e-f35e34e94c80">
