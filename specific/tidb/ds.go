// Status describes the status information of a tidb-binlog node in etcd.
type Status struct {
	// the id of node.
	NodeID string `json:"nodeId"`

	// the host of pump or node.
	Addr string `json:"host"`

	// the state of pump.
	State string `json:"state"`

	// the node is alive or not.
	IsAlive bool `json:"isAlive"`

	// the score of node, it is report by node, calculated by node's qps, disk usage and binlog's data size.
	// if Score is less than 0, means this node is useless. Now only used for pump.
	Score int64 `json:"score"`

	// the label of this node. Now only used for pump.
	// pump client will only send to a pump which label is matched.
	Label *Label `json:"label"`

	// for pump: max commit ts in pump
	// for drainer: drainer has consume all binlog less than or equal MaxCommitTS
	MaxCommitTS int64 `json:"maxCommitTS"`

	// UpdateTS is the last update ts of node's status.
	UpdateTS int64 `json:"updateTS"`
}
