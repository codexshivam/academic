<div align="center">
  <h1 style="font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;">🎵 <span style="color:#8A2BE2;">AuraTune</span> v2 - Your AI-Powered Musical DNA</h1>

  <p style="font-size:1.1rem; color:#444; max-width:900px; line-height:1.5;">
    Discover Your Musical DNA &amp; Get AI-Powered Recommendations
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
  A[User 👤] -->|Logs in| B(Flutter Web App)
  B -->|Authenticates| C[Appwrite Auth]
  C -->|On Success| B
  B -->|Requests Analysis| D[Appwrite Function: analyze-aura]
  D -->|Get Tracks| E[Spotify Web API 🎧]
  E -->|Track Data| D
  D -->|Process Data| F[Python Runtime: NumPy & Pandas]
  F -->|Aura Vector| D
  D -->|Get AI Recs| G[Google Gemini API 🤖]
  G -->|Recommendations| D
  D -->|Save Profile| H[Appwrite Database 💾]
  D -->|Returns (Aura & Recs)| B
  B -->|Displays Results| A
```

---

## 🧠 How Python's Data Stack Powers This

1) Pandas — The Data Organizer

- Loads Spotify JSON into DataFrames for easy selection of audio features.
# 🎵 AuraTune v2 — Your AI-Powered Musical DNA

<div align="center">

Discover your Musical DNA & get AI-powered recommendations right in your terminal.

An Academic Project by **Shivam Yadav** showcasing Python's Data Science Stack

<p>
[![Implementation Guide](https://img.shields.io/badge/Implementation_Guide-F02E65?style=for-the-badge&logo=book&logoColor=white)](IMPLEMENTATION_GUIDE.md)
[![GitHub Repo](https://img.shields.io/badge/GitHub_Repo-181717?style=for-the-badge&logo=github&logoColor=white)](https://github.com/codexshivam/auratune)
</p>

<p>
![Python](https://img.shields.io/badge/Python-3776AB?style=for-the-badge&logo=python&logoColor=white)
![NumPy](https://img.shields.io/badge/NumPy-013243?style=for-the-badge&logo=numpy&logoColor=white)
![Pandas](https://img.shields.io/badge/Pandas-150458?style=for-the-badge&logo=pandas&logoColor=white)
![Spotipy](https://img.shields.io/badge/Spotipy-1DB954?style=for-the-badge&logo=spotify&logoColor=white)
![Rich](https://img.shields.io/badge/Rich-FF00FF?style=for-the-badge&logo=python&logoColor=white)
![Gemini AI](https://img.shields.io/badge/Gemini_AI-4285F4?style=for-the-badge&logo=google&logoColor=white)
</p>

</div>

---

## 📚 About This Project

Hey there! I'm **Shivam Yadav**, a 1st semester CSE student at Chandigarh University. AuraTune is a local Python CLI that analyzes your Spotify listening habits to generate a personalized "Musical Aura." v2 adds Google Gemini for dynamic, AI-powered book and Bollywood movie recommendations that match your music vibe — displayed beautifully in your terminal using Rich.

## 🎯 Project Goals

- Demonstrate NumPy for numerical analysis and Pandas for data manipulation.
- Integrate a Large Language Model (Google Gemini) for personalized recommendations.
- Provide a clean, user-friendly CLI experience using Python and Rich.
- Explore scaling options: Pandas vs PySpark.

## ✨ Key Features

- 🎧 Personalized Aura Analysis: Analyze audio features (energy, danceability, valence, etc.) from your top Spotify tracks.
- 🤖 AI Recommendations: Gemini-based book & Bollywood movie suggestions tailored to your musical aura.
- 📈 Data-Driven Insights: NumPy + Pandas for cleaning, aggregation, and vectorized analysis.
- 📊 Beautiful Terminal UI: Rich-powered CLI output and colored summaries.

---

## 🛠️ Technology Stack (v2)

Core Logic

- Python 3.10 — Core runtime
- NumPy — Numerical computations
- Pandas — Data cleaning & aggregation
- Google Gemini — AI-powered recommendations
- PySpark — Optional for large-scale processing

API & UI

- Spotipy — Spotify Web API integration
- Rich — Beautiful terminal formatting (tables, panels, colors)

---

## 🚀 Get Started (Quick)

This project runs as a single Python script on your local machine.

Prerequisites

- Python 3.10+
- Spotify Developer account (client id & secret)
- Google AI Studio / Gemini API key

Quick setup

```bash
# 1. (Optional) clone the repo
git clone https://github.com/codexshivam/auratune.git
cd auratune

# 2. create & activate virtualenv
python3.10 -m venv .venv
source .venv/bin/activate

# 3. install deps
pip install -r requirements.txt

# 4. set required environment variables (example)
export SPOTIPY_CLIENT_ID="your_spotify_client_id"
export SPOTIPY_CLIENT_SECRET="your_spotify_client_secret"
export SPOTIPY_REDIRECT_URI="http://localhost:8888/callback"
export GEMINI_API_KEY="your_gemini_api_key"

# 5. run the CLI (example)
python3 main.py --help
python3 main.py analyze --top 50
```

See `IMPLEMENTATION_GUIDE.md` for a full step-by-step configuration and deployment guide.

---

## 🎓 Academic Context

- Student: **Shivam Yadav**
- Program: B.E. - Computer Science &amp; Engineering
- Semester: 1st
- Institution: Chandigarh University

---

## 🤝 Contributing

Contributions are welcome — fork, branch, push, and open a PR. See the contribution steps in this repo.

---

## 📞 Contact

- Email: people@shivamyadav.com.np
- Demo: https://auratune.shivamyadav.com.np

<div align="center">
[![GitHub](https://img.shields.io/badge/GitHub-181717?style=for-the-badge&logo=github&logoColor=white)](https://github.com/codexshivam)
[![LinkedIn](https://img.shields.io/badge/LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white)](https://linkedin.com/in/ycsxshivam)
[![Instagram](https://img.shields.io/badge/Instagram-E4405F?style=for-the-badge&logo=instagram&logoColor=white)](https://instagram.com/ycs.shivam)
</div>

---

⭐ Star this repository if you found the NumPy, Pandas, and AI implementation helpful!

---

License: [MIT](LICENSE)
