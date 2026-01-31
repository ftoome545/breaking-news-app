📰 Breaking News App

A Flutter news application that delivers the latest headlines with a clean UI, theme customization, authentication, and daily push notifications.
This app was built to showcase Flutter architecture, state management, and Firebase integration.

🚀 Features

🔐 Authentication

User sign in / sign up

User profile with default avatar

📰 Latest News

Real-time news fetched from NewsData.io API

Clean and readable news cards

🌙 Light & Dark Theme

Theme switching using Provider

🔔 Daily Push Notifications

Sends daily news notifications using Firebase Cloud Messaging

💾 Saved News

Bookmark articles for later reading

🧠 Clean Architecture

Separation of UI, state, and data layers

🧩 Tech Stack

Flutter

Provider – State management

Firebase Authentication

Cloud Firestore

Firebase Cloud Messaging (FCM)

REST API

NewsData.io API

📦 State Management

The app uses Provider for managing application state in a scalable and readable way.

Providers used in this project:

Theme Provider

Handles light & dark mode switching

Auth Provider

Manages authentication state and user data

News Provider

Handles fetching, caching, and updating news data from the API

This approach keeps the UI clean and reactive while separating business logic from presentation.

🔔 Push Notifications

Daily notifications are sent using Firebase Cloud Messaging (FCM).

Users receive daily breaking news notifications

Push notifications are integrated without server-side code

Designed to enhance user engagement

📰 News API

News data is fetched from:

🔗 https://newsdata.io/

The API is used to:

Fetch latest news articles

Display headlines with images, titles, and descriptions

Keep content fresh and updated

🖼️ User Avatar Decision

For this project, default local avatars are used instead of user-uploaded profile images.

Why?

This app is a portfolio showcase

Avoids unnecessary backend complexity and billing requirements

The architecture is designed so avatar uploads can be added later using Firebase Storage or any external CDN without changing the Firestore schema

This decision was made intentionally to keep the project simple, efficient, and cost-free while still demonstrating strong architectural skills.

🏗️ Project Structure

The project follows a feature-based structure, keeping related logic together:

lib/
 ├── features/
 │   ├── auth/
 │   ├── home/
 │   ├── news/
 │   └── profile/
 ├── shared/
 ├── routes/
 └── main.dart


This structure improves scalability and maintainability as the app grows.

🎯 Purpose of the Project

This application was built to:

Demonstrate real-world Flutter development skills

Show clean state management using Provider

Integrate Firebase services effectively

Build a production-like app with thoughtful technical decisions

📌 Future Improvements

Article search & filtering

News categories

Multi-language support

Remote avatar uploads

Offline caching

👩‍💻 Author

Fatima Hure
Flutter Developer