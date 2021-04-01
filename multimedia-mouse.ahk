#Persistent
#MaxThreads 10
#include %A_ScriptDir%
#include lib\AutoHotInterception.ahk
#include lib\Spotify.ahk

global spotifyClient := new Spotify
global spotifyMode = false
global AHI := new AutoHotInterception()
global dblClickThreshold = -200
global scrollThreshold = 200

global leftClickEvents := 0
global rightClickEvents := 0
global middleClickEvents := 0

global upCurrentTime := 0
global downCurrentTime := 0
global limit := 60

global muted := false
global vol := 0

SendMode Input

Gui Spotify:New, -SysMenu +AlwaysOnTop -Caption +Owner -0x800000
Gui, Spotify:Default
Gui Font, s30 cWhite, Calibri
Gui Color, 0x000000
Gui Add, Text, x0 y0 w400 h75 +0x200 +Center, Spotify Volume Mode

mouseId := AHI.GetMouseId(0x0461, 0x4D15)
AHI.SubscribeMouseButton(mouseId, 0, true, Func("leftClick"))
AHI.SubscribeMouseButton(mouseId, 1, true, Func("rightClick"))
AHI.SubscribeMouseButton(mouseId, 2, true, Func("middleClick"))
AHI.SubscribeMouseButton(mouseId, 5, true, Func("verticalWheel"))

; Event listener functions

leftClick(state) {
  if (state = 1) {
    leftClickEvents++
    SetTimer, leftClickHandler, %dblClickThreshold%
    if (leftClickEvents = 2) {
      SetTimer, leftClickHandler, Delete
      Gosub, leftClickHandler
    }
  }
}

rightClick(state) {
  if (state = 1) {
    rightClickEvents++
    SetTimer, rightClickHandler, %dblClickThreshold%
    if (rightClickEvents = 2) {
      SetTimer, rightClickHandler, Delete
      Gosub, rightClickHandler
    }
  }
}

middleClick(state) {
  if (state = 1) {
    Gosub, middleClickHandler
  }
}

verticalWheel(state) {
  if (%spotifyMode% = true) {
    if (muted = true) {
      spotifyClient.Player.SetVolume(vol)
      muted := false
    }

    if (state = 1) {
      vol := spotifyClient.Player.GetCurrentPlaybackInfo().Device.Volume + 10
    } else {
      vol := spotifyClient.Player.GetCurrentPlaybackInfo().Device.Volume - 10
    }

    if (vol >= 0 && vol <= 100) {
      spotifyClient.Player.SetVolume(vol)
    } else if (vol < 0) {
      spotifyClient.Player.SetVolume(0)
    } else if (vol > 100) {
      spotifyClient.Player.SetVolume(100)
    }
  } else {
    if (state = 1) {
      t:= A_TickCount - upCurrentTime
    } else {
      t:= A_TickCount - downCurrentTime
    }

    if (t < scrollThreshold) {
      v := (t < 50 && t > 1) ? (100.0 / t) - 1 : 1
      v := (v > 1) ? ((v > limit) ? limit : Floor(v)) : 1
    }

    if (state = 1) {
      Send {Volume_Up %v%}
    } else {
      Send {Volume_Down %v%}
    }
  }

  if (state = 1) {
    upCurrentTime := A_TickCount 
  } else if (state = -1) {
    downCurrentTime := A_TickCount
  }
}

; Event handler labels

leftClickHandler:
  if (leftClickEvents = 1) {
    if (%spotifyMode% = true) {
      spotifyClient.Player.PlayPause()
    } else {
      Send {Media_Play_Pause}
    }
  } else if (leftClickEvents = 2) {
    if (%spotifyMode% = true) {
      spotifyMode = false
      Gui Spotify:Hide
    } else {
      spotifyMode = true
      Gui Spotify:Show, x0 y0 w400 h75
    }
  }
  leftClickEvents = 0
return

rightClickHandler:
  if (rightClickEvents = 1) {
    if (%spotifyMode% = true) {
      spotifyClient.Player.NextTrack()
    } else {
      Send {Media_Next}
    }
  } else if (rightClickEvents = 2) {
    if (%spotifyMode% = true) {
      spotifyClient.Player.LastTrack()
    } else {
      Send {Media_Prev}
    }
  }
  rightClickEvents = 0
return

middleClickHandler:
  if (%spotifyMode% = true) {
    currentVol := spotifyClient.Player.GetCurrentPlaybackInfo().Device.Volume
    if (muted = true && currentVol = 0) {
      spotifyClient.Player.SetVolume(vol)
    } else if (muted = true && currentVol > 0) {
      muted := false
    } else if (muted = false && currentvol > 0) {
      vol := spotifyClient.Player.GetCurrentPlaybackInfo().Device.Volume
      spotifyClient.Player.SetVolume(0)
      muted := true
    }
  } else {
    Send {Volume_Mute}
  }
return