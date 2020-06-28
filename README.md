# tvdb-organiser

Just a simple script that takes a folder full of files with explicit absolute numbers, and renames them to TVDB Seasons.

Run in the directory with the files in, as so:

./tvdb-organiser.sh SERIESID filetype

This will produce the proper "mv" commands in order to rename correctly. To confirm, pipe through to bash:

./tvdb-organiser.sh SERIESID filetype | bash

Get the SERIESID from TvDB itself. For example, for One Piece, you would go to:

https://thetvdb.com/series/one-piece

Then the series ID would be 81797.
