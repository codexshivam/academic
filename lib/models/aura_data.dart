class AuraData {
  final String spotifyId;
  final String displayName;
  final List<double> auraVector;
  final String auraPersonality;
  final DateTime? lastUpdated;
  final bool isFirstTime;
  final String? email;
  final String? profileImageUrl;
  final int analysisCount;

  const AuraData({
    required this.spotifyId,
    required this.displayName,
    required this.auraVector,
    required this.auraPersonality,
    this.lastUpdated,
    this.isFirstTime = false,
    this.email,
    this.profileImageUrl,
    this.analysisCount = 1,
  });

  factory AuraData.fromJson(Map<String, dynamic> json) {
    return AuraData(
      spotifyId: json['spotifyId'] ?? '',
      displayName: json['displayName'] ?? '',
      auraVector: List<double>.from(json['auraVector'] ?? [0.5, 0.5, 0.5, 0.5, 0.5]),
      auraPersonality: json['auraPersonality'] ?? 'Unknown',
      lastUpdated: json['lastUpdated'] != null 
          ? DateTime.parse(json['lastUpdated']) 
          : null,
      isFirstTime: json['isFirstTime'] ?? false,
      email: json['email'],
      profileImageUrl: json['profileImageUrl'],
      analysisCount: json['analysisCount'] ?? 1,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'spotifyId': spotifyId,
      'displayName': displayName,
      'auraVector': auraVector,
      'auraPersonality': auraPersonality,
      'lastUpdated': lastUpdated?.toIso8601String(),
      'isFirstTime': isFirstTime,
      'email': email,
      'profileImageUrl': profileImageUrl,
      'analysisCount': analysisCount,
    };
  }

  double get overallScore {
    if (auraVector.isEmpty) return 0.0;
    return (auraVector.reduce((a, b) => a + b) / auraVector.length * 100);
  }

  AuraData copyWith({
    String? spotifyId,
    String? displayName,
    List<double>? auraVector,
    String? auraPersonality,
    DateTime? lastUpdated,
    bool? isFirstTime,
    String? email,
    String? profileImageUrl,
    int? analysisCount,
  }) {
    return AuraData(
      spotifyId: spotifyId ?? this.spotifyId,
      displayName: displayName ?? this.displayName,
      auraVector: auraVector ?? this.auraVector,
      auraPersonality: auraPersonality ?? this.auraPersonality,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      isFirstTime: isFirstTime ?? this.isFirstTime,
      email: email ?? this.email,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      analysisCount: analysisCount ?? this.analysisCount,
    );
  }
}

class AuraTraits {
  static const List<String> traitNames = [
    'Danceability',
    'Energy', 
    'Happiness',
    'Acousticness',
    'Instrumentalness',
  ];

  static const List<String> traitDescriptions = [
    'How suitable a track is for dancing',
    'Perceptual measure of intensity and power',
    'Musical positivity conveyed by a track',
    'Confidence measure of whether the track is acoustic',
    'Predicts whether a track contains no vocals',
  ];
}

class PersonalityType {
  final String name;
  final String description;
  final String emoji;

  const PersonalityType({
    required this.name,
    required this.description,
    required this.emoji,
  });

  static const List<PersonalityType> types = [
    PersonalityType(
      name: 'High-Energy Dynamo',
      description: 'You love energetic, powerful music that gets you moving!',
      emoji: '⚡',
    ),
    PersonalityType(
      name: 'Introspective Thinker',
      description: 'You prefer contemplative, emotional music for deep reflection.',
      emoji: '🤔',
    ),
    PersonalityType(
      name: 'Balanced Listener',
      description: 'You enjoy a diverse range of musical styles and moods.',
      emoji: '🎵',
    ),
    PersonalityType(
      name: 'Acoustic Soul',
      description: 'You appreciate authentic, organic sounds and raw musicality.',
      emoji: '🎸',
    ),
    PersonalityType(
      name: 'Dance Enthusiast',
      description: 'You live for rhythm and beats that make you want to dance.',
      emoji: '💃',
    ),
  ];

  static PersonalityType fromName(String name) {
    return types.firstWhere(
      (type) => type.name == name,
      orElse: () => types[2], // Default to Balanced Listener
    );
  }
}
