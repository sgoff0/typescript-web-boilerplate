import '../utils/env';
import 'source-map-support/register'

import * as tracer from 'tracer';
import * as Colors from 'colors';

const monthNames = Object.freeze(['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec']);

function getLogTimeStamp() {
    const date = new Date();
    const month = monthNames[date.getMonth()];
    const seconds = date.getSeconds();
    let secondsText = seconds + "";
    if (seconds < 10) {
        secondsText = '0' + seconds;
    }
    return date.getDate() + ' ' + month + ' ' + date.getFullYear() + ' ' + date.getHours() +
        ':' + date.getMinutes() + ':' + secondsText + '.' + date.getMilliseconds();
}

const logLevel = process.env.LOG_LEVEL || 'info';
export default tracer.colorConsole({
    format: '{{timestamp}} [{{title}}] - [{{file}}:{{line}}] - {{message}}',
    preprocess: function (data) {
        data.title = data.title.toUpperCase();
        data.timestamp = getLogTimeStamp();
    },
    filters: {
        debug: Colors.magenta,
        info: Colors.green,
        warn: Colors.yellow,
        error: Colors.red
    },
    level: logLevel
})
