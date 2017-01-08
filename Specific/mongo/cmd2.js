show collections

db.posts.find({
	comments : {$elemMatch : { author: "Mariela Sherer" }}

}).limit(1).pretty()

db.posts.aggregate([
	{
		$unwind : "$comments"
	},
	{
		$group:{
			_id : "$comments.author",
			count : {$sum : 1}
		}
	},{
		$sort:{ "count" : -1
		}

	}
])

---------
calculate populate by city, then filter out city <= 25000, then ave city by state

db.zips.find().limit(1).pretty()

db.zips.aggregate([
	{
		$group: {
			_id : { city : "$city", state: "$state"},
			count : {$sum : "$pop"}
		}

	},
	{
		$match : { $and [
			{	"count" : {$gt : 25000} },
			{
				$or :[ {
					"$id.state" : "CA"},
					{"$id.state" : "NY"}
				}]
		}

		]
	}

}
},
	{
		$group : {
			_id : null,
			avg : {$avg : "$count"}
		}
	}
])
------------

db.zips.find().limit(1).pretty()

db.zips.aggregate([
	{$project:
		{ 
			first_char: {$substr : ["$city",0,1]},
			pop: "$pop"
		},
	},
	{
		$match: { $and : [
			{first_char :  {$gte : "0"}},
			{first_char :  {$lte : "9"}},
		]
		}
	},
	{$group : 
		{
		_id : null,
		sum :{$sum:  "$pop"}

		}
	}
])

