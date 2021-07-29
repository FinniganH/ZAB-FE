function convertSct2LatOrLonToDecimal(latOrLon) {
	var negativeCharacters = ['S', 'W'];
	var sign = negativeCharacters.some((char) => latOrLon.includes(char)) ? -1 : 1;
	var [deg, min, sec, decSec] = latOrLon.replace('N', '').replace('S', ' ').replace('W', ' ').replace('E', ' ').split('.');
	deg = parseInt(deg);
	min = parseInt(min);
	sec = parseFloat(`${sec}.${decSec}`);
	var totalDegrees = (deg + (min / 60) + (sec / 60 / 60)) * sign;

	return totalDegrees.toFixed(8);
}

function buildAutocadLineCommandsFromSct2Map(sct2) {
	var autocadCommands = sct2.split('\n').map((line) => {
		var [lat1, lon1, lat2, lon2] = line.trim().split(' ').map((latOrLon) => convertSct2LatOrLonToDecimal(latOrLon));

		return `LINE ${lon1},${lat1} ${lon2},${lat2}`;
	})

	return autocadCommands;
}

// var sct2 = 'map lines from *.sct2, excluding title row';
var autoCadCommands = buildAutocadLineCommandsFromSct2Map(sct2);
copy(autoCadCommands.join('\n'));
console.log(`AutoCad line commands for ${autoCadCommands.length} lines copied to clipboard!`);