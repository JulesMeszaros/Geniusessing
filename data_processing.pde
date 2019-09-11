void getSongData(String song, String artist){
  /*GENIUS*/
  
  //Convertying inputs
  song = song.replace(" ", "%20");
  artist = artist.replace(" ", "%20");
  
  //Requesting results on genius.com for the given input
  GetRequest searchSongRequest = new GetRequest(GeniusUrl + "/search?q=" + song + "%20" + artist);
  searchSongRequest.addHeader("Authorization", "Bearer " + client_access_token);
  
  searchSongRequest.send();
  
  //Saving the first results in a JSON file
  JSONObject results = parseJSONObject(searchSongRequest.getContent()).getJSONObject("response");
  JSONObject bestResult = results.getJSONArray("hits").getJSONObject(0);
  
  saveJSONObject(bestResult, "song_datas/genius_data.json");
  
  /*SPOTIFY*/
  
  //Creating the request to get access token
  PostRequest tokenRequest = new PostRequest(SpotifyUrl + "/api/token");
  tokenRequest.addData("grant_type", "client_credentials");
  String ID = clientID + ":" + clientSecret;
  String ID64 = DatatypeConverter.printBase64Binary(ID.getBytes());
  tokenRequest.addHeader("Authorization", "Basic " + ID64);
    
  //tokenRequest.send();
  
  //println(parseJSONObject(tokenRequest.getContent()));
  
  //Creating the request to get the data
  
  //spotifyRequest.send();
}

void getLyrics(String path) {
  //Function used to get the lyrics of a song using genius datas. The genius data path is given as a parameter.
  
  //First we get the url of the song 
  String songURL = loadJSONObject(path).getJSONObject("result").getString("url");
  
  //We get the HTML of the genius page of the song
  GetRequest genius = new GetRequest(songURL);
  genius.send();
   
  //Getting the HTML of the page and scrapping the HTML to only get the lyrics class
  String rawHTML = genius.getContent();
  String HTMLlyrics = rawHTML.substring(rawHTML.indexOf("<div class=\"lyrics\">"), rawHTML.indexOf("<div initial-content-for=\"recirculated_content\">"));
  
  //Deleteing every HTML tag and brackets in the HTMLlyrics String
  while(HTMLlyrics.contains("<")){
    HTMLlyrics = deleteString(HTMLlyrics, "<", ">");
  }
  
  while(HTMLlyrics.contains("[")){
    HTMLlyrics = deleteString(HTMLlyrics, "[", "]");
  }
  
  String[] lyrics = split(HTMLlyrics, "\n");
  StringList lyricsList = new StringList();
  
  for(String line : lyrics){
    lyricsList.append(line);
  }
  //formating the txt file (removing the empty lines at the beginning and the end of the file)
  for(int i = 1; i<=4; i++){
    lyricsList.remove(0);
  }
  
  for(int i = 1; i<=9; i++){
    lyricsList.remove(lyricsList.size() - 1);
  }
  
  String[] formatedLyrics = {};
  
  for(String line : lyricsList){
    formatedLyrics = append(formatedLyrics, line); 
  }
  
  saveStrings("song_datas/lyrics.txt", formatedLyrics);
}

String deleteString(String baseString, String firstString, String secondString){
  //Fonction taking three strings as parameters. The function deletes every characters of the first parameter located between the second and the third parameters
  
  String newString = new String();
  String firstPart = baseString.substring(0, baseString.indexOf(firstString));
  String secondPart = baseString.substring(baseString.indexOf(secondString) + secondString.length(), baseString.length());
  String[] parts = {firstPart, secondPart};
  
  newString = join(parts, "");
  
  return newString;
}


StringList lyricsArray(String path){
  StringList songArray = new StringList();
  
  String[] lyrics = loadStrings(path);
  //Creating a list with all the words in the lyrics
  for(String line:lyrics){
    for(String word:splitTokens(line, ", ()-\"—'._?")){
      songArray.append(word);
    }
  }
  
  println(songArray.size());
  
  return songArray;
}

void drawGrid(StringList lyrics){
  int wordCount = lyrics.size();
  
  int wordCount1 = 1;
  int wordCount2 = 1;
  
  for(String word1 : lyrics){
   for(String word2 : lyrics){
    if(lyrics.get(wordCount1 -1) == lyrics.get(wordCount2 -1)){
     //println(lyrics.get(wordCount1 -1), lyrics.get(wordCount2 -1), ": yes"); 
    } else {
      //println(lyrics.get(wordCount1 -1), lyrics.get(wordCount2 -1), ": no");
   }
   wordCount2 ++;
  }
  wordCount2 = 1;
  wordCount1 ++;
 }
}
