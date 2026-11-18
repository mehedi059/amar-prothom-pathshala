import json, sys, zipfile
from pathlib import Path
ROOT = Path(__file__).resolve().parents[1]
APK = Path(sys.argv[1]) if len(sys.argv) > 1 else ROOT / 'build/app/outputs/flutter-apk/app-release.apk'
data = json.loads((ROOT/'assets/data/lessons.json').read_text(encoding='utf-8'))
expected = []
for x in data['lessons']:
    expected.append(f'assets/audio/{x["language"]}/{x["audio"]}')
for x in data['rhymes']:
    expected.append(f'assets/audio/rhymes/{x["audio"]}')
if not APK.exists(): raise SystemExit(f'APK not found: {APK}')
with zipfile.ZipFile(APK) as z:
    names=set(z.namelist())
    missing=[]
    for p in expected:
        key='flutter_assets/'+p
        if key not in names:
            missing.append(key)
    if missing:
        print('ERROR: APK is missing audio assets:', *missing, sep='\n', file=sys.stderr)
        raise SystemExit(1)
    print(f'PASS: APK contains all {len(expected)} expected MP3 assets.')
