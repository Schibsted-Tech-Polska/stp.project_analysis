mno.namespace('utils.relativeTime');
/**
 * Show the time relative to input time
 * @param timeValue Timestamp
 * @param relativeTo Optional relative to - time
 */

mno.utils.relativeTime = function(timeValue) {
    var parsedDate = Date.parse(timeValue),
        relativeTo = (arguments.length > 1) ? arguments[1] : new Date(),
        delta = parseInt((relativeTo.getTime() - parsedDate) / 1000);

    if (delta < 60) {
        return 'Mindre enn ett minutt siden';
    } else if (delta < 120) {
        return 'Omtrent ett minutt siden';
    } else if (delta < (45*60)) {
        return (parseInt(delta / 60)).toString() + ' minutter siden';
    } else if (delta < (90*60)) {
        return 'Omtrent en time siden';
    } else if (delta >= 90*60 && delta < 120*60) {
        return 'Omtrent to timer siden';
    } else if(delta < (24*60*60)) {
        return 'Omtrent ' + (parseInt(delta / 3600)).toString() + ' timer siden';
    } else if(delta < (48*60*60)) {
        return '1 dag siden';
    } else {
        return (parseInt(delta / 86400)).toString() + ' dager siden';
    }

};