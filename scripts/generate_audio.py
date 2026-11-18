"""Generate offline MP3 lesson audio with Google Translate TTS via gTTS.

The previous Edge-TTS websocket endpoint returned HTTP 403 in GitHub Actions.
This generator uses gTTS HTTP requests instead. gTTS does not expose selectable
male/female voices; voice labels in lessons.json are retained as content metadata
but are not used to choose a speaker.
"""
import json
import random
import sys
import time
from pathlib import Path

from gtts import gTTS
from gtts.lang import tts_langs

ROOT = Path(__file__).resolve().parents[1]
DATA = ROOT / "assets" / "data" / "lessons.json"
AUDIO = ROOT / "assets" / "audio"
LANG_MAP = {"bn": "bn", "en": "en", "ar": "ar"}
MIN_BYTES = 300


def generate_one(text: str, lang: str, output: Path) -> None:
    output.parent.mkdir(parents=True, exist_ok=True)
    last_error = None
    for attempt in range(1, 6):
        try:
            if lang not in tts_langs():
                raise RuntimeError(f"gTTS does not support language code: {lang}")
            temp = output.with_suffix(".mp3.part")
            if temp.exists():
                temp.unlink()
            gTTS(text=text, lang=lang, slow=False, lang_check=False).save(str(temp))
            if not temp.exists() or temp.stat().st_size < MIN_BYTES:
                raise RuntimeError("Generated MP3 is empty or too small")
            temp.replace(output)
            return
        except Exception as exc:
            last_error = exc
            temp = output.with_suffix(".mp3.part")
            if temp.exists():
                temp.unlink()
            if output.exists():
                output.unlink()
            if attempt < 5:
                delay = min(60, 5 * (2 ** (attempt - 1))) + random.uniform(0, 2)
                print(f"Retry {attempt}/5 for {output.name} after error: {exc}; wait {delay:.1f}s", flush=True)
                time.sleep(delay)
    raise RuntimeError(f"Failed after 5 attempts: {output}: {last_error}")


def main() -> None:
    if not DATA.is_file():
        raise SystemExit(f"Missing lesson data: {DATA}")
    data = json.loads(DATA.read_text(encoding="utf-8"))
    tasks = []
    for item in data.get("lessons", []):
        lang = item.get("language")
        if lang not in LANG_MAP:
            raise SystemExit(f"Unsupported lesson language {lang!r}: {item}")
        tasks.append((item["spoken_text"], LANG_MAP[lang], AUDIO / lang / item["audio"]))
    for item in data.get("rhymes", []):
        tasks.append((item["text"], "bn", AUDIO / "rhymes" / item["audio"]))
    if not tasks:
        raise SystemExit("No lesson or rhyme audio tasks found in lessons.json")

    print(f"Audio tasks found: {len(tasks)}", flush=True)
    for index, (text, lang, path) in enumerate(tasks, 1):
        print(f"[{index}/{len(tasks)}] Creating {path.relative_to(ROOT)} (language={lang})", flush=True)
        generate_one(text, lang, path)
        # Avoid sending requests too quickly to the public TTS endpoint.
        time.sleep(0.8)

    invalid = [str(p.relative_to(ROOT)) for _, _, p in tasks if not p.is_file() or p.stat().st_size < MIN_BYTES]
    if invalid:
        raise SystemExit("Audio verification failed:\n" + "\n".join(invalid))
    print(f"SUCCESS: generated and verified all {len(tasks)} MP3 files.", flush=True)


if __name__ == "__main__":
    main()
