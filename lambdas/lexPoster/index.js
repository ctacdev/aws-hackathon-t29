var request = require('request');

exports.handler = (event, context, callback) => {
    console.log(event)
    callback(null, 'done');
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