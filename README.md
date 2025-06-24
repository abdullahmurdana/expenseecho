Expense Tracker
A feature-rich, cross-platform mobile application built with Flutter to help users manage their finances seamlessly. The app allows users to track expenses, incomes, budgets, and account transfers while providing insightful analytics and motivational financial quotes. Data is stored locally using SQLite and synced with Firebase every 12 hours for secure cloud backup and cross-device consistency.
Features

User Authentication: Secure sign-up and login with user profiles (username, email, avatar, and timestamps).
Account Management: Create and manage multiple accounts (bank, credit card, wallet) with real-time balance tracking.
Expense Tracking: Log expenses with details like category, description, amount, and optional attachments. Support for recurring expenses (daily, monthly, quarterly, yearly) with customizable end dates.
Income Tracking: Record incomes with similar details and recurring options for consistent cash flow management.
Fund Transfers: Easily transfer funds between accounts with automatic balance updates.
Budget Management: Set budgets for specific expense categories with customizable alerts when spending reaches a defined percentile or exceeds limits.
Financial Insights: Generate detailed spending and saving analytics to help users make informed financial decisions.
Daily Motivation: Receive a new financial quote daily to inspire better money management.
Offline-First: Store data locally with SQLite for offline access, syncing to Firebase every 12 hours for cloud backup.

Tech Stack

Frontend: Flutter (Dart) for a responsive, cross-platform mobile UI.
Local Storage: SQLite for efficient offline data management.
Cloud Sync: Firebase for secure, periodic data synchronization.
Architecture: Modular and scalable design for maintainability and future enhancements.

Data Models

User: user_id, username, email, avatar_image_link, created_at, updated_at
Account: id, name, type (bank, credit card, wallet), balance
Expense: id, created_at, updated_at, category, description, expenseAmount, repeated (bool), frequency (if repeated), end_after_date, attachmentLink, account_id (foreign key)
Income: id, created_at, updated_at, category, description, incomeAmount, repeated (bool), frequency (if repeated), end_after_date, attachmentLink, account_id (foreign key)
Budget: budgetId, created_at, updated_at, userId (foreign key), expense_category, budgetAmount, receive_alert (bool), alert_percentile
Transfer: Facilitates fund movement between accounts (not explicitly modeled but supported via account balance updates).

Potential Enhancements

Push Notifications: Real-time alerts for budget thresholds or sync status.
Multi-Currency Support: Allow accounts to handle different currencies with exchange rate integration.
Export Reports: Generate and export financial reports in PDF or CSV formats.
Dark Mode: Enhance user experience with a customizable UI theme.

Getting Started

Clone the repository:git clone https://github.com/your-username/expense-tracker.git


Install Flutter and dependencies:flutter pub get


Configure Firebase:
Set up a Firebase project and add the configuration files to the app.
Enable Firestore and Authentication in the Firebase console.


Set up SQLite:
Ensure the SQLite plugin is configured for local storage.


Run the app:flutter run



Contributing
Contributions are welcome! Please open an issue or submit a pull request for bug fixes, features, or improvements.
License
This project is licensed under the MIT License. See the LICENSE file for details.
