# আমার প্রথম পাঠশালা

শিশুদের জন্য বাংলা, English ও আরবি বর্ণ শেখার Flutter অ্যাপ। প্রতিটি বর্ণ ও ছড়ার জন্য MP3 অডিও তৈরি করে APK-এর মধ্যে অন্তর্ভুক্ত করা হয়, যাতে ইনস্টল করার পর অফলাইনেও শোনা যায়।

## GitHub থেকে APK তৈরি

1. ZIP Extract করে ভেতরের সব ফাইল ও ফোল্ডার repository-এর root-এ upload করুন। `.github/workflows/build-apk.yml`-সহ hidden `.github` ফোল্ডারটি অবশ্যই রাখুন।
2. GitHub repository-তে **Actions** tab খুলুন।
3. **Generate Audio and Build APK** workflow নির্বাচন করে **Run workflow** চাপুন (অথবা `main` branch-এ push করুন)।
4. Workflow-এ প্রথমে সব lesson ও rhyme-এর Bangla/English/Arabic MP3 তৈরি হবে। Flutter Android project files না থাকলে স্বয়ংক্রিয়ভাবে তৈরি হবে, তারপর APK build হবে।
5. APK-তে প্রতিটি প্রত্যাশিত MP3 সত্যিই আছে কি না যাচাই সফল হলেই `amar-prothom-pathshala-apk` Artifact প্রকাশ হবে।

## গুরুত্বপূর্ণ অডিও যাচাই

- `scripts/generate_audio.py` ১০৯টি অডিও তৈরি করে: ৫০টি বাংলা বর্ণ (১১ স্বরবর্ণ + ৩৯ ব্যঞ্জনবর্ণ), ২৬টি English letter, ২৮টি Arabic letter এবং ৫টি ছড়া।
- `scripts/verify_audio.py` APK-এর ভেতরে সব MP3 আছে কি না পরীক্ষা করে। কোনো অডিও বাদ পড়লে Workflow ব্যর্থ হবে এবং Artifact প্রকাশ করবে না।
- অডিও তৈরি করতে GitHub Actions runner-এর internet connection লাগে। তৈরি হওয়া অডিও APK-তে bundle করা হয়; অ্যাপ চালানোর সময় internet লাগে না।
- TTS generation uses the third-party `edge-tts` package and Microsoft Edge online text-to-speech voices. The service endpoint may change or throttle requests; if generation fails, the workflow will show the exact failing file and can be rerun.

## Voice mapping

- বাংলা: `bn-BD-PradeepNeural` (male), `bn-BD-NabanitaNeural` (female)
- English: `en-US-GuyNeural` (male), `en-US-JennyNeural` (female)
- Arabic: `ar-SA-HamedNeural` (male), `ar-SA-ZariyahNeural` (female)

## Project details

- App: আমার প্রথম পাঠশালা
- Developer: মো: মেহেদী হাসান
- License: MIT
