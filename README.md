# ExpenseEcho

A cross-platform personal finance app built with Flutter. Track expenses, income,
budgets, and transfers across multiple accounts, with offline-first local storage
and periodic cloud sync.

![Flutter](https://img.shields.io/badge/Flutter-Dart-blue)
![Platform](https://img.shields.io/badge/Platform-iOS%20%7C%20Android-lightgrey)
![License](https://img.shields.io/badge/License-MIT-green)

## Overview

ExpenseEcho helps users manage day-to-day finances from their phone. It records
expenses and income across multiple accounts, tracks budgets with configurable
alerts, and generates spending and saving insights. Data is stored locally with
SQLite for full offline access and synced to Firebase on a schedule for cloud
backup and cross-device consistency.

## Screenshots

<!-- Add screenshots here once ready:
![Home](screenshots/home.png)
![Insights](screenshots/insights.png)
-->

## Features

- **Authentication** — sign-up and login with user profiles (username, email, avatar).
- **Multiple accounts** — bank, credit card, and wallet accounts with real-time balance tracking.
- **Expense tracking** — log expenses with category, description, amount, and optional attachments; supports recurring expenses (daily, monthly, quarterly, yearly) with end dates.
- **Income tracking** — record income with the same detail and recurring options.
- **Fund transfers** — move money between accounts with automatic balance updates.
- **Budgets** — set category budgets with alerts at a chosen threshold or when limits are exceeded.
- **Financial insights** — spending and saving analytics to support better decisions.
- **Daily motivation** — a new financial quote each day.
- **Offline-first** — local SQLite storage for full offline use, with scheduled Firebase sync (every 12 hours) for cloud backup.

<!-- KEEP ONLY IF ACTUALLY IN THE CODE. If not, delete this section AND remove
     "Gemini API" from your portfolio. -->
## AI-powered insights (Gemini)

The app uses Google's Gemini API to [describe exactly what it does — e.g. generate
the daily financial quote / produce natural-language spending insights]. AI output
is reviewed and constrained before being shown to the user.

<!-- KEEP ONLY IF LOCALIZATION IS ACTUALLY IMPLEMENTED. Otherwise delete this line
     AND remove "Localization" from your portfolio. -->
- **Localization** — runtime multi-language support across the interface.

## Tech stack

- **Framework:** Flutter (Dart)
- **Local storage:** SQLite (transaction ledger), SharedPreferences (lightweight state)
- **Cloud:** Firebase (Firestore for sync, Authentication)
- **State management:** [confirm — BLoC / Provider / GetX]
- **Architecture:** offline-first, modular, repository pattern

## Architecture

ExpenseEcho is offline-first: every read is served from the local SQLite store and
every change is written locally first, then reconciled with Firebase on a scheduled
sync. This keeps the app fully usable without a connection and consistent across
devices once reconnected. Business logic is separated from the UI for testability
and long-term maintainability.

## Data models

| Model    | Key fields |
|----------|------------|
| User     | user_id, username, email, avatar_image_link, created_at, updated_at |
| Account  | id, name, type (bank / credit card / wallet), balance |
| Expense  | id, category, description, expenseAmount, repeated, frequency, end_after_date, attachmentLink, account_id, created_at, updated_at |
| Income   | id, category, description, incomeAmount, repeated, frequency, end_after_date, attachmentLink, account_id, created_at, updated_at |
| Budget   | budgetId, userId, expense_category, budgetAmount, receive_alert, alert_percentile, created_at, updated_at |
| Transfer | handled via paired account balance updates |

## Getting started

```bash
# Clone
git clone https://github.com/abdullahmurdana/expenseecho.git
cd expenseecho

# Install dependencies
flutter pub get

# Run
flutter run
```

**Configuration**
- Set up a Firebase project and add the config files (`google-services.json` / `GoogleService-Info.plist`). Enable Firestore and Authentication.
- [If AI is used] Add your Gemini API key to the app's environment configuration.

## Roadmap

- Push notifications for budget thresholds and sync status
- Multi-currency support with exchange-rate integration
- Export reports to PDF / CSV
- Additional analytics and charts

## Author

**Mohammed Abdullah Khan** - Flutter Developer
Portfolio: https://abdullahmurdana.github.io
LinkedIn: https://www.linkedin.com/in/abdullahmurdana

## License

Released under the MIT License. See [LICENSE](LICENSE) for details.
