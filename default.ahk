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

; Caminhos dos ícones da tray
iconOn := A_ScriptDir . "\mouse_on.ico"
iconOff := A_ScriptDir . "\mouse_off.ico"

; Ícone inicial
Menu, Tray, Icon, %iconOff%
Menu, Tray, Tip, Modo Mouse: Desativado

; Atalho para alternar modo (Ctrl + Alt + M)
^!m::
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

; ===== Movimentação do Mouse =====
j::MouseMove, -10, 0, 0, R
l::MouseMove, 10, 0, 0, R
i::MouseMove, 0, -10, 0, R
k::MouseMove, 0, 10, 0, R

+J::MouseMove, -2, 0, 0, R
+L::MouseMove, 2, 0, 0, R
+I::MouseMove, 0, -2, 0, R
+K::MouseMove, 0, 2, 0, R

!j::MouseMove, -25, 0, 0, R
!l::MouseMove, 25, 0, 0, R
!i::MouseMove, 0, -25, 0, R
!k::MouseMove, 0, 25, 0, R

; ===== Cliques =====
u::Click                   ; Clique esquerdo
o::Click right            ; Clique direito
m::Click middle           ; Clique do botão scroll

; ===== Scroll =====
h::Send {WheelUp}
n::Send {WheelDown}

; ===== Travar/soltar clique esquerdo (para arrastar)
p::
{
    if (!isHoldingClick) {
        MouseClick, left, , , , D ; Pressiona e segura
        isHoldingClick := true
        TrayTip, Modo Mouse, Clique esquerdo segurado, 1
    } else {
        MouseClick, left, , , , U ; Solta o clique
        isHoldingClick := false
        TrayTip, Modo Mouse, Clique liberado, 1
    }
    return
}

#If
