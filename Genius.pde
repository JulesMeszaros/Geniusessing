import http.requests.*;
import javax.xml.bind.DatatypeConverter;
import interfascia.*;

//Identifiants Genius
String redirect_uri = "http://www.google.com";
String client_id = "iOTC14N1b5uV7tsVMahE3IbcMhqQTZ4npJOTG2Cx7HSTTShfN7FrHsBFfJpDUtcW";
String client_secret = "HSSfIZ8C065zoHqUYlIS3umZOD6vCSpqzU0sTDmd58-l9tFazsTurcqaCPSh3NSpENHt7MHtR5r0t69gHFO-ZQ";
String client_access_token = "_WZISk_ww6LOUljNXjLykVXv5RjRmH9thaG-tHbIYFjRnkmAm897Xkxy7tseGiUG";

//Identifiants Spotify
String clientID = "b901fe7590da4cc28fd79b0c5c53f1b5";
String clientSecret = "5ee0a23854e64ae0bf0bed1db0ce5a77";

//Autres infos
String GeniusUrl = "https://api.genius.com";
String SpotifyUrl = "https://api.spotify.com/v1";

void setup() {
  //screen setings
  background(255, 252, 100);
  size(650, 650);
  
  getSongData("gucci gang", "");
  getLyrics("song_datas/genius_data.json");
  drawGrid(lyricsArray("song_datas/lyrics.txt"));
  
  line(0, 700, width, 700);
}

void draw(){
  
}
