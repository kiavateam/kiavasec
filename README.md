
## Commands

| Use help |
|:--------|:------------|
| [#!/]help | just send help in your group and get the commands |

**You can use "#", "!", or "/" to begin all commands

* * *

# Installation

```sh
# Let's install the bot.
cd $HOME
git clone https://github.com/kiavateam/kiavasec.git
cd kiavasec
chmod +x kiava.sh
./kiava.sh install
./kiava.sh # Enter a phone number & confirmation code.
```
### One command
To install everything in one command, use:
```sh
cd $HOME && git clone https://github.com/kiavateam/kiavasec.git && cd kiavasec && chmod +x kiava.sh && ./kiava.sh install && ./kiava.sh
```

* * *

### Sudo And Bot
After you run the bot for first time, send it `!id`. Get your ID and stop the bot.

Open ./bot/bot.lua and add your ID to the "sudo_users" section in the following format:
```
    sudo_users = {
    247134702,
    0,
    YourID
  }
```
add your bot ID at line 4
add your ID at line 82 in bot.lua247134702
add your ID at line 235 in tools.lua
Then restart the bot.

