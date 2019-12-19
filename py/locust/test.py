from locust import HttpLocust, TaskSet, task, TaskSequence, seq_task

def msg(l):
    #client interface is very similar to the default httpclient, it returns stock python response object
    l.client.get("/mockservice/msg")

class UserBehavior(TaskSequence):
    """A locust class represents one user (or a swarming locust if you will). Locust will spawn (hatch) one instance of the locust class for each user that is being simulated."""

    #number in seq_task means the step
    @seq_task(1)
    def get_message(self):
        #common to pass the self to a purely funcation method
        msg(self)


class WebsiteUser(HttpLocust):
    task_set = UserBehavior
    min_wait = 5000
    max_wait = 9000
    #can config it instead of passing command line
    host="https://YOUR_HOST_HERE"
