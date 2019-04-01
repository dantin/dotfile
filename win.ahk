#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

LWin & s::Send {LCtrl down}{s}
LWin & c::Send {LCtrl down}{c}
LWin & v::Send {LCtrl down}{v}
LWin & x::Send {LCtrl down}{x}

LWin & f::Send {LCtrl down}{f}

LAlt & h::Send {Left}
LAlt & l::Send {Right}
LAlt & j::Send {Down}
LAlt & k::Send {Up}