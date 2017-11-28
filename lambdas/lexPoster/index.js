var request = require('request');

function getSeverity(level){
    if(level === 'extreme' || level === 'unknown'){
        return 'An ' + level + ' ';
    } else{
        return 'A ' + level + ' ';
    }
}

function getCategory(cat){
    switch(cat){
        case 'geo': return 'Geophysical';
        case 'security': return 'Law Enforcement, military, or homeland/private security';
        case 'other': return 'Other';
        case 'safety': return 'General Emergency';
        case 'fire': return 'Fire Suppression and Rescue';
        case 'health': return 'Medial and Public Health';
        case 'transport': return 'Pollution and Environmental';
        case 'infra': return 'Utility or Telecommunication';
        case 'cbrne': return 'Chemical, Biological, Rediological, Nuclear, or Explosive';
        case 'env': return 'Pollution or Environmental';
        case 'met': return 'Meteorological';
        case 'rescue': return 'Rescue and Recovery';
    }
}

function getCertainty(certainty){
    switch(certainty){
        case 'likely': return 'is likely to occur.';
        case 'unlikely': return 'is unlikely to occur.';
        case 'possible': return 'can possibly occur.';
        case 'observed': return 'was observed to have occured.';
        case 'unknown': return 'uncertain if it has/will occur.';
    }
}

exports.handler = (event, context, callback) => {
    console.log(JSON.stringify(event))
    var response = {
        sessionAttributes:{},
        dialogAction: {
            fulfillmentState: "Fulfilled", //or Failed
            type: "Close"
        }
    }

    var eventMessage = getSeverity(event.currentIntent.slots.severity) +
        getCategory(event.currentIntent.slots.category) + ' ' +
        event.currentIntent.slots.messageType + ' has been issued. ' +
        'Affecting the ' + event.currentIntent.slots.address + ' area, this event ' +
        getCertainty(event.currentIntent.slots.certainty) + ' ' +
        'Urgency: ' + event.currentIntent.slots.urgency + '.'

    console.log(eventMessage);

    callback(null, response);

    // request.post('http://www.example.com', {
    //     json: { key: 'value' }
    // }, function (error, response, body) {
    //         if (error){
    //             console.log(body)
    //             callback(null, 'Error');
    //         }
    //         if (!error && response.statusCode == 200) {
    //             console.log(body)
    //             callback(null, 'Complete');
    //         }
    //     }
    // );
};
