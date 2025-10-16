# 🎵 AuraTune - Musical DNA Analysis

<div align="center">

![AuraTune Logo](https://img.shields.io/badge/AuraTune-Music%20Analysis-1DB954?style=for-the-badge&logo=spotify&logoColor=white)

**Discover Your Musical DNA with AI-Powered Analysis**

*An Academic Project Showcasing NumPy & Pandas Implementation*

[![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)](https://flutter.dev)
[![Python](https://img.shields.io/badge/Python-3776AB?style=for-the-badge&logo=python&logoColor=white)](https://python.org)
[![NumPy](https://img.shields.io/badge/NumPy-013243?style=for-the-badge&logo=numpy&logoColor=white)](https://numpy.org)
[![Pandas](https://img.shields.io/badge/Pandas-150458?style=for-the-badge&logo=pandas&logoColor=white)](https://pandas.pydata.org)
[![Appwrite](https://img.shields.io/badge/Appwrite-F02E65?style=for-the-badge&logo=appwrite&logoColor=white)](https://appwrite.io)

[![GitHub Pages](https://img.shields.io/badge/GitHub%20Pages-222222?style=for-the-badge&logo=github&logoColor=white)](https://pages.github.com)
[![Academic Project](https://img.shields.io/badge/Academic-Project-blue?style=for-the-badge&logo=graduation-cap&logoColor=white)](https://github.com/codexshivam)

🌐 **[Live Demo](https://auratune.shivamyadav.com.np)** | 📚 **[Implementation Guide](IMPLEMENTATION_GUIDE.md)** | 🚀 **[Get Started](#-get-started)**

</div>

---

## 📚 About This Project

Hey there! I'm **Shivam Yadav**, a 1st semester CSE student at Chandigarh University, and this is my academic project that demonstrates the practical implementation of **NumPy** and **Pandas** libraries in real-world applications.

AuraTune is a web application that analyzes your Spotify listening habits to create a personalized musical aura visualization. It's built using Flutter for the frontend and Python with NumPy/Pandas for the data processing backend. The project showcases how these powerful libraries can be used to create sophisticated recommendation systems and personalized content delivery.

### 🎯 Project Goals
- Demonstrate practical NumPy and Pandas implementation
- Show how data science libraries can create personalized experiences
- Build a full-stack application with modern technologies
- Learn about recommendation systems and user behavior analysis

---

## 🧠 How NumPy & Pandas Power Personalization

### 🔢 **NumPy in Action**
NumPy is the backbone of numerical computing in Python. In AuraTune, I use it for:

**Audio Feature Processing**: When Spotify provides audio features for your favorite tracks, NumPy arrays help me process this data efficiently. Instead of using slow Python loops, I can perform vectorized operations on entire datasets at once.

**Statistical Analysis**: NumPy's mathematical functions help calculate mean values, standard deviations, and percentiles of your musical preferences. This gives insights into whether you prefer high-energy music or more acoustic sounds.

**Rolling Averages**: For returning users, NumPy helps create smooth transitions in your musical profile by calculating weighted averages between your old and new listening patterns.

### 📊 **Pandas for Data Management**
Pandas makes data manipulation a breeze. Here's how I use it:

**Data Cleaning**: Spotify sometimes returns incomplete data. Pandas DataFrames help me clean this up by removing invalid entries and filling missing values with sensible defaults.

**User Behavior Analysis**: By grouping and aggregating your listening data, Pandas helps identify patterns like "you listen to more energetic music on weekends" or "your mood shifts towards acoustic music in the evening."

**Time Series Analysis**: Pandas excels at handling time-based data, helping track how your musical taste evolves over weeks and months.

---

## 🌐 Real-World Applications

The same NumPy and Pandas techniques I used in AuraTune power many major platforms you use daily:

### 📱 **Social Media Platforms**
**Facebook** uses similar data processing to personalize your news feed. They analyze your interactions (likes, shares, comments) using NumPy arrays to calculate engagement scores, then use Pandas to group content by topics you're interested in.

**Instagram** applies these libraries to recommend stories and reels. They process your viewing behavior, calculate completion rates, and identify content types you engage with most.

### 🎥 **Entertainment Platforms**
**YouTube** uses NumPy for processing watch history data and Pandas for analyzing viewing patterns. They calculate similarity scores between users and recommend videos based on what similar users enjoyed.

**Netflix** applies these techniques to their recommendation engine, processing viewing data to suggest movies and shows you're likely to enjoy.

### 📚 **Content Platforms**
**Google Books** uses similar approaches to recommend books based on your reading history and preferences of users with similar tastes.

**Spotify** (the platform we're analyzing!) uses these same libraries internally to power their Discover Weekly and Daily Mix features.

### 🛒 **E-commerce**
**Amazon** uses NumPy and Pandas to analyze purchase history, calculate product similarities, and recommend items you might want to buy.

**Flipkart** applies these techniques to personalize product recommendations based on your browsing and purchase behavior.

---

## 🛠️ Technology Stack

### 🎨 **Frontend**
- **Flutter Web**: Cross-platform UI framework for building responsive web applications
- **Material Design**: Modern, clean interface design
- **fl_chart**: Beautiful, interactive charts for data visualization
- **Google Fonts**: Typography and text styling

### 🐍 **Backend & Data Processing**
- **Python 3.10**: Core programming language
- **NumPy**: Numerical computing and array operations
- **Pandas**: Data manipulation and analysis
- **Spotipy**: Spotify Web API integration
- **Appwrite**: Backend-as-a-Service platform

### ☁️ **Infrastructure**
- **Appwrite Cloud**: Database, authentication, and serverless functions
- **GitHub Pages**: Static web hosting
- **Spotify Web API**: Music data and user authentication

### 🔧 **Development Tools**
- **Flutter SDK**: Mobile and web app development
- **Appwrite CLI**: Backend deployment and management
- **Git**: Version control and collaboration

---

## 🚀 Get Started

### Prerequisites
Before you begin, make sure you have:
- **Flutter SDK** (3.19.0 or higher) installed
- **Python 3.10+** installed
- **Node.js** (for Appwrite CLI)
- **Git** for version control

### 📋 Required Accounts
You'll need accounts for:
- **Spotify Developer** - [Create here](https://developer.spotify.com/dashboard)
- **Appwrite Cloud** - [Sign up here](https://cloud.appwrite.io)
- **GitHub** - [Get started here](https://github.com)

### ⚡ Quick Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/codexshivam/auratune.git
   cd auratune
   ```

2. **Install dependencies**
   ```bash
   # Install Flutter dependencies
   flutter pub get
   
   # Install Python dependencies (for the serverless function)
   pip install pandas numpy spotipy appwrite-sdk
   ```

3. **Configure the application**
   ```bash
   # Copy the configuration template
   cp lib/config.dart.template lib/config.dart
   
   # Edit lib/config.dart with your Appwrite project details
   ```

4. **Run locally**
   ```bash
   flutter run -d chrome
   ```

### 📖 **Detailed Setup**
For complete setup instructions, check out the **[Implementation Guide](IMPLEMENTATION_GUIDE.md)** which covers:
- Spotify Developer Dashboard setup
- Appwrite backend configuration
- Serverless function deployment
- Production deployment to GitHub Pages

---

## 🎓 Academic Context

### 👨‍🎓 **Student Information**
- **Name**: Shivam Yadav
- **Program**: Bachelor of Engineering - Computer Science and Engineering
- **Semester**: 1st Semester
- **Institution**: Chandigarh University
- **Project Type**: Academic Capstone Project


### 📚 **Learning Objectives**
This project demonstrates:
- **Data Science**: Practical implementation of NumPy and Pandas
- **Machine Learning**: Basic concepts of recommendation systems
- **Full-Stack Development**: Integration of frontend and backend technologies
- **API Integration**: Working with third-party services like Spotify
- **Cloud Computing**: Using serverless functions and cloud databases

---

## 🏗️ How It Works

### 1. **Data Collection**
When you log in with Spotify, the app fetches your top 50 tracks and their audio features like danceability, energy, and mood.

### 2. **Data Processing**
Using NumPy and Pandas, the system:
- Cleans and validates the audio feature data
- Calculates statistical measures (mean, standard deviation)
- Identifies patterns in your listening behavior

### 3. **Personality Analysis**
Based on your musical data, the system classifies you into personality types like:
- **High-Energy Dynamo**: Loves energetic, upbeat music
- **Introspective Thinker**: Prefers contemplative, emotional music
- **Acoustic Soul**: Enjoys organic, authentic sounds
- **Balanced Listener**: Has diverse musical tastes

### 4. **Visualization**
The results are displayed as an interactive radar chart showing your musical traits, along with your personality type and overall score.

---

## 📊 Key Features

### 🎧 **Spotify Integration**
- Secure OAuth 2.0 authentication
- Real-time data synchronization
- Comprehensive listening history analysis

### 🧠 **AI-Powered Analysis**
- NumPy-based numerical computations
- Pandas data manipulation and analysis
- Sophisticated personality classification
- Musical trait identification

### 📊 **Beautiful Visualizations**
- Interactive radar charts
- Responsive design for all devices
- Real-time data updates
- Smooth animations

### ☁️ **Modern Architecture**
- Serverless backend functions
- Cloud database storage
- Automatic deployment pipeline
- Scalable infrastructure

---

## 🔧 Project Structure

```
auratune/
├── lib/                          # Flutter frontend code
│   ├── main.dart                # Main application entry
│   ├── models/                  # Data models
│   ├── services/                # API and state management
│   ├── screens/                 # UI screens
│   ├── widgets/                 # Reusable UI components
│   └── utils/                   # Utility functions
├── functions/                   # Python serverless functions
│   └── analyze-aura/
│       ├── main.py             # Core analysis logic
│       └── requirements.txt    # Python dependencies
├── web/                        # Web-specific configurations
├── IMPLEMENTATION_GUIDE.md     # Detailed setup instructions
└── README.md                   # This file
```

---

## 🎯 Future Enhancements

### 🔮 **Planned Features**
- **Social Sharing**: Share your musical aura with friends
- **Playlist Generation**: Auto-create playlists based on your aura
- **Trend Analysis**: Track how your musical taste changes over time
- **Collaborative Filtering**: Find users with similar musical tastes
- **Mobile App**: Native iOS and Android versions

### 🧠 **Advanced Analytics**
- **Mood Tracking**: Correlate music with daily moods
- **Seasonal Patterns**: Identify music preferences by season
- **Genre Evolution**: Track genre preferences over time
- **Artist Similarity**: Find artists similar to your favorites

---

## 🤝 Contributing

I welcome contributions and feedback! Whether you're a fellow student, developer, or music enthusiast, here's how you can help:

### 🐛 **Bug Reports**
Found a bug? Please open an issue with:
- Clear description of the problem
- Steps to reproduce
- Expected vs actual behavior

### 💡 **Feature Requests**
Have an idea for a new feature? I'd love to hear it! Open an issue with:
- Description of the feature
- Use case and benefits
- Any implementation ideas

### 🔧 **Development**
Want to contribute code? Great! Here's how:
1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

---

## 📄 License

This project is developed for academic purposes as part of the BE CSE curriculum at Chandigarh University.

**Academic Use Only** - This project is intended for educational and research purposes.

---

## 🙏 Acknowledgments


### 🏫 **Institution**
**Chandigarh University**  
*Computer Science and Engineering Department*

Grateful to Chandigarh University for providing the academic environment and resources necessary to develop this project.

### 📚 **Learning Resources**
- NumPy Documentation and Community
- Pandas User Guide and Best Practices
- Spotify Web API Documentation
- Flutter Development Community
- Appwrite Platform and Documentation

---

## 📞 Contact & Connect

### **Shivam Yadav** 🚀

<div style="text-align: center; margin: 20px 0;">

**🎓 1st Semester CSE Student at Chandigarh University**  
**🇳🇵 Nepal  |  🎂 Birthday: August 21**  

</div>

<div style="display: flex; justify-content: center; gap: 20px; margin: 20px 0; flex-wrap: wrap;">

[![Facebook](https://img.shields.io/badge/Facebook-1877F2?style=for-the-badge&logo=facebook&logoColor=white)](https://facebook.com/ycsxshivam)
[![Instagram](https://img.shields.io/badge/Instagram-E4405F?style=for-the-badge&logo=instagram&logoColor=white)](https://instagram.com/ycs.shivam)
[![LinkedIn](https://img.shields.io/badge/LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white)](https://linkedin.com/in/ycsxshivam)
[![Twitter](https://img.shields.io/badge/Twitter-1DA1F2?style=for-the-badge&logo=twitter&logoColor=white)](https://twitter.com/ycsxshivam)
[![GitHub](https://img.shields.io/badge/GitHub-181717?style=for-the-badge&logo=github&logoColor=white)](https://github.com/codexshivam)

</div>

### 💬 **Get in Touch**
- **Project Demo**: [https://auratune.shivamyadav.com.np](https://auratune.shivamyadav.com.np)
- **GitHub**: [@codexshivam](https://github.com/codexshivam)
- **Email**: [people@shivamyadav.com.np](mailto:people@shivamyadav.com.np)
- **University**: Chandigarh University, CSE Department


---

<div align="center">

**🎵 Made with ❤️ and 📚 by Shivam Yadav**

*1st Year CSE Student at Chandigarh University*


[![Chandigarh University](https://img.shields.io/badge/Chandigarh-University-blue?style=for-the-badge&logo=graduation-cap&logoColor=white)](https://www.cuchd.in)
[![BE CSE](https://img.shields.io/badge/BE-CSE-green?style=for-the-badge&logo=code&logoColor=white)](https://www.cuchd.in)

**⭐ Star this repository if you found the NumPy & Pandas implementation helpful!**

*This project showcases how data science libraries can create amazing personalized experiences*

</div>
