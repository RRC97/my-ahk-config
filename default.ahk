#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

CapsLock::Esc
Esc::`

^CapsLock::CapsLock

#SingleInstance Force
#NoEnv
SetWorkingDir %A_ScriptDir%

mouseMode := false
isHoldingClick := false

; Ícones para tray, você coloca os seus .ico na pasta do script
iconOn := A_ScriptDir . "\mouse_on.ico"
iconOff := A_ScriptDir . "\mouse_off.ico"

; Ícone inicial
Menu, Tray, Icon, %iconOff%
Menu, Tray, Tip, Modo Mouse: Desativado

^!m::  ; Ctrl + Alt + M ativa/desativa modo mouse
{
    mouseMode := !mouseMode
    if (mouseMode) {
        Menu, Tray, Icon, %iconOn%
        Menu, Tray, Tip, Modo Mouse: Ativado
        TrayTip, Modo Mouse, Ativado (JKLI para mover), 1
    } else {
        Menu, Tray, Icon, %iconOff%
        Menu, Tray, Tip, Modo Mouse: Desativado
        TrayTip, Modo Mouse, Desativado, 1
    }
    return
}

#If (mouseMode)

; Função para mover o mouse continuamente enquanto tecla está pressionada
MoveMouseContinuous(dx, dy, speed := 10) {
    SetKeyDelay, -1  ; acelera a repetição
    while GetKeyState(A_ThisHotkey, "P") {
        MouseMove, dx, dy, 0, R
        Sleep, speed
    }
}

; Ao pressionar J, K, L, I, chama o loop contínuo de movimento

j::
    MoveMouseContinuous(-10, 0, 20)
return

l::
    MoveMouseContinuous(10, 0, 20)
return

i::
    MoveMouseContinuous(0, -10, 20)
return

k::
    MoveMouseContinuous(0, 10, 20)
return

; Shift para movimentos mais lentos

+j::
    MoveMouseContinuous(-2, 0, 30)
return

+l::
    MoveMouseContinuous(2, 0, 30)
return

+i::
    MoveMouseContinuous(0, -2, 30)
return

+k::
    MoveMouseContinuous(0, 2, 30)
return

; Alt para movimentos mais rápidos

!j::
    MoveMouseContinuous(-25, 0, 10)
return

!l::
    MoveMouseContinuous(25, 0, 10)
return

!i::
    MoveMouseContinuous(0, -25, 10)
return

!k::
    MoveMouseContinuous(0, 25, 10)
return

; Cliques simples

u::Click
o::Click right
m::Click middle

; Scroll

h::Send {WheelUp}
n::Send {WheelDown}

; Travar clique para arrastar com P

p::
{
    if (!isHoldingClick) {
        MouseClick, left,,,1, D
        isHoldingClick := true
        TrayTip, Modo Mouse, Clique esquerdo segurado, 1
    } else {
        MouseClick, left,,,1, U
        isHoldingClick := false
        TrayTip, Modo Mouse, Clique liberado, 1
    }
    return
}

#If
