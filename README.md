<div align="center">
  <h1 style="font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;">🎵 <span style="color:#8A2BE2;">AuraTune</span> v2 - Your AI-Powered Musical DNA</h1>

  <p style="font-size:1.1rem; color:#444; max-width:900px; line-height:1.5;">
    Discover Your Musical DNA &amp; Get AI-Powered Recommendations
  </p>

  <p>
    <a href="https://auratune.shivamyadav.com.np">🌐 Live Demo</a>
    &nbsp; | &nbsp;
    <a href="IMPLEMENTATION_GUIDE.md">📚 Full Implementation Guide</a>
    &nbsp; | &nbsp;
    <strong>🚀 Get Started</strong>
  </p>
</div>

---

## 📚 About This Project

Hey there! I'm **Shivam Yadav**, a 1st semester CSE student at Chandigarh University. This academic project demonstrates the power of Python's data science stack (NumPy &amp; Pandas) to build a real-world application.

AuraTune analyzes your Spotify listening habits to generate a personalized "Musical Aura." In v2, AuraTune integrates the Google Gemini API to provide dynamic, AI-powered book and Bollywood movie recommendations that match your unique music vibe.

---

## 🎯 Project Goals

- Demonstrate practical application of NumPy for numerical analysis and Pandas for data manipulation.
- Integrate a Large Language Model (Google Gemini) for intelligent, personalized recommendations.
- Build a modern full-stack app with Flutter (frontend) and Appwrite (serverless backend).
- Explore data scaling: Pandas vs PySpark.

---

## ✨ Key Features

- 🎧 Personalized Aura Analysis — Securely analyzes your top Spotify tracks' audio features (energy, danceability, valence, etc.).
- 🤖 AI-Powered Recommendations — Google Gemini generates books & Bollywood movie suggestions based on your musical personality.
- 📈 Data-Driven Insights — NumPy &amp; Pandas power the cleaning, processing, and creation of your "Aura Vector." 
- 📊 Beautiful Visualization — A clean radar chart (Fl\_chart) displays your musical DNA in the Flutter app.
- ☁️ Serverless Architecture — Appwrite Cloud handles auth, database, and serverless Python functions.

---

## 🏗️ Architecture (v2)

This diagram shows the flow of data from the user to the AI and back.

```mermaid
graph TD
    A[User 👤] -->|Logs in| B(Flutter Web App);
    B -->|Authenticates| C[Appwrite Auth];
    C -->|On Success| B;
    B -->|Requests Analysis| D[Appwrite Function: analyze-aura];
    D -->|Get Tracks| E[Spotify Web API 🎧];
    E -->|Track Data| D;
    D -->|Process Data| F[Python Runtime: NumPy & Pandas];
    F -->|Aura Vector| D;
    D -->|Get AI Recs| G[Google Gemini API 🤖];
    G -->|Recommendations| D;
    D -->|Save Profile| H[Appwrite Database 💾];
    D -->|Returns (Aura + Recs)| B;
    B -->|Displays Results| A;
```

---

## 🧠 How Python's Data Stack Powers This

1) Pandas — The Data Organizer

- Loads Spotify JSON into DataFrames for easy selection of audio features.
- Handles missing data (dropna, fillna) and aggregation (groupby, mean).

2) NumPy — The Numerical Engine

- Vectorized operations produce the final "Aura Vector" quickly (mean, std, normalization).

3) Beyond Pandas: Scaling with PySpark

- Pandas is single-machine; PySpark enables distributed processing for massive scaling (1TB+).

<details>
<summary><b>Click to see Real-World Applications of this Tech</b></summary>

- 🎥 Netflix &amp; YouTube: Watch-history analysis and recommendations.
- 🛒 Amazon &amp; Flipkart: Product recommendations using purchase/browse history.
- 📱 Facebook &amp; Instagram: Feed personalization using like/share/watch time data.

</details>

---

## 🛠️ Technology Stack (v2)

| Category | Technology | Purpose |
|---|---|---|
| Frontend | Flutter Web | Responsive cross-platform UI |
| Visualization | fl_chart | Radar chart for Aura visualization |
| Backend | Appwrite Cloud | Auth, DB, Serverless Functions |
| Data & AI | Python 3.10 | Backend logic and functions |
|  | NumPy | Numerical computations |
|  | Pandas | Data cleaning & aggregation |
|  | Google Gemini | AI-powered recommendations |
|  | PySpark | Scaling to big data (optional) |
|  | Spotipy | Spotify Web API integration |
| DevOps | GitHub Actions | CI/CD |
| Hosting | GitHub Pages | Hosting Flutter web app |

---

## 🚀 Get Started (Quick)

This project is split into two parts: the Flutter frontend and the Appwrite serverless backend.

Prerequisites

- Flutter SDK (3.19.0+)
- Python 3.10+
- Appwrite CLI (for deploy)
- Spotify Developer account, Appwrite Cloud account, Google AI Studio account

Quick backend (Python function) setup example:

```bash
# create virtualenv
python3.10 -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt  # contains spotipy, pandas, numpy, google-ai-lib (example)

# run unit tests (if any)
pytest -q
```

Flutter frontend (dev):

```bash
flutter pub get
flutter run -d chrome
```

For a complete step-by-step guide to deploy and configure Appwrite, Spotify, and Google Gemini, see:

➡️ View the Full IMPLEMENTATION_GUIDE.md

---

## 🎓 Academic Context

- Student: **Shivam Yadav**
- Program: B.E. - Computer Science &amp; Engineering
- Semester: 1st
- Institution: Chandigarh University

This project demonstrates practical data science concepts from early coursework using a real-world API and simple AI integration.

---

## 🤝 Contributing

Contributions and feedback are welcome!

1. Fork the repository
2. Create a feature branch: `git checkout -b feature/NewAnalysis`
3. Commit your changes: `git commit -m 'Add new feature'`
4. Push: `git push origin feature/NewAnalysis`
5. Open a Pull Request

---

## 📞 Contact & Connect

**Shivam Yadav**

- 🎓 1st Semester CSE Student at Chandigarh University 🇳🇵 Nepal
- 🎂 Birthday: August 21

Project Demo: https://auratune.shivamyadav.com.np

Email: people@shivamyadav.com.np

<div align="center">
⭐ Star this repository if you found the NumPy, Pandas, and AI implementation helpful!
</div>

---

Thank you for checking out AuraTune 🎵 — built with passion, curiosity, and data.

---

License: MIT
