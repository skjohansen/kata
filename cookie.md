# Cookie cutter

This cookie cutter is done for doing katas and consist of a console application which is mainly for prsenting the logic.

The logic for tha actual kata is placed in the logic part.

The cookie cutter is based on a github template repo.

## Init

Start by renaming the files and projects by: `cookie-rename.ps1 NEW-NAME`

## Console

Scripts requires powershell

Install prerequisits: `dotnet tool restore`

Run tests: `dev-run-tests.ps1`

Watch coverage (do it in a serperate terminal): `dev-watch-coverage.ps1`

If a cleanup after renaming or other is needed the `cookie-cleanup.ps1` can be used.

## Git commit

Use conventional git as follows:
* feat(red):
* feat(green):
* refactor:

When starting and ending a pomodoro do an empty commit: `git commit --allow-empty -m "Start pomodoro"`