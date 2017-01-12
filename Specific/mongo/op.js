db.messages.count()

db.messages.find().limit(1).pretty()

db.messages.aggregate([
	{ $unwind : "$headers.To"},
	{
		$group : {
			_id: { from: "$headers.From", to: "$headers.To", eid: "$_id" },
			count : {$sum : 0}

		}
	},
	{
		$group : {
			_id : { from: "$_id.from", to: "$_id.to" },
			count : {$sum : 1}
		}
	},{
		$sort : { count : -1}
	}

],
	{ allowDiskUse : true}
)
----------


db.messages.find( 
	{ 
		"headers.Message-ID": "<8147308.1075851042335.JavaMail.evans@thyme>"
	}).pretty()

	.count()


db.messages.update( 
	{ 
		"headers.Message-ID": "<8147308.1075851042335.JavaMail.evans@thyme>"
	},
	{
		$push : {
			"headers.To" : "mrpotatohead@mongodb.com"
		}
	}
)

--------

db.products.find().limit(1).pretty()

db.products.find({_id : ObjectId("507d95d5719dbef170f15c00")}).limit(1).pretty()

db.products.update({_id : ObjectId("507d95d5719dbef170f15c00")}, {$set : { "term_years" : 3, "limits.sms.over_rate" : 0.01}});

db.products_bak.find({"limits.voice": {$exists: false} }).count()

db.products.find().limit(3).pretty()

db.products.createIndex( {for: 1 })

exp = db.products.explain("executionStats")

exp.find( {for: "ac3" })





