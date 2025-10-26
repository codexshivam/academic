import spotipy
import pandas as pd
import numpy as np
from spotipy.oauth2 import SpotifyOAuth
from rich.console import Console
from rich.panel import Panel
from rich.rule import Rule
from rich.text import Text
from rich.markdown import Markdown
import google.generativeai as genai

CLIENT_ID = '85cc994ecc764778a90c1128057b4434'
CLIENT_SECRET = '244a57ea9f6f4ca8bf8a90b6f37a0199'
REDIRECT_URI = 'https://example.com/callback'
GEMINI_API_KEY = 'AIzaSyAIjwdKHWr8hDicGVT1iy3bs4c8Kq9YtFE'

AURA_FEATURES = ['energy', 'valence', 'danceability', 'acousticness', 'instrumentalness']
FEATURE_NAMES = ['Energy', 'Happiness', 'Danceability', 'Acousticness', 'Instrumentalness']
SCOPE = 'user-top-read'

console = Console()

if GEMINI_API_KEY:
    genai.configure(api_key=GEMINI_API_KEY)
    ai_model = genai.GenerativeModel('gemini-2.5-flash-preview-09-2025')
else:
    ai_model = None
    if not GEMINI_API_KEY:
        console.print(Panel("[yellow]GEMINI_API_KEY not found.[/yellow]\nSet the environment variable to enable AI recommendations.\nWill use fallback recommendations.", title="[bold]AI Warning[/bold]", border_style="yellow"))
    else:
         console.print(Panel("[yellow]Default GEMINI_API_KEY found.[/yellow]\nPlease replace the placeholder key to enable AI recommendations.\nWill use fallback recommendations.", title="[bold]AI Warning[/bold]", border_style="yellow"))


def authenticate_spotify():
    console.print(Rule("[bold bright_blue]Authenticating with Spotify[/bold bright_blue]", style="blue"))

    auth_manager = SpotifyOAuth(
        client_id=CLIENT_ID,
        client_secret=CLIENT_SECRET,
        redirect_uri=REDIRECT_URI,
        scope=SCOPE,
        cache_path=".spotip_cache",
        open_browser=False
    )

    token_info = auth_manager.get_cached_token()

    if not token_info:
        auth_url = auth_manager.get_authorize_url()

        instructions = (
            "[bold]MANUAL AUTHENTICATION REQUIRED:[/bold]\n\n"
            "1. Please paste this URL into your browser:\n"
            f"   [blue]{auth_url}[/blue]\n\n"
            "2. Log in. Your browser will redirect to 'example.com'.\n"
            "   [yellow]THIS IS NORMAL.[/yellow]\n\n"
            "3. Copy the FULL URL from your browser's address bar.\n"
            "4. Paste the full URL here and press Enter:"
        )

        console.print(Panel(instructions, title="[yellow]Action Required[/yellow]", border_style="yellow", padding=(1, 2)))

        try:
            redirected_url = input("\nPaste URL here: ")
        except EOFError:
            console.print("\n[red]Input cancelled. Exiting.[/red]")
            return None

        console.print("\n...Processing URL...")

        try:
            code = auth_manager.parse_response_code(redirected_url)
            token_info = auth_manager.get_access_token(code, as_dict=False)
        except Exception as e:
            console.print(f"\n[red]Error getting token: {e}[/red]")
            console.print("Did you paste the *full* redirected URL? Please try again.")
            return None

    if not token_info:
        console.print("[red]Authentication failed.[/red]")
        return None

    console.print("[green]Token acquired. Creating Spotify client...[/green]")
    sp = spotipy.Spotify(auth_manager=auth_manager)
    return sp

def get_aura_data(sp):
    console.print("\nFetching your top 50 tracks (medium term)...")
    try:
        top_tracks = sp.current_user_top_tracks(limit=50, time_range="medium_term")
    except Exception as e:
        console.print(f"[red]Error fetching top tracks: {e}[/red]")
        return None

    if not top_tracks or not top_tracks['items']:
        console.print("[yellow]No top tracks found. Using default profile.[/yellow]")
        return []

    track_ids = [item['id'] for item in top_tracks['items']]

    console.print("Fetching audio features for your tracks...")
    audio_features_list = sp.audio_features(tracks=track_ids)
    audio_features_list = [f for f in audio_features_list if f]

    return audio_features_list

def analyze_aura(audio_features_list):
    console.print("Analyzing your aura...")

    if not audio_features_list:
        default_data = {feature: 0.0 for feature in AURA_FEATURES}
        return pd.Series(default_data)

    df = pd.DataFrame(audio_features_list)

    for col in AURA_FEATURES:
        if col not in df.columns:
            df[col] = 0.0

    aura_vector = df[AURA_FEATURES].mean()
    return aura_vector

def get_personality_and_score(aura_vector):
    overall_score = np.mean(aura_vector.values) * 100

    personality = "Balanced Listener"

    if overall_score > 0:
        if aura_vector['energy'] > 0.7 and aura_vector['danceability'] > 0.6:
            personality = "High-Energy Dynamo"
        elif aura_vector['valence'] < 0.3 and aura_vector['acousticness'] > 0.5:
            personality = "Introspective Thinker"
        elif aura_vector['instrumentalness'] > 0.5:
            personality = "Deep Focus Connoisseur"
        elif aura_vector['valence'] > 0.75 and aura_vector['energy'] > 0.6:
            personality = "Sunbeam Rider"

    return personality, overall_score

def get_fallback_recommendations(personality):
    recommendation_db = {
        "High-Energy Dynamo": {
            "movies": ["Yeh Jawaani Hai Deewani", "Gully Boy", "Zindagi Na Milegi Dobara"],
            "books": ["'Ready Player One' by Ernest Cline", "'The Girl with the Dragon Tattoo' by Stieg Larsson"]
        },
        "Introspective Thinker": {
            "movies": ["The Lunchbox", "Piku", "Dear Zindagi"],
            "books": ["'Norwegian Wood' by Haruki Murakami", "'Siddhartha' by Hermann Hesse"]
        },
        "Deep Focus Connoisseur": {
            "movies": ["Haider", "Tumbbad", "Barfi!"],
            "books": ["'Dune' by Frank Herbert", "'Sapiens' by Yuval Noah Harari"]
        },
        "Sunbeam Rider": {
            "movies": ["Jab We Met", "Bareilly Ki Barfi", "Dil Chahta Hai"],
            "books": ["'The Hitchhiker's Guide to the Galaxy' by Douglas Adams", "'Eleanor Oliphant Is Completely Fine' by Gail Honeyman"]
        },
        "Balanced Listener": {
            "movies": ["3 Idiots", "Lagaan", "Queen"],
            "books": ["'To Kill a Mockingbird' by Harper Lee", "'The Alchemist' by Paulo Coelho"]
        }
    }
    data = recommendation_db.get(personality, recommendation_db["Balanced Listener"])

    movie_list = "\n".join([f"• **{m}**" for m in data["movies"]])
    book_list = "\n".join([f"• **{b}**" for b in data["books"]])
    return f"**Bollywood Movies**\n{movie_list}\n\n**Books**\n{book_list}"


def get_ai_recommendations(personality, aura_vector, user_name):
    if not ai_model:
        return get_fallback_recommendations(personality)

    console.print("\n[yellow]Calling AI for personalized recommendations... (this may take a moment)[/yellow]")

    prompt = f"""
    Act as a world-class cultural recommendation engine for a user named {user_name}.
    Their musical aura is "{personality}".

    Their detailed audio profile (from 0 to 1) is:
    - Energy: {aura_vector['energy']:.2f}
    - Happiness (Valence): {aura_vector['valence']:.2f}
    - Danceability: {aura_vector['danceability']:.2f}
    - Acousticness: {aura_vector['acousticness']:.2f}
    - Instrumentalness: {aura_vector['instrumentalness']:.2f}

    Based *only* on this specific vibe, please recommend:
    1.  **Two Bollywood movies.**
    2.  **Two books.**

    Give a brief, one-sentence reason for each recommendation, explaining *why* it matches this musical profile.
    Format the output cleanly using Markdown.
    """

    try:
        response = ai_model.generate_content(prompt)
        return response.text
    except Exception as e:
        console.print(f"[red]AI call failed: {e}[/red]")
        console.print("[yellow]Using fallback recommendations.[/yellow]")
        return get_fallback_recommendations(personality)


def display_results(aura_vector, personality, user_name, recommendations):
    console.print(Rule(f"[bold bright_red]AuraTune Analysis for: {user_name}[/bold bright_red]", style="red"))
    console.print("\n")

    panel_content = (
        f"\n[bold]Aura Personality[/bold]: [yellow]{personality}[/yellow]\n"
    )
    console.print(Panel(panel_content, title="[bold yellow]Your Musical Aura[/bold yellow]", border_style="bright_red", padding=(1, 2)))

    console.print("\n\n\n[bold]Aura Vector (Radar Chart Data)[/bold]\n")
    for i, feature_name in enumerate(FEATURE_NAMES):
        feature_key = AURA_FEATURES[i]
        value = aura_vector[feature_key]

        bar_length = 40
        filled_length = int(value * bar_length)
        empty_length = bar_length - filled_length

        bar = "█" * filled_length
        bar_empty = "─" * empty_length

        color = "bright_red" if value > 0.05 else "grey50"

        console.print(f"{feature_name:<18}: [bold]{value:.2f}[/bold] | [{color}]{bar}[/{color}][dim]{bar_empty}[/dim]")

    console.print("\n\n")
    console.print(Rule("[bold bright_blue]Personalized AI Recommendations[/bold bright_blue]", style="blue"))
    console.print(f"\nBased on your '[bold]{personality}[/bold]' profile, you might enjoy these:")

    console.print(Panel(Markdown(recommendations), border_style="bright_blue", padding=(1, 2)))

    console.print("\n\n")
    console.print(Rule("[bold bright_blue]Technology Behind this Script[/bold bright_blue]", style="blue"))
    console.print("\n• [bold blue]numpy[/bold blue]:   [dim]For numerical computations[/dim]")
    console.print("• [bold blue]pandas[/bold blue]:  [dim]For data manipulation[/dim]")
    console.print("• [bold blue]spotipy[/bold blue]: [dim]To connect to the Spotify API[/dim]")
    console.print("• [bold blue]rich[/bold blue]:    [dim]For beautiful terminal output[/dim]")
    console.print("• [bold blue]gemini[/bold blue]:  [dim]For AI-powered recommendations[/dim]")
    console.print("\n")

def main():
    console.print(Rule("[bold bright_red]AuraTune (An AI Applications Project) 🎵[/bold bright_red]", style="red"))

    sp = authenticate_spotify()

    if not sp:
        console.print("\n[red]Authentication failed. Exiting.[/red]")
        return

    console.print("\n[green]Authentication successful.[/green] Fetching user profile...")

    try:
        user_profile = sp.current_user()
        user_name = user_profile['display_name']
        console.print(f"Logged in as: [bold bright_red]{user_name}[/bold bright_red]")

    except Exception as e:
        console.print(f"\n[red]Error fetching user profile: {e}[/red]")
        console.print("This could be due to an expired token. Try deleting .spotip_cache and running again.")
        return

    features = get_aura_data(sp)
    if features is None:
        return

    aura_vector = analyze_aura(features)

    personality, score = get_personality_and_score(aura_vector)

    recommendations = get_ai_recommendations(personality, aura_vector, user_name)

    console.print("\n")
    display_results(aura_vector, personality, user_name, recommendations)

if __name__ == "__main__":
    main()