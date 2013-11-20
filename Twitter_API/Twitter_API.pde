//int counter;

TwitterFactory tf;
Twitter twitter;
Query query;
int counter;

PrintWriter output;

void setup() {

  size(640, 480);
  background(0);
  smooth();

  ConfigurationBuilder cb = new ConfigurationBuilder();
  cb.setOAuthConsumerKey("h65HznzMdREESPtUbaH5g");
  cb.setOAuthConsumerSecret("VF1ZYJXCFaglSMDdauNhgPZWdWN4h1ddht0EhL703Qo");
  cb.setOAuthAccessToken("188154178-DjqiH1yamkjM95b3jBu7qWNolVDAxZiqL17gaKiv");
  cb.setOAuthAccessTokenSecret("mxeat7Set1qoGkxioR5xUYPCX8enAa6NxYVNNUW7r3zFt");

  tf = new TwitterFactory(cb.build());
  twitter = tf.getInstance();

  query = new Query("#NWTS");

  output = createWriter("timeline.txt");
  
  getTimeline();
  counter = 0;
}

void draw() {

  background(0);

  counter++;
  //println(counter);

  if (counter == 60) {

    //    try {
    //        //searching key word
    //      QueryResult result = twitter.search(query);
    //      ArrayList tweets = (ArrayList) result.getTweets();
    //
    //      for (int i = 0; i < tweets.size(); i ++) {
    //
    //        Status s = (Status) tweets.get(i);
    //
    //        String user = "" + s.getUser().getScreenName();
    //
    //        println(user);


    //      }
    //    } 
    //    catch (TwitterException te) {
    //
    //      println("Couldn't connect: " + te);
    //    }

    counter = 0;
  }
}

//post a tweet
void keyPressed() {

  try {
    Status status = twitter.updateStatus("testing yet again!");
    println("status posted!");
  } 

  catch (TwitterException te) {
    println("ERROR: " + te);
  }
}

//searches my own timeline and saves it to a document
void getTimeline() {
  try {
    ArrayList<Status> statuses = (ArrayList) twitter.getHomeTimeline();
    println("Showing home timeline");

    for (Status status : statuses) {
      output.println(status.getText());
    }
  }

  catch (TwitterException te) {
    println("ERROR: " + te);
  }
  
  //closes printWriter
  output.flush();
  output.close();
}

