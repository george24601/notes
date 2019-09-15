To loop over two or more sequences at the same time, the entries can be paired with the zip() function.

can use == to compare strings

None, False, 0, "", (), [] are all False. Others are true

since you don’t have to declare if a function is void or if it returns something, the language won’t check to make sure you didn’t forget to return something.

In Python, all input is just gotten from the input() function, which you do not need to import. As a parameter to the input function, you give the prompt for the user.

dir is a function that will not be useful in your actual code, per se. However, it’s exceptionally useful when you’re dealing with some kind of new object, and you want to find out what kind of attributes it has.

help() is a function similar to dir(), in that it’s useful for debugging and quick testing. When you pass it a function, it will show you the docstring help text for that function.

So you can get the last item with nums[-1]. So much nicer than nums[nums.length-1], right!?

pop() is an interesting method - it returns the last item of a list, but also removes it from the list
nums.append(x) will add the item x to the end of nums.

Sort of like range, reversed takes in a list, and returns an iterator with the reverse of a list. an iterator is another kind of lazy object that you can loop over.

new_grades = [x+10 for x in grades]

even_nums = [x for x in nums if x%2==0]

You can also always convert a list to a tuple using the tuple, or a tuple to a list using the list function

Note that strings can be single quotes, or double quotes. Multiline strings can be three single quotes or three double quotes as well, you just have to be consistent.

Probably the most useful string function that I know of is split, which splits a string into a list, based on whatever separator you give it. If you don’t give split a parameter, it just splits on the space.


