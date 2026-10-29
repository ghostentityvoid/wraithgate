# WRAITHGATE

A dark, glitchy, mysterious terminal experience for **Termux**.
*Powered by Cybervynq.*

## Features

- Unskippable, randomized boot sequence: hex streams, glitch text, a hidden presence that interrupts the loader, and a hand-sketched finger
- First-launch **alias** prompt: the boot greets you with `welcome back, <alias>. it waited.`
- Every command you type gets its own mysterious loading animation and a message before and after it runs
- Hacker themed prompt, colors and creepy "command not found" errors
- Piped output and scripts stay clean (animations only show on commands you type)
- One-word switch back to the default Termux UI, and back again

## Install (Termux)

```bash
pkg update && pkg install git -y
git clone https://github.com/YOUR-USERNAME/wraithgate.git
cd wraithgate
bash install.sh
```

Then close Termux completely and open it again.

For a better font, install the **Termux:Styling** app (F-Droid) and pick a monospace font such as Fira Code.

## Commands

| Command | What it does |
|---|---|
| `WRAITHGATE OFF` | Fully back to the default Termux look (colors, cursor, welcome text) |
| `WRAITHGATE ON` | Turn WRAITHGATE back on (replays the boot) |
| `restart` | Replays the full boot sequence |
| `clear` / `CTRL+L` | Quick wipe, redraws the header (the UI stays) |
| `command clear` | A truly blank screen |
| `wgalias [name]` | Change your alias |
| `wgjoin` | Show the community links |
| `wganim on` / `wganim off` | Turn per-command animations on or off |

`WRAITHGATE ON` and `OFF` also work in lowercase.

## Uninstall

```bash
bash uninstall.sh
```

## Customize

Edit `~/.wraithgate/wraithgate.sh` to change messages, colors, boot storylines, or the community links (`WG_GROUP`, `WG_CHANNEL`).

## Community

- WhatsApp group: https://chat.whatsapp.com/C3qzE9Ej0RC6fdb63gFekQ
- WhatsApp channel: https://whatsapp.com/channel/0029VbDvxqzLtOj9kQcyJL2N

## License

MIT. See `LICENSE`.
