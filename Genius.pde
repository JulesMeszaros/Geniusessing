import http.requests.*;

//Identifiants Genius
String redirect_uri = "http://www.google.com";
String client_id = "iOTC14N1b5uV7tsVMahE3IbcMhqQTZ4npJOTG2Cx7HSTTShfN7FrHsBFfJpDUtcW";
String client_secret = "HSSfIZ8C065zoHqUYlIS3umZOD6vCSpqzU0sTDmd58-l9tFazsTurcqaCPSh3NSpENHt7MHtR5r0t69gHFO-ZQ";
String client_access_token = "_WZISk_ww6LOUljNXjLykVXv5RjRmH9thaG-tHbIYFjRnkmAm897Xkxy7tseGiUG";

//Creation de la requete
GetRequest get = new GetRequest("https://api.genius.com/search?q=Kendrick%20Lamar");
get.addHeader("Authorization", "Bearer " + client_access_token);

get.send();

println("Reponse Content: " + get.getContent());
println("Reponse Content-Length Header: " + get.getHeader("Content-Length"));
