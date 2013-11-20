import blprnt.nytimes.*;

String apiKey = "eca057d2d5c36e250633956adc4d4f64:9:62237943";

ArrayList<Person> people = new ArrayList();
HashMap<String, Person> personHash = new HashMap();

void setup () {
  size(800, 600);
  background(255);
  smooth();

  //Intialize the NYT Article Search Engine
  TimesEngine.init(this, apiKey);
  searchByPerson("GATES, BILL");
}

void draw () {
  background(255);
  for (Person guy:people) {
    guy.update();
    guy.render();
  }
}

void searchByPerson (String id) {
  //Construct a query
  TimesArticleSearch mySearch = new TimesArticleSearch();
  mySearch.addFacetQuery("per_facet", id);
  mySearch.addFacets("per_facet");

  //Do the search and feed it into a result object
  TimesArticleSearchResult myResult = mySearch.doSearch();

  //Get info from a requested facet
  TimesFacetObject[] facets = myResult.getFacetList("per_facet");
  for (int i = 0; i < facets.length; i++) {
    //We have the data - lets deal with it
    String linkId = facets[i].term;
    Person dude;
    //Do I already have a person with this id?
    if (personHash.containsKey(linkId)) {
      //YES!
      dude = personHash.get(linkId);
    } 
    else {
      //No.
      dude = new Person();
      dude.id = linkId;
      people.add(dude);
      personHash.put(linkId, dude);

      dude.tpos.x = random(width);
      dude.tpos.y = random(height);
    }
    //Link this new person with the person that we searched for
    Person searchDude = personHash.get(id);
    dude.generation = searchDude.generation += 1;
    searchDude.links.add(dude);
    //personHash.get(id).links.add(dude);
    
    //If were in the first generation, lets do a search on our new dude.
    if (dude.generation < 2) searchByPerson(linkId);
    
  }
}

