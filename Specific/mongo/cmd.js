sudo mongod --profile 2 --slowms 1000

db.system.profile.find({ns:/blog.posts/}).sort({ts:-1}).limit(1).pretty()

db.system.profile.find().sort({ts:-1}).limit(1).pretty()

db.posts.createIndex({"date" : -1, "tags" : 1} ) 

db.posts.createIndex({"tags" : 1, "date" : -1} ) 

db.posts.createIndex({"date" : -1} ) 

db.posts.createIndex({"permalink" : -1}) 

--------

db.sysprofile.find().limit(1)

db.profile.find().sort({"millis" : -1}).limit(3)


db.students.find().limit(1).pretty()

db.system.profile.find().limit(1).pretty()

db.system.profile.find({ns:/school2.students/}).limit(1).pretty()


db.system.profile.find({ns:/school2.students/}).sort({ts:-1}).limit(1).pretty()

-------

db.zips.aggregate([
	{
		$group: {
			_id : { city : "$city", state: "$state"},
			count : {$sum : "$pop"}
		}

	},
	{
		$match : { $and:  [
			{	"count" : {$gt : 25000} },
			{
				$or :[ {
					"_id.state" : "CT"},
					{"_id.state" : "NJ"
					}]
			}

		]
		}
	},
	{
		$group : {
			_id : null,
			avg : {$avg : "$count"}
		}
	}
])

--------------
db.grades.find().limit(1).pretty()

1. calcualte average for each student
2. calucate class average

db.grades.aggregate([
	{$unwind: "$scores" },
	{$match : { $or :[ 
		{ "scores.type" : "exam"},
		{ "scores.type" : "homework"}
	]
	}},
	{$group : { _id : { student: "$student_id", "class" : "$class_id" },
		avg : {$avg : "$scores.score" }
	}},
	{$group : { 
		_id : {"class" : "$_id.class" },
		avg : {$avg : "$avg" }
	}},
	{ $sort : { avg: -1 }
	}
])
