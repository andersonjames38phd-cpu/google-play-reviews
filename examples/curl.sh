#!/usr/bin/env bash
# Google Play Reviews Scraper - curl examples
# Replace YOUR_TOKEN with an Apify API token (https://console.apify.com/account/integrations).

set -euo pipefail

ACTOR="Turboextract~google-play-reviews"
TOKEN="${APIFY_TOKEN:-YOUR_TOKEN}"

# 1. 1- and 2-star reviews since a date (start a run)
curl -sS -X POST "https://api.apify.com/v2/acts/${ACTOR}/runs?token=${TOKEN}" \
  -H "Content-Type: application/json" \
  -d '{
    "appIds": [
      "com.duolingo"
    ],
    "maxRating": 2,
    "newerThan": "2026-11-01",
    "maxReviewsPerApp": 500
  }'

# 2. Reviews that mention crashes or ads, two apps (start a run)
curl -sS -X POST "https://api.apify.com/v2/acts/${ACTOR}/runs?token=${TOKEN}" \
  -H "Content-Type: application/json" \
  -d '{
    "appIds": [
      "com.spotify.music",
      "com.deezer.android.app"
    ],
    "keywords": [
      "crash",
      "ads"
    ],
    "maxReviewsPerApp": 1000
  }'

# 3. Most relevant German reviews (wait and get the dataset items in one call)
curl -sS -X POST "https://api.apify.com/v2/acts/${ACTOR}/run-sync-get-dataset-items?token=${TOKEN}" \
  -H "Content-Type: application/json" \
  -d '{
    "appIds": [
      "https://play.google.com/store/apps/details?id=com.spotify.music"
    ],
    "sort": "relevant",
    "language": "de",
    "country": "de"
  }'
