RetryPolicy retryPolicy = new ExponentialBackoffRetry(1000, 3);
//only one CuratorFramework for each ZK cluster
CuratorFramework client = CuratorFrameworkFactory.newClient(zookeeperConnectionString, retryPolicy);
client.start();

client.create().forPath("/my/path", myData);

//distributed lock
InterProcessMutex lock = new InterProcessMutex(client, lockPath);
if ( lock.acquire(maxWait, waitUnit) ) 
{
  try 
  {
    // do some work inside of the critical section here
  }
  finally
  {
    lock.release();
  }
}

//leader election
LeaderSelectorListener listener = new LeaderSelectorListenerAdapter()
{
  public void takeLeadership(CuratorFramework client) throws Exception
  {
    // this callback will get called when you are the leader
    //         // do whatever leader work you need to and only exit
    //                 // this method when you want to relinquish leadership
  }
}

LeaderSelector selector = new LeaderSelector(client, path, listener);
selector.autoRequeue();  // not required, but this is behavior that you will probably expect
selector.start();
