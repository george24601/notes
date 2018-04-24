/*
 A common anti-pattern is mocking a type you do not own, because their behavior often changes and is beyond your control. One solution is to create a light weight wrapper around external lib/types. However, if your wrapper just forwards data without transforming input/output, then the wrapper and the mock of it has little sense to exist,i.e., the abstraction is redundant. You should use normal integration testing
 */

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
