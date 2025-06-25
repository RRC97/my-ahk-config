#SingleInstance Force
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.

Menu, Tray, Icon, mouse_off.ico

CapsLock::Esc
Esc::`
^CapsLock::CapsLock

; ========================
;   MODO MOUSE COM JKLI
; ========================

mouseMode := false
isHoldingClick := false
isHoldingRightClick := false

^!m::  ; Ctrl + Alt + M alterna o modo mouse
{
    mouseMode := !mouseMode
    if (mouseMode) {
        Menu, Tray, Icon, mouse_on.ico
        ;Menu, Tray, Tip, Modo Mouse: Ativado
        ;TrayTip, Modo Mouse, Ativado (JKLI para mover), 1
        SetTimer, CheckKeys, 10
    } else {
        Menu, Tray, Icon, mouse_off.ico
        ;Menu, Tray, Tip, Modo Mouse: Desativado
        ;TrayTip, Modo Mouse, Desativado, 1
        SetTimer, CheckKeys, Off
    }
    return
}

#If (mouseMode)

; Loop contínuo de verificação de teclas pressionadas
CheckKeys:
{
    speed := 10
    step := 10

    if GetKeyState("Shift", "P") {
        step := 2
        speed := 30
    } else if GetKeyState("Alt", "P") {
        step := 25
        speed := 5
    }

    dx := 0
    dy := 0

    if GetKeyState("j", "P")
        dx -= step
    if GetKeyState("l", "P")
        dx += step
    if GetKeyState("i", "P")
        dy -= step
    if GetKeyState("k", "P")
        dy += step

    if (dx != 0 or dy != 0)
        MouseMove, dx, dy, 0, R

    return
}

; === BLOQUEIO DE DIGITAÇÃO ===
j::return
k::return
l::return
i::return

+J::return
+K::return
+L::return
+I::return

!J::return
!K::return
!L::return
!I::return

; === AÇÕES DO MODO MOUSE ===
u::Click
o::Click right
m::Click middle

h::Send {WheelUp}
n::Send {WheelDown}

; === Travar clique esquerdo com U ===
+U::
{
    if (!isHoldingClick) {
        Send {LButton Down}
        isHoldingClick := true
    } else {
        Send {LButton Up}
        isHoldingClick := false
    }
    return
}


; === Travar clique direito com O ===
+O::
{
    if (!isHoldingRightClick) {
        Send {RButton Down}
        isHoldingRightClick := true
    } else {
        Send {RButton Up}
        isHoldingRightClick := false
    }
    return
}

#If
