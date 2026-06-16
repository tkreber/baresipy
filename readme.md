# Baresipy

A python wrapper around [baresip](https://github.com/alfredh/baresip)

Make voip calls/bots from python!

![](./logo.png)

# install

system dependencies:

```bash
sudo apt-get install baresip ffmpeg   # debian/ubuntu
brew install baresip ffmpeg           # macOS
```

then install baresipy for your user (no sudo, no virtualenv needed):

```bash
pip install --user --break-system-packages git+https://github.com/tkreber/baresipy
```

This builds and installs baresipy straight from the repo into your user
site (via the poetry-core backend declared in `pyproject.toml`), so
`import baresipy` works from any script. Only `pip` is required — no
clone, no poetry, no make.

if you cloned the repo, install the local checkout instead:

```bash
pip install --user --break-system-packages .   # or: make install
```

other make targets: `make dev` (editable), `make uninstall`, `make clean`.

# usage

scripted calls

```python
from baresipy import BareSIP
from time import sleep

to = "jarbas_laptop@sipx.mattkeys.net"

gateway = "sipx.xxxxx.net"
user = "xxxxx"
pswd = "xxxxxx"

b = BareSIP(user, pswd, gateway)

b.call(to)

while b.running:
    sleep(0.5)
    if b.call_established:
        b.send_dtmf("123")
        b.speak("this is jarbas personal assistant speaking. this was a test")
        b.speak("Goodbye")
        b.hang()
        b.quit()

```


handling events

```python
from baresipy import BareSIP
from time import sleep
from pyjokes import get_joke


class JokeBOT(BareSIP):
    def handle_incoming_call(self, number):
        self.accept_call()

    def handle_call_established(self):
        self.speak("Welcome to the jokes bot")
        self.speak(get_joke())
        self.speak("Goodbye")
        self.hang()


gateway = "sipx.xxxxx.net"
user = "xxxxxx"
pswd = "xxxx"

b = JokeBOT(user, pswd, gateway)

while b.running:
    sleep(1)

```

        
# Credits

This work as been sponsored by Matt Keys, [eZuce Inc](https://ezuce.com/)