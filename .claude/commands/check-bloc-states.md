# /check-bloc-states

Audit every BLoC state file in this Flutter project for compliance with the
PharmAI ProjectRules immutability requirements (§3 – Coding Standards).

If `$ARGUMENTS` is a file path, audit only that file.
Otherwise scan all files matching `lib/presentation/bloc/**/*_state.dart`.

---

## How to run the audit

**Step 1 — Discover files**

If `$ARGUMENTS` is non-empty and points to a specific file, read that file only.
Otherwise use Glob with pattern `lib/presentation/bloc/**/*_state.dart` to find
every state file, then read each one.

**Step 2 — For every file, evaluate all nine rules below**

Mark each rule **✅ PASS** or **❌ FAIL [reason]**.
For every FAIL write a concrete one-line fix suggestion directly below it.

**Step 3 — Print the structured report (format shown at the bottom)**

---

## Rules

### R1 · Immutability strategy (REQUIRED – choose exactly one)

**Equatable path** — all three must be present:
- `import 'package:equatable/equatable.dart'`
- Base state class extends `Equatable`
- No `@freezed` annotation anywhere in the file

**Freezed path** — all four must be present:
- `import 'package:freezed_annotation/freezed_annotation.dart'`
- `part '…freezed.dart';` directive
- `@freezed` annotation on at least one class
- Factory constructors using the `= _$ClassName` redirect syntax

If neither path is fully established → ❌ FAIL.
If both paths are mixed in the same file → ❌ FAIL (pick one).

---

### R2 · Sealed or abstract base class

The root state class must be declared with one of:
- `sealed class`  ← preferred (exhaustive switch at compile time)
- `abstract class` with `@freezed`

A bare `class BaseFooState extends Equatable` with no `sealed`/`abstract`
modifier → ❌ FAIL. Suggest adding `sealed`.

---

### R3 · Const constructors on every concrete subclass

Every concrete (non-abstract, non-sealed) state class must declare a `const`
constructor.  A constructor body (anything other than `;`) is also a violation.

Check for:
- `const ClassName(…);`  ✅
- `ClassName(…);`        ❌
- `ClassName(…) { … }`  ❌

---

### R4 · All instance fields are final

Scan every field declaration inside each state class.
- `final T field`   ✅
- `T field`         ❌ (implicit `var`)
- `var field`       ❌
- `late T field`    ❌ (deferred initialisation breaks const-ability)

Static `const` fields are excluded from this rule.

---

### R5 · Props list covers every instance field (Equatable path only)

For each concrete state that overrides `get props`, count:
1. The number of **instance fields** declared in that class (not inherited).
2. The number of **items in the returned list literal** inside `get props`.

If count 1 ≠ count 2 → ❌ FAIL.
Also flag if any field name visible in the class body does NOT appear anywhere
in the props list (best-effort string search).

Skip this rule if the file uses the Freezed path (Freezed generates props).

---

### R6 · copyWith signature integrity

If `copyWith` is written manually (Equatable path):
- Every instance field of the class must appear as a nullable named parameter
  in `copyWith`.  A missing parameter means callers silently drop that field.
- The body must use `this.fieldName` (or the field name) as the fallback for
  every parameter: `param ?? this.field`.

If using Freezed, `copyWith` must NOT be written manually — Freezed generates
it.  A hand-written `copyWith` on a `@freezed` class → ❌ FAIL.

---

### R7 · No mutable default collection literals

A `final List<T> field = []` or `final Map<K,V> field = {}` in a state class
is a violation: two `const`-constructed states would share the same mutable
object.  The constructor should receive the collection from outside, not create
one as a default.

Flag any field whose declaration contains `= []`, `= {}`, or `= <T>[]`.

---

### R8 · Naming conventions (ProjectRules §3)

- **File name**: must end in `_state.dart`  (ensured by glob — note if violated)
- **Base class**: name must end in `State`
- **Every subclass**: name must end in `State`
- **File name prefix** should match the feature folder name
  (e.g. `icd10_search/icd10_search_state.dart` → class `Icd10SearchState` ✅)

---

### R9 · No business logic inside state classes

Allowed methods: `copyWith`, the `props` getter, and private helpers used only
by `copyWith`/`props`.

Any other public method or any method that calls a repository, use-case,
cubit, or async function → ❌ FAIL.
Business logic belongs in the Cubit/BLoC, not in the state.

---

## Report format

Print one block per file:

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📄  lib/presentation/bloc/icd10_search/icd10_search_state.dart
    Strategy : Equatable  |  Hierarchy : sealed class
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  ✅ R1  Equatable path fully established
  ✅ R2  Base class is `sealed`
  ✅ R3  All 4 concrete subclasses have const constructors
  ✅ R4  All fields are final (9 fields across 4 classes)
  ✅ R5  Props lists cover all fields (4/4 classes checked)
  ✅ R6  copyWith present on Icd10SearchLoaded – all 3 fields covered
  ✅ R7  No mutable default collection literals found
  ✅ R8  Naming: base=Icd10SearchState ✓, 4 subclasses all end in State ✓
  ✅ R9  No extra public methods beyond copyWith / props
```

If there are failures, show them like this:

```
  ❌ R3  FooBarLoading has no const constructor
         Fix: change `FooBarLoading({…});` → `const FooBarLoading({…});`

  ❌ R5  FooBarLoaded.props is missing field `pageSize`
         Fix: add `pageSize` to the props list → `[query, results, pageSize]`
```

End with a summary:

```
────────────────────────────────────────────────────────────
  SUMMARY: 2/2 files fully compliant  ✅
  (or)
  SUMMARY: 1/2 files fully compliant — 1 file needs attention ⚠️
────────────────────────────────────────────────────────────
```

---

## Important notes for the audit

- Be precise about line numbers when citing violations.
- A file that uses both Equatable AND Freezed annotations is always R1 FAIL.
- `List<T> results` inside a const constructor is fine as long as no default
  `= []` is used — do not flag it under R7.
- `sealed` is preferred over `abstract` for new code; flag `abstract` as a
  suggestion (not a hard fail) if no Freezed annotation is present.
- If the file is empty or has no state class at all, report it as ❌ INVALID.
