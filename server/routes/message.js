var express = require('express');
var router = express.Router();

router.get('/:message?', function(req, res, next) {
    res.json(getMessageData(req.params.message))
});

function getMessageData(message) {
    if (message != null || message != ' ') {
        return {
            message: {
                sender: 'Ahdab Serhan',
                data: message
            }
        }
    } else {
        return alert('You cannot send empty message !!');
    }
}
module.exports = router;