#!/bin/bash
# Given a file directory full of hard-coded numbers, in XXXX format, ie 0001 to 1234
# This will search TheTVDB's API to find the correct Season/Episode ordering,
# So that it will work correctly when loading files to Plex
#
# By default, this will just print the "mv" commands. Pipe the output through to bash to confirm.

function getInfo()
{
    SERIES_ID=$1
    ABSOLUTE_EPISODE_NUMBER=$2
    FILETYPE=$3
    JSON_VALUE=$(curl -X GET --header 'Accept: application/json' 'https://api.thetvdb.com/series/'$SERIES_ID'/episodes/query?absoluteNumber='$ABSOLUTE_EPISODE_NUMBER'' 2>/dev/null)
    SEASON=$(jq .data[0].airedSeason <<< $JSON_VALUE)
    NUMBER=$(jq .data[0].airedEpisodeNumber <<< $JSON_VALUE)
    #mv "${EpisodeNum}.mkv" "S${SEASON}E${NUMBER}.mkv"
    echo "mv ${EpisodeNum}.${FILETYPE} S${SEASON}E${NUMBER}.${FILETYPE}"
}

SERIESID=$1
FILETYPE=$2
EPISODES=$(find . -regex ".*/[0-9]+\..*" | grep "$FILETYPE" | awk -F"/" '{print $NF}' | sed 's/\.'$FILETYPE'//g')
for EpisodeNum in $EPISODES
do
	getInfo $SERIESID $EpisodeNum $FILETYPE
done
#getInfo $1 $2
