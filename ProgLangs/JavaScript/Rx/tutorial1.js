newReleases.forEach(
		function (newRelease)
		{
			videoAndTitlePairs.push({
				"id":newRelease.id,
				"title":newRelease.title
				}
				);
		}
		);

//4: implement map
 results.push(projectionFunction(itemInArray));

//5
newReleases.map(
    function (newRelease)
    {
      return {
        "id" : newRelease.id,
        "title": newRelease.title
      }
    }
    );

//6
newReleases.forEach(
    function(newRelease)
    {
       if(newRelease.rating === 5.0)
         videos.push(newRelease);
    }
  );

//7.
    if(predicateFunction(itemInArray))
      results.push(itemInArray);

//8
newReleases.filter(
    function(newRelease)
    {
      	return newRelease.rating === 5.0;
    }
    ).map(
    function(newRelease)
    {
      return newRelease.id;
    }
    );

//9
 movieLists.forEach(
    function(movieList)
    {
      	movieList.videos.forEach(
          function(video)
          {
            allVideoIdsInMovieLists.push(video.id);
          }
        );
    }
    );

//10
 subArray.forEach(
      function(item)
      {
        results.push(item);
      }
      );

//11
return movieLists.map(
    function(movieList)
    {
      return movieList.videos.map(
        function(video)
        {
          return video.id;
        }
        );
    }
    ).concatAll();

//12
movieLists.map
    (
      function(movieList)
      {
        return movieList.videos.map(
          function(video)
          {
            return video.boxarts.filter(
              function (boxart)
              {
                	return boxart.width === 150 && boxart.height === 200;
              }
              
              ).map(
              function(boxart)
              {
                return {
                  "id": video.id,
                  "title":video.title,
                  "boxart":boxart.url
                  
                };
              }
              );
            
          }
          
          ).concatAll();
      }
      ).concatAll();// Complete this expression!

//13
// projectionFunctionThatReturnsArray(item);

//14
movieLists.concatMap
    (
      function(movieList)
      {
        return movieList.videos.concatMap(
          function(video)
          {
            return video.boxarts.filter(
              function (boxart)
              {
                	return boxart.width === 150 && boxart.height === 200;
              }
              
              ).map(
              function(boxart)
              {
                return {
                  "id": video.id,
                  "title":video.title,
                  "boxart":boxart.url
                  
                };
              }
              );
            
          }
          
          );
      }
      );// Complete this expression!

//17
ratings.
    reduce(function (acc, cur){
      return acc > cur ? acc : cur;   
    });

//18
boxarts.reduce(function (acc, cur)
           {
             return acc.width * acc.height > cur.width * acc.height ? acc : cur;
           }).map(function(boxart){
      return boxart.url;
    }
      );
//19
//copyOfAccumulatedMap[video.id] = video.title;

//20
movieLists.
		concatMap(function(movieList) {
      return movieList.videos.concatMap(function(video)
                           {
                             	 return video.boxarts.reduce(
                                function(acc, cur)
                                {
                                   return acc.width * acc.height > cur.width * cur.height? cur: acc;
                                }  
                              ).map(function(boxart)
                                    {
                            
                             return {
                               "id" : video.id,
                               "title":video.title,
                               "boxart":boxart.url
                             };
                                    })
                           });
		});

//21
  videoIdAndBookmarkIdPairs.push(
      {
        "videoId" : videos[counter].id,
        "bookmarkId": bookmarks[counter].id
      }
      
    );

//22
// results.push(combinerFunction(left[counter], right[counter]));

//23
 Array.
		zip(videos, bookmarks, function (left, right)
        {
          return {
            "videoId":left.id,
            "bookmarkId":right.id
          };
        });

//25
lists.map(function(list){
    return {
      "name": list.name,
      "videos": videos.filter(
        function(video){
          return video.listId === list.id;
        }).map(function(v){
        return {
          "id" : v.id,
          "title":v.title
        };
        
      })
      
      
    };
  });

