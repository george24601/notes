ThreadPoolExecutor.worker implements Runnable, i.e., itself is a thread

SHUTDOWN: shoutdown()
STOP: shhutdownNow()
TIDYING: all tasks completed
TERMINIATED: termiated()

For ways to handle ex

1. try-catch
2. submit to execute, Future.get to handle ex
3. TPE.afterExecute
4. passin Thread.UncaughtExceptionHandler
