// Google Play Reviews Scraper - Node.js example
// npm install apify-client
// APIFY_TOKEN=your_token node node.mjs
import { ApifyClient } from 'apify-client';

const client = new ApifyClient({ token: process.env.APIFY_TOKEN });

// Reviews that mention crashes or ads, two apps
const run = await client.actor('Turboextract/google-play-reviews').call({
    "appIds": [
        "com.spotify.music",
        "com.deezer.android.app"
    ],
    "keywords": [
        "crash",
        "ads"
    ],
    "maxReviewsPerApp": 1000
});

const { items } = await client.dataset(run.defaultDatasetId).listItems();
for (const item of items) {
    console.log(item.appId, item.rating, item.date, item.text);
}
