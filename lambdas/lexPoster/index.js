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

function titleCase(string) {
    return string.charAt(0).toUpperCase() + string.slice(1);
}

exports.handler = (event, context, callback) => {
    // console.log(JSON.stringify(event))
    var lexResponse = {
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

    var status = 'Actual'
    if(event.currentIntent.slots.statusType){
        status = event.currentIntent.slots.statusType;
    }

    var payload = {
    	alert:{
    		identifier:new Date().getTime() + '',
    		sender: 'ABC123def',
    		sent:new Date().toISOString(),
    		status:status,
    		msgType:event.currentIntent.slots.messageType,
    		scope:event.currentIntent.slots.scope,
    		infos:[
    			{
    				categories:[titleCase(event.currentIntent.slots.category)],
    				// event:eventMessage,
    				event:event.currentIntent.slots.event,
    				urgency:titleCase(event.currentIntent.slots.urgency),
    				severity:titleCase(event.currentIntent.slots.severity),
    				certainty:titleCase(event.currentIntent.slots.certainty),
    				senderName:event.currentIntent.slots.name,
                    areas:[
        				{
        					areaDesc:'Alert Location',
        					geocodes:[
        						{
        							ZipCode:event.currentIntent.slots.address
        						}
        					]
        				}
        			]
    			}
    		]
    	}
    }

    console.log('Sending payload:');
    console.log(JSON.stringify(payload));

    request.post('https://fiademo.ctacdev.com/api/v1/cap_alerts', {
        json: payload
    }, function (error, response, body) {
            console.log('Done sending...');
            console.log('error:' + error);
            console.log('response:' + JSON.stringify(response));
            console.log('body:' + JSON.stringify(body));
            if (error){
                console.log(body)
                callback(null, 'Error');
            } else if (!error && response.statusCode == 201) {
                console.log(body)
                callback(null, lexResponse);
            }
        }
    );
    callback(null, lexResponse);
};
