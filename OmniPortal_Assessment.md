# OMNI-PORTAL ASSESSMENT REPORT
**Operator:** Rafael Solano
**Deadline:** April 5 @ 11:59 PM

## 🧨 PHASE 1 — AUTH BYPASS (SQLi)

* **Payload Used:** `' OR 1=1 --`

* **Result:**
Successfully bypassed the login portal using a SQL tautology injection.
 Authentication was bypassed without valid credentials, granting access to the user dashboard.-

## 🕷️ PHASE 2 — CLIENT-SIDE HIJACK (XSS)

* **Stored XSS Payload:**
`<script>alert(document.cookie);</script>`

* **Secret Cookie Captured:**
`auth_token=SUPPORT_TIER_1_SECRET_TOKEN`

* **Impact:**
The application failed to sanitize user input, allowing persistent 
JavaScript execution and exposure of session-level authentication data.


## 🔓 PHASE 3 — API ENUMERATION (BOLA)

* **Insecure Order ID:** `501`

* **Confidential Data Leaked:**
  - 💰 Amount: $15,000.00 
  - 📦 Details: Confidential Server Lease 

* **Impact:** 
Broken Object Level Authorization allowed unauthorized access to sensitive financial records by manipulating API object identifiers.


## 🛠️ PHASE 4 — THE REMEDIATION

* **Fix for SQLi:**  
Use parameterized queries (prepared statements) to ensure user input is treated strictly as data and never executed as SQL code.

* **Fix for XSS:**  
Implement context-aware output encoding and HTML escaping. Additionally enforce secure cookie attributes such as `HttpOnly`, `Secure`, and `SameSite`.

* **Fix for API BOLA:**  
Enforce strict server-side object-level authorization checks to ensure users can only access resources they own or are permitted to view.

## 🚨 SUMMARY

The system demonstrates a chained attack path:

**SQL Injection → Stored XSS → API BOLA**

This results in authentication bypass, session exposure, and unauthorized access
to confidential financial data due to missing input validation and authorization controls.
