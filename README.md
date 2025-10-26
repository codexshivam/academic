# 🎵 AuraTune (An AI Applications Project)

<div align="center">

✨ *Discover your Musical DNA and get AI-powered recommendations — right in your terminal!* ✨

**An Academic Project Showcasing Python’s Data Science & AI Stack**

---

<p align="center">
  <a href="IMPLEMENTATION_GUIDE.md">
    <img src="https://img.shields.io/badge/Implementation_Guide-D90429?style=for-the-badge&logo=book&logoColor=white" alt="Implementation Guide">
  </a>
  <a href="https://github.com/codexshivam/auratune">
    <img src="https://img.shields.io/badge/GitHub_Repo-181717?style=for-the-badge&logo=github&logoColor=white" alt="GitHub Repo">
  </a>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Python-3776AB?style=for-the-badge&logo=python&logoColor=white" alt="Python">
  <img src="https://img.shields.io/badge/NumPy-013243?style=for-the-badge&logo=numpy&logoColor=white" alt="NumPy">
  <img src="https://img.shields.io/badge/Pandas-150458?style=for-the-badge&logo=pandas&logoColor=white" alt="Pandas">
  <img src="https://img.shields.io/badge/Spotipy-1DB954?style=for-the-badge&logo=spotify&logoColor=white" alt="Spotipy">
  <img src="https://img.shields.io/badge/Rich-F37736?style=for-the-badge&logo=python&logoColor=white" alt="Rich">
  <img src="https://img.shields.io/badge/Gemini_AI-4285F4?style=for-the-badge&logo=google&logoColor=white" alt="Gemini AI">
</p>

</div>

---

## 📚 About This Project

**AuraTune** is a local Python CLI application that analyzes your **Spotify listening habits** to generate a personalized **“Musical Aura.”**  
Version 2 introduces **Google’s Gemini AI** for dynamic, AI-powered **book** and **Bollywood movie recommendations** that align with your music vibe — beautifully displayed in your terminal using the **Rich** library.

> 🎓 *Developed as part of my academic coursework.*

**Student:** Shivam Yadav  
**Program:** B.E. – Computer Science & Engineering  
**Semester:** 1st  
**Institution:** Chandigarh University  

---

## 🎯 Project Goals

- 🧮 Demonstrate **NumPy** for numerical analysis and **Pandas** for data manipulation.  
- 🤖 Integrate **Google Gemini AI** for contextual, personalized recommendations.  
- 💻 Provide a clean, interactive CLI experience using **Rich**.  
- ⚙️ Explore scalable data processing by comparing **Pandas vs PySpark**.

---

## ✨ Key Features

| Feature | Description |
|----------|-------------|
| 🎧 **Personalized Aura Analysis** | Analyzes your top Spotify tracks based on features like energy, danceability, valence, and tempo. |
| 🤖 **AI Recommendations** | Uses Gemini to suggest books and Bollywood movies that match your unique “musical aura.” |
| 📈 **Data-Driven Insights** | Leverages NumPy and Pandas for efficient data aggregation and feature analysis. |
| 📊 **Beautiful Terminal UI** | Built using the Rich library for colorful tables, panels, and vibrant output. |
| 🌐 **Scalable Exploration** | Experimental PySpark integration for handling large-scale music datasets. |

---

## 🛠️ Technology Stack (v2)

### 🧠 Core Logic & Data Science
- **Python 3.10+** – Core runtime  
- **NumPy** – Vectorized numerical operations  
- **Pandas** – Data manipulation and aggregation  
- **Google Gemini** – AI-based contextual recommendations  

### 🎧 API & Terminal UI
- **Spotipy** – Spotify Web API integration  
- **Rich** – Terminal visualization with colorized tables and panels  
- **python-dotenv** – Manage environment variables securely  

### ⚙️ Scalability (Exploratory)
- **PySpark** – Optional large-scale data exploration

---

## 🚀 Getting Started

AuraTune runs locally as a simple Python script.

### ✅ Prerequisites
- Python **3.10 or newer**
- A **Spotify Developer Account** (for API credentials)
- A **Google AI Studio Account** (for Gemini API key)

---

### 🧩 Installation & Setup

#### 1. Clone the Repository
```bash
git clone https://github.com/codexshivam/auratune.git
cd auratune
2. Set Up a Virtual Environment (Recommended)
bash
Copy code
python -m venv venv
source venv/bin/activate   # On Windows: venv\Scripts\activate
3. Install Dependencies
bash
Copy code
pip install numpy pandas spotipy rich google-generativeai python-dotenv
Alternatively, if you have a requirements.txt file:

bash
Copy code
pip install -r requirements.txt
🔑 Configure Environment Variables
Create a .env file in the project root and add your credentials:

env
Copy code
SPOTIPY_CLIENT_ID='Your_Spotify_Client_ID_Here'
SPOTIPY_CLIENT_SECRET='Your_Spotify_Client_Secret_Here'
SPOTIPY_REDIRECT_URI='http://localhost:8888/callback'
GEMINI_API_KEY='Your_Google_Gemini_API_Key_Here'
💡 Note:
Your SPOTIPY_REDIRECT_URI must exactly match the one set in your Spotify Developer Dashboard.
For local development, http://localhost:8888/callback works perfectly.

▶️ Run AuraTune
Once everything is set up:

bash
Copy code
python main.py
(Replace main.py with your actual entry script if different.)

🤝 Contributing
Contributions are always welcome!
If you'd like to enhance AuraTune, follow these steps:

Fork the repository

Create a feature branch: git checkout -b feature-name

Commit your changes: git commit -m "Add new feature"

Push the branch: git push origin feature-name

Open a Pull Request

For detailed contribution rules, see the Contribution Guidelines.

📞 Connect with Me
👨‍💻 Author: Shivam Yadav
📧 Email: people@shivamyadav.com.np
🌐 Demo: auratune.shivamyadav.com.np

<div align="center">
⭐ Star this repository if you enjoyed exploring the blend of NumPy, Pandas, and AI!

Made with 💙 using Python and a touch of Gemini magic ✨
<br><br>
<sub>License: MIT</sub>

</div> 
