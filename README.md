# ai-receipt-expense-tracker
# 🤖 AI-Powered Household Expense & Personal Finance Tracker (LINE Chatbot)

An automated personal finance and household expense tracking chatbot application on the LINE platform. Developed using **n8n**, it integrates **Google Gemini (AI/OCR)** and **Supabase (Vector Database)** to automatically extract transaction information from bank transfer slips and receipts, eliminating the need for manual data entry.

Users can simply upload a receipt image or type a text message, and the system will instantly extract the data, validate it, store it in a database, and answer natural language queries summarizing past expenses.

## ✨ Features

* 🧾 **Automated Receipt/Slip OCR:** Supports uploading receipt images or bank transfer slips. The system uses AI Vision to read and automatically extract key transaction information (Payer, Recipient, Date, Amount, Activity).
* ✍️ **Text-based Expense Logging:** Users can directly type messages to log expenses (e.g., "Coffee 65 THB"). The system extracts the data and saves it to the database.
* 📊 **RAG-powered Summary & Dashboards:** Supports natural language queries about past expenses (e.g., "What did I spend money on this month?"). It uses Vector Search to retrieve data from Supabase for AI summarization and dashboard visualization.
* 💬 **Financial Advice & General Chat:** Features an AI Agent that classifies user intent. If the user asks for financial advice or engages in general chat, the system assumes the role of a financial expert to respond.
* 🗂️ **Automated Validation:** Validates the extracted data before storing records to ensure accuracy and reduce human error.

## 🛠️ Technologies Used

* **Workflow Automation:** n8n (Advanced Workflow Orchestration)
* **Messaging Platform:** LINE Messaging API (Webhook & Reply)
* **AI & LLMs (Google Gemini API):**
* `gemini-flash-lite-latest`  (for Vision/OCR and Data Extraction Agent)
* `gemini-pro-latest` / `gemini-flash-lite-latest` (for RAG and Chat Agent)
* `gemini-embedding-001` (for Text Embeddings)


* **Database & Vector Store:** Supabase (PostgreSQL + pgvector) for storing transaction data as vectors.
* **Programming:** JavaScript, SQL, REST APIs.

## 🔄 Project Architecture & Workflow

### High-Level Workflow

```text
Upload Receipt / Send Text
      ↓
LINE Webhook Trigger
      ↓
Gemini Vision OCR / Intent Classification
      ↓
Extract & Validate Transaction Data
      ↓
Store in Supabase Vector Database
      ↓
LINE Reply / Expense Dashboard

```

### Detailed n8n Node Routing

1. **Trigger (`LINE Webhook3`):** Receives incoming messages from the LINE Official Account.
2. **Routing (`If6`):** Checks the message type.
* **If Image/File:**
* Retrieves the image file from LINE and processes it through OCR (`Analyze an image4`) to extract all visible text.
* Uses `Information Extractor3` to extract variables (Payer, Recipient, Date, Amount, Activity).
* Replies to the user to confirm the transaction (`HTTP Request9`).
* Embeds the data into vectors and saves it to Supabase (`Supabase Vector Store3`).


* **If Text:**
* Routes the message to `AI Agent6` (Financial AI Classifier) to categorize the intent into 4 types: `record_expense`, `view_summary`, `financial_advice`, or `general_chat`.
* ➡️ **`record_expense`:** Extracts data from the text, saves it to Supabase, and replies with a confirmation.
* ➡️ **`view_summary`:** Sends the request to `AI Agent4` to search data in Supabase (`Supabase Vecter Search3`) and summarize expenses.
* ➡️ **`financial_advice` / `general_chat`:** The AI assumes the role of a financial advisor and replies directly.





## 📋 Example OCR Output

When a user uploads a slip, the AI extracts the following structured JSON output:

| Field | Extracted Value |
| --- | --- |
| **Date** | 2026-05-15 |
| **Amount** | 350 THB |
| **Recipient** | Example Store |
| **Activity** | Lunch with team |

## 🔑 Prerequisites

To use this workflow, you need to configure the following credentials in your n8n instance:

* **LINE Messaging API:**
* `Header Auth account`: For connecting to the LINE API (using a Bearer Token).


* **Google AI Studio (Gemini):**
* `Google Gemini(PaLM) Api account`: For utilizing LLMs, Vision, and Embedding models.


* **Supabase:**
* `Supabase account`: API URL and Service Role Key.
* *Note: Requires a table named `documents2` configured to support Vector Embeddings.*



## 🚀 Installation Guide

1. Open your n8n instance/server.
2. Go to the Workflows page and click **Add Workflow**.
3. Select **Import from File** or paste the project's JSON code directly onto the canvas.
4. Go to each node displaying a ⚠️ warning icon and connect your prepared Credentials.
5. **Activate** the workflow and set up the Webhook URL in your LINE Developer Console.

## 👨‍💻 Author

**Pattarawit Naprajak**

*Computer Science Student*

Interested in Generative AI, AI Automation, OCR, and Intelligent Systems.

Video link 1 : https://youtube.com/shorts/YWz6Wvssqvc
Video link 2 : https://youtu.be/caqfiwRSNCM
