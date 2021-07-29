function buildVrcCoordinate(decimal, i) {
    var deg = String(Math.floor(Math.abs(decimal)) * Math.sign(decimal));
    var minDeg = 60 * (Math.abs(decimal) - Math.abs(parseInt(deg)));
    var min = String(Math.floor(minDeg));
    var secDeg = 60 * (minDeg - min);
    var sec = secDeg.toFixed(3).padStart(6, '0');
    var northSouth = deg < 0 ? 'S' : 'N';
    if (i % 2) { northSouth = northSouth.replace('S', 'W').replace('N', 'E'); }
    var vrcItem = `${northSouth}${deg.replace('-','').padStart(3, '0')}.${min.padStart(2, '0')}.${sec}`;

    return vrcItem;
}

// var map = 'decimal coordinates from autocad export, with or without header line';
var spaces ='                          ';
var headerText = 'End Y	End X	Start Y	Start X\n';
var lines = map.replace(headerText, '').split('\n').map(line => line.split('\t')); // string --> array<array<string>>
var vrc = lines.map(line => `${spaces}${line.map((decimal, i) => buildVrcCoordinate(decimal, i)).join(' ')}`).join('\n');
copy(vrc);
console.log('Results copied to clipboard!');