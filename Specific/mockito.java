
class Sample{

  public void ex() {

    //verify simple invocation on mock
    mockedList.size();
    verify(mockedList).size();

//verify an interaction has not occurred
    List<String> mockedList = mock(MyList.class);
    mockedList.size();
    verify(mockedList, never()).clear();

    //verify number of interactions with mock
    mockedList.size();
    verify(mockedList, times(1)).size();

    //use spy to mock only those methods of a real object that we want to
  }
}
