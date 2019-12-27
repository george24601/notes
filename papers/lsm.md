A directory node structure for the C1 tree is created in memory buffers as successive leaf nodes are added, with details explained below.

C1 directory nodes are forced to new positions on disk when:
o A multi-page block buffer containing directory nodes becomes full
o The root node splits, increasing the depth of the C1 tree (to a depth greater than two) o A checkpoint is performed

 Whenever a complete flush of all buffered nodes to disk is required, all buffered information at each level must be written to new positions on disk (with positions reflected in superior di- rectory information, and a sequential log entry for recovery purposes)


* deletion and update case
* cost estimation
