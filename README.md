# 🎵 AuraTune (An AI Applications Project)

<div align="center">

Discover your Musical DNA & get AI-powered recommendations right in your terminal.

An Academic Project showcasing Python's Data Science Stack

<p>
[![Implementation Guide](https://img.shields.io/badge/Implementation_Guide-D90429?style=for-the-badge&logo=book&logoColor=white)](IMPLEMENTATION_GUIDE.md)
[![GitHub Repo](https://img.shields.io/badge/GitHub_Repo-181717?style=for-the-badge&logo=github&logoColor=white)](https://github.com/codexshivam/auratune)
</p>

<p>
![Python](https://img.shields.io/badge/Python-3776AB?style=for-the-badge&logo=python&logoColor=white)
![NumPy](https://img.shields.io/badge/NumPy-013243?style=for-the-badge&logo=numpy&logoColor=white)
![Pandas](https://img.shields.io/badge/Pandas-150458?style=for-the-badge&logo=pandas&logoColor=white)
![Spotipy](https://img.shields.io/badge/Spotipy-1DB954?style=for-the-badge&logo=spotify&logoColor=white)
![Rich](https://img.shields.io/badge/Rich-F37736?style=for-the-badge&logo=python&logoColor=white)
![Gemini AI](https://img.shields.io/badge/Gemini_AI-4285F4?style=for-the-badge&logo=google&logoColor=white)
</p>

</div>

---

## 📚 About This Project

**AuraTune** is a local Python CLI that analyzes your Spotify listening habits to generate a personalized "Musical Aura." Version 2 integrates Google's Gemini AI to provide dynamic, AI-powered book and Bollywood movie recommendations that match your music vibe—all displayed beautifully in your terminal using the Rich library.

This project was developed as part of my academic coursework.

* **Student:** **Shivam Yadav**
* **Program:** B.E. - Computer Science & Engineering
* **Semester:** 1st
* **Institution:** Chandigarh University

---

## 🎯 Project Goals

* Demonstrate **NumPy** for numerical analysis and **Pandas** for data manipulation.
* Integrate a Large Language Model (**Google Gemini**) for personalized recommendations.
* Provide a clean, user-friendly CLI experience using **Python** and **Rich**.
* Explore data processing at scale by comparing Pandas with PySpark.

---

## ✨ Key Features

* **🎧 Personalized Aura Analysis:** Analyzes audio features (energy, danceability, valence, etc.) from your top Spotify tracks.
* **🤖 AI Recommendations:** Uses Gemini to suggest books & Bollywood movies tailored to your unique musical aura.
* **📈 Data-Driven Insights:** Leverages NumPy + Pandas for cleaning, aggregation, and vectorized analysis.
* **📊 Beautiful Terminal UI:** Employs the Rich library for colorful, formatted output, including tables and panels.

---

## 🛠️ Technology Stack (v2)

### Core Logic
* **Python 3.10+**: Core runtime
* **NumPy**: Numerical computations & feature analysis
* **Pandas**: Data cleaning, manipulation & aggregation
* **Google Gemini**: AI-powered recommendations
* **PySpark**: (Optional) For large-scale data processing exploration

### API & UI
* **Spotipy**: Spotify Web API integration
* **Rich**: Beautiful terminal formatting (tables, panels, colors)

---

## 🚀 Getting Started

This project runs as a Python script on your local machine.

### Prerequisites

* Python 3.10 or newer
* A **Spotify Developer Account** to get:
    * `SPOTIPY_CLIENT_ID`
    * `SPOTIPY_CLIENT_SECRET`
* A **Google AI Studio Account** to get:
    * `GEMINI_API_KEY`

### Installation & Setup

1.  **Clone the repository:**
    ```sh
    git clone [https://github.com/codexshivam/auratune.git](https://github.com/codexshivam/auratune.git)
    cd auratune
    ```

2.  **Install dependencies:**
    (It's highly recommended to use a virtual environment)
    ```sh
    # Create a virtual environment (optional but recommended)
    python -m venv venv
    source venv/bin/activate  # On Windows: venv\Scripts\activate

    # Install required packages
    pip install numpy pandas spotipy rich google-generativeai python-dotenv
    ```
    *(Alternatively, if you have a `requirements.txt` file: `pip install -r requirements.txt`)*

3.  **Set up Environment Variables:**
    Create a file named `.env` in the root of the project directory and add your API keys:
    ```.env
    SPOTIPY_CLIENT_ID='Your_Spotify_Client_ID_Here'
    SPOTIPY_CLIENT_SECRET='Your_Spotify_Client_Secret_Here'
    SPOTIPY_REDIRECT_URI='http://localhost:8888/callback'
    GEMINI_API_KEY='Your_Google_Gemini_API_Key_Here'
    ```
    > **Note:** The `SPOTIPY_REDIRECT_URI` must **exactly match** the one you set in your Spotify Developer Dashboard. `http://localhost:8888/callback` is a common one for local development.

### Running AuraTune

Once your keys are in the `.env` file and all packages are installed:

```sh
python main.py