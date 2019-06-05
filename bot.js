console.log("Hola node")
var Twit = require('twit');
var config  = require('./config');
var exec =  require('child_process').exec;
var fs = require('fs');
var T = new Twit(config);
console.log("El bot ha iniciado")
setInterval(tweetear, 1000*10);

function tweetear(){
    
    var cmd  = 'processing-java --sketch="C:/Users/Iván/Desktop/Gif Bot/RenderFractal" --run'
    exec(cmd, processing);

    function processing(){
        var filename = 'RenderFractal/fractal.jpg';
        var params = {
            encoding: 'base64'
        }
        var b64 = fs.readFileSync(filename, params);
        T.post('media/upload', { media_data: b64 }, uploaded);
    }

    function uploaded(err, data, response){
        var id = data.media_id_string;
        fs.readFile('RenderFractal/values.txt', (err, data) => { 
            if (err) throw err;     
            var tweet = {
                status: data.toString(),
                media_ids: [id]
            }
            T.post('statuses/update', tweet, tweeted);
        }) 
    }
    
    function tweeted(err, data, response){
        if(err){
            console.log('Algo salió mal :(');
        }else{
            console.log('Se ha twitteado tu fractal :D');
        }
    }
}

