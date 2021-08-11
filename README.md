# Multimedia-Mouse
Control your audio and video by using any regular mouse as a multimedia controller. Requires a second mouse, ideally with the sensor taped over. Clicks and scrolls are captured and reassigned; there are no macros for mouse movement.

Get started by visiting the [Setup section](https://github.com/arimgibson/Multimedia-Mouse#Setup)!

## Contributing
This project was created with just myself in mind; I'm open sourcing it thinking a handful of others might also see the use in this macro. If you'd like to contribute or make a PR, I'd appreciate if you open an issue first so I can give my thoughts before you write the code. As the GPLv3 license permits, you are allowed to modify this and republish it to a new repository (I'd appreciate credit 😊).

## Keybindings
These are the default keybindings and functions, but they can be edited if you know a little bit of AHK. If anyone is interested in making a GUI editor to change the keybindings, I'd really appreciate a PR!

    Left Click - Play/Pause
    Double Left Click - Activate/Deactive Spotify Mode
    Right Click - Skip Track
    Double Right Click - Previous Track
    Middle Click - Mute
    Scroll Up - Volume Up
    Scroll Down - Volume Down

## Spotify Mode Explained
**Spotify Premium Required -- Inactive by default, see activation instructions in the Setup section**

Activating Spotify Mode sets keybindings to interact with the Spotify API and directly change Spotify instead of your computer as a whole. For example, if you had a video playing on VLC, left clicking on your multimedia mouse will pause VLC instead of music you might have playing in the background. Because Spotify mode uses the Spotify API, it also enables you to use your mouse to control Spotify when it's playing on a different device, such as your phone or a smart speaker.

## Setup

## Edit Bindings or Double Click Threshold

## Dependencies, Contributors, and Credit
[Spotify.ahk - CloakerSmoker](https://github.com/CloakerSmoker/Spotify.ahk), which uses:
 - [AHKhttp - zhamlin](https://github.com/zhamlin/AHKhttp)
 - [AHKsock - jleb](https://github.com/jleb/AHKsock)
 - [Crypt - Deo](https://autohotkey.com/board/topic/67155-ahk-l-crypt-ahk-cryptography-class-encryption-hashing/)

[AutoHotInterception - evilC](https://github.com/evilC/AutoHotInterception), which uses:
- [Interception - oblitum](https://github.com/oblitum/Interception) 