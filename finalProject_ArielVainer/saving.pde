void readSave() {
  try {

    File saveFile = new File("finalProject.txt");
    println("Does a save exist? " + saveFile.isFile());
    BufferedReader reader;
    reader = createReader("finalProject.txt");
    try {
      highScore = Integer.valueOf(reader.readLine());
      snHighScore = Integer.valueOf(reader.readLine());
    }
    catch(Exception e) {
      print("No save file found. Loading default set...");
      createSave();
    }
  }
  catch(Exception e) {
    println("Something went wrong with reading our save. Setting default values");
    e.printStackTrace();
  }
}

void createSave() {
  PrintWriter saveWriter;

  println("Creating writer...");
  saveWriter = createWriter("finalProject.txt");
  saveWriter.println(highScore);
  saveWriter.println(snHighScore);
  saveWriter.flush();
  saveWriter.close();
}
