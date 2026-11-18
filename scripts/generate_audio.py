import asyncio, json, os
from pathlib import Path
import edge_tts

ROOT = Path(__file__).resolve().parents[1]
DATA = json.loads((ROOT / "assets/data/lessons.json").read_text(encoding="utf-8"))
VOICE = {
    ("bn","male"): "bn-BD-PradeepNeural",
    ("bn","female"): "bn-BD-NabanitaNeural",
    ("en","male"): "en-US-GuyNeural",
    ("en","female"): "en-US-JennyNeural",
    ("ar","male"): "ar-SA-HamedNeural",
    ("ar","female"): "ar-SA-ZariyahNeural",
}
async def save_one(text, voice, dest):
    dest.parent.mkdir(parents=True, exist_ok=True)
    last = None
    for attempt in range(4):
        try:
            communicate = edge_tts.Communicate(text, voice, rate="-8%")
            await communicate.save(str(dest))
            if dest.exists() and dest.stat().st_size > 1000:
                return
            raise RuntimeError("Audio file is empty or too small")
        except Exception as exc:
            last = exc
            await asyncio.sleep(2 + attempt * 2)
    raise RuntimeError(f"Could not create {dest}: {last}")

async def main():
    tasks=[]
    for item in DATA["lessons"]:
        voice=VOICE[(item["language"],item["voice"])]
        tasks.append(save_one(item["speech"], voice, ROOT/item["audio"]))
    # Original short rhymes, narrated in a warm Bangladeshi female voice.
    for item in DATA["rhymes"]:
        tasks.append(save_one(item["title"] + "। " + item["text"], VOICE[("bn","female")], ROOT/item["audio"]))
    # Limit concurrency to avoid service throttling.
    for start in range(0,len(tasks),5):
        await asyncio.gather(*tasks[start:start+5])
    print(f"Generated {len(tasks)} MP3 files successfully.")
asyncio.run(main())
