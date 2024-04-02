String extractVideoID(String youtubeLink) {
  // Regular expression pattern to match YouTube video IDs
  RegExp pattern = RegExp(
      r'(?:https?://)?(?:www\.)?(?:youtube\.com(?:/[^/]+/.+/|(?:/embed/|/v/|/watch\?v=))|youtu\.be/)([a-zA-Z0-9_-]{11})');

  // Search for the pattern in the link
  RegExpMatch? match = pattern.firstMatch(youtubeLink);

  // If a match is found, return the video ID
  if (match != null) {
    return match.group(1)!; // Use null-aware operator to handle nullable type
  } else {
    return "Invalid YouTube link or video ID not found.";
  }
}
