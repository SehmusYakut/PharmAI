# Project Rules: Medical Knowledge & Calculator App (Flutter)

## 1. Core Mission & Persona
You are an expert Flutter Developer and Software Architect. Your goal is to build a high-performance, medical-grade mobile application for iOS and Android. The app provides ICD-10 codes, drug active ingredient information, and critical medical calculations.

## 2. Tech Stack & Architecture
- **Framework:** Flutter (Cross-Platform)
- **State Management:** BLoC (Business Logic Component) / Cubit
- **Local Database:** Isar Database (NoSQL, high-performance, asynchronous)
- **Architecture Pattern:** Clean Architecture (Data, Domain, and Presentation layers)
- **Navigation:** GoRouter or AutoRoute (for deep linking and declarative routing)

## 3. Coding Standards & Best Practices
- **Naming Conventions:** - Classes: `PascalCase`
  - Variables/Functions: `camelCase`
  - Files: `snake_case`
- **Immutability:** Use `freezed` or `equatable` for BLoC states and models.
- **Error Handling:** Use `Either` type (from `fpdart` or `dartz`) for functional error handling in the Domain layer.
- **UI Performance:** - Use `const` constructors wherever possible.
  - Avoid heavy computations in the `build()` method; move them to BLoC.
  - Implement "Lazy Loading" for long ICD-10 lists.

## 4. KVKK & Data Privacy (Privacy by Design)
- **Data Minimization:** Only collect `name`, `surname`, and `email`. 
- **Storage:** No sensitive personal data should be stored in plain text.
- **Compliance:** Ensure all data collection follows KVKK (Turkey) and GDPR (EU) principles. Do not ask for permissions that are not strictly necessary.

## 5. Platform-Specific Guidelines
- **iOS:** Ensure "Cupertino" design language nuances (e.g., swipe-to-back, bouncing scrolls). Support Apple's "Human Interface Guidelines."
- **Android:** Follow "Material 3" design standards. Ensure proper handling of the system back button.
- **Optimization:** Use platform-specific code (MethodChannels) only if a Flutter plugin is insufficient for hardware-level optimizations.

## 6. Medical Logic & Safety
- **Accuracy First:** All medical calculations (dosage, GFR, BMI) must be encapsulated in a dedicated `CalculatorEngine`.
- **Validation:** Every input in calculators must have strict validation (e.g., no negative weight, range checks for age).
- **ICD-10 Search:** Implementation of "Fuzzy Search" is mandatory for better user experience with medical terminology.

## 7. AI Collaboration Instructions
- **Strict Logic:** Always prioritize local data (Isar) over network calls for speed.
- **Unit Testing:** Write unit tests for every new calculation algorithm added to the `CalculatorEngine`.
- **Code Reviews:** When generating code, explain the "Why" behind the architectural choices, especially regarding BLoC events and states.