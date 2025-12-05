from pathlib import Path
import subprocess as sp


gifs = list(Path().glob("*.gif"))

[sp.run(f'ffmpeg -i "{g}" "{g.stem.replace(" ","_")}"%04d.png',shell=True) for g in gifs]
