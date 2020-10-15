def getToSend(si, ni):
    """
    1. id range in [si, ni)
    2. expiry_at within 48 hours of now (all time in UTC)
    3. campaign is not at ended state. If campaign does not exist, we treat as if it has ended, because it is better to send less than send extra message
    4. The last send message by user is at least 24 hours ago
    sort the result by id
    """

def dedupSender(batch):
    """
    populate user_id -> record case
    """

def send(toSend):
    """
    Convert the entity to the CLM msg format, and send asyncly
    however, we do keep track of error vs success rate
    """

def run():
    minId, maxId = loadCCIdRange()
    if not midId:
        return

    CHECKPOINT_KEY = "cc_scan_id"
    curSi = loadMetaLong(CHECKPOINT_KEY)

    if not curSi:
        curSi = minId
        insertMeta(CHECKPOINT_KEY, curSi)

    while curSi < minId:
        #purge logic can go here in the future
        batch = getToSend(curSi, curSi + batchSize)
        toSend = dedupSender(batch)
        updateLastSent(toSend.keys())
        send(toSend)

        nextSi = curSi + batch

        updateMeta(CHECKPOINT_KEY, nextSi, curSi)
        curSi = nextSi
        

        







