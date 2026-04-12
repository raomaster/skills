---
name: playwright-browser
description: Use when automating browser tasks with Playwright — navigation, clicks, form fills, screenshots, assertions, or network interception. Also triggers when debugging flaky browser tests or setting up Playwright in a new project.
---

# playwright-browser

Reference guide for browser automation with Playwright. Covers the most common patterns and their gotchas.

## Setup

Run `scripts/check-playwright.sh` to verify Playwright is installed before starting.

## Common Patterns

### Navigate and wait for page to settle
```javascript
await page.goto('https://example.com');
await page.waitForLoadState('networkidle');
```

### Click and fill using semantic selectors
```javascript
// Prefer role/label selectors over CSS — more resilient to UI changes
await page.getByRole('button', { name: 'Submit' }).click();
await page.getByLabel('Email').fill('user@example.com');
```

### Fill and submit a form
```javascript
await page.getByLabel('Username').fill('user');
await page.getByLabel('Password').fill('secret');
await page.getByRole('button', { name: 'Login' }).click();
await page.waitForURL('/dashboard');
```

### Take a screenshot
```javascript
await page.screenshot({ path: 'screenshot.png', fullPage: true });
```

### Assert content
```javascript
await expect(page.getByText('Welcome back')).toBeVisible();
await expect(page).toHaveTitle('Dashboard');
```

### Intercept network requests
```javascript
await page.route('**/api/data', route => {
  route.fulfill({ json: { items: [] } });
});
```

### Handle browser dialogs (alert/confirm)
```javascript
page.on('dialog', dialog => dialog.accept());
await page.getByText('Delete').click();
```

## Gotchas

- **Selectors rot**: CSS selectors break on UI changes. Use `getByRole`, `getByLabel`, `getByText` instead.
- **Race conditions**: Never use `sleep()` — use `waitForSelector`, `waitForResponse`, or `waitForURL`.
- **Auth state**: Use `storageState` to persist cookies/localStorage between test runs.
- **Headless vs headed**: Use `headless: true` in CI, headed locally for debugging.
- **Multi-tab flows**: Use `context.newPage()` for pages that open in new tabs.
- **Iframe content**: Use `frame.locator()` — page selectors don't pierce iframes.

## Running Tests

```bash
npx playwright test                          # Run all tests
npx playwright test --headed                 # With browser visible
npx playwright test tests/login.spec.ts      # Single file
npx playwright test --debug                  # Step-through debugger
npx playwright show-report                   # HTML report after run
```
