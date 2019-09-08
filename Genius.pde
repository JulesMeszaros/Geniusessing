import http.requests.*;
import javax.xml.bind.DatatypeConverter;

//Identifiants Genius
String redirect_uri = "http://www.google.com";
String client_id = "iOTC14N1b5uV7tsVMahE3IbcMhqQTZ4npJOTG2Cx7HSTTShfN7FrHsBFfJpDUtcW";
String client_secret = "HSSfIZ8C065zoHqUYlIS3umZOD6vCSpqzU0sTDmd58-l9tFazsTurcqaCPSh3NSpENHt7MHtR5r0t69gHFO-ZQ";
String client_access_token = "_WZISk_ww6LOUljNXjLykVXv5RjRmH9thaG-tHbIYFjRnkmAm897Xkxy7tseGiUG";

//Identifiants Spotify
String clientID = "7e421573603e445bacbe6b5dc300a581";
String clientSecret = "c83c3604f9dd4f90a0ceb8e04e89dfa9";

//Autres infos
String GeniusUrl = "https://api.genius.com";
String SpotifyUrl = "https://api.spotify.com/v1";

void setup() {
  //screen
  background(255, 252, 100);
  size(400, 300);
  
  //borders
  fill(0);
  rect(0, 0, 400, 10);
  rect(0, 0, 10, 300);
  rect(0, 290, 400, 10);
  rect(390, 0, 10, 300);
  
  getSongData("Ottoman", "Vampire Weekend");
}


void getSongData(String song, String artist){
  /*GENIUS*/
  
  //Convertying inputs
  song = song.replace(" ", "%20");
  artist = artist.replace(" ", "%20");
  
  println(song);
  println(artist);
  
  //Requesting results on genius.com for the given input
  GetRequest searchSongRequest = new GetRequest(GeniusUrl + "/search?q=" + song + "%20" + artist);
  searchSongRequest.addHeader("Authorization", "Bearer " + client_access_token);
  
  searchSongRequest.send();
  
  //Saving the first results in a JSON file
  JSONObject results = parseJSONObject(searchSongRequest.getContent()).getJSONObject("response");
  JSONObject bestResult = results.getJSONArray("hits").getJSONObject(0);
  
  saveJSONObject(bestResult, "datas/genius_data.json");
  
  /*SPOTIFY*/
  
  //Creating the request to get access token
  PostRequest tokenRequest = new PostRequest(SpotifyUrl + "/api/token");
  tokenRequest.addData("grant_type", "client_credentials");
  String ID = clientID + ":" + clientSecret;
  String ID64 = DatatypeConverter.printBase64Binary(ID.getBytes());
  tokenRequest.addHeader("Authorization", "Basic " + ID64);
    
  tokenRequest.send();
  
  println(parseJSONObject(tokenRequest.getContent()));
  
  //Creating the request to get the data
  
  //spotifyRequest.send();
}
