import asyncio, json, os, sys
from pathlib import Path
import edge_tts

ROOT = Path(__file__).resolve().parents[1]
DATA = ROOT / 'assets' / 'data' / 'lessons.json'
AUDIO = ROOT / 'assets' / 'audio'

async def make_one(text, voice, output):
    output.parent.mkdir(parents=True, exist_ok=True)
    last_error = None
    for attempt in range(1, 6):
        try:
            communicate = edge_tts.Communicate(text=text, voice=voice, rate='-5%', volume='+0%')
            await communicate.save(str(output))
            if output.exists() and output.stat().st_size > 1000:
                return
            raise RuntimeError(f'Audio file is empty or too small: {output}')
        except Exception as exc:
            last_error = exc
            if output.exists(): output.unlink()
            await asyncio.sleep(attempt * 3)
    raise RuntimeError(f'Failed after 5 attempts: {output.name}: {last_error}')

async def main():
    data = json.loads(DATA.read_text(encoding='utf-8'))
    tasks = []
    for item in data['lessons']:
        lang = item['language']
        tasks.append((item['spoken_text'], item['voice'], AUDIO / lang / item['audio']))
    for item in data['rhymes']:
        tasks.append((item['text'], item['voice'], AUDIO / 'rhymes' / item['audio']))
    # Sequential requests reduce throttling and make failures explicit.
    for index, (text, voice, path) in enumerate(tasks, 1):
        print(f'[{index}/{len(tasks)}] Creating {path.relative_to(ROOT)} with {voice}', flush=True)
        await make_one(text, voice, path)
    missing = [str(path.relative_to(ROOT)) for _, _, path in tasks if not path.exists() or path.stat().st_size <= 1000]
    if missing:
        raise RuntimeError('Missing/invalid audio files:\n' + '\n'.join(missing))
    print(f'SUCCESS: generated and verified all {len(tasks)} MP3 files.', flush=True)

if __name__ == '__main__':
    asyncio.run(main())
