"""Google Play Reviews Scraper - Python example.

pip install apify-client
export APIFY_TOKEN=your_token
"""
import os

from apify_client import ApifyClient

client = ApifyClient(os.environ["APIFY_TOKEN"])

# 1- and 2-star reviews since a date
run = client.actor("Turboextract/google-play-reviews").call(run_input={
    "appIds": [
        "com.duolingo"
    ],
    "maxRating": 2,
    "newerThan": "2026-11-01",
    "maxReviewsPerApp": 500
})

# Stream every item
for item in client.dataset(run["defaultDatasetId"]).iterate_items():
    print(item.get("appId"), item.get("rating"), item.get("date"), item.get("text"))

# Or fetch one page of items
page = client.dataset(run["defaultDatasetId"]).list_items(limit=100)
print(f"{page.total} items in dataset")
