Hash Splitter
=============
This is a simple JavaScript (CoffeeScript) function that splits any hex string into array of integer values you want. In every single call, the output values will be the same when the input is the same, therefore you can use this function to generate unique and static values for any purposes, such as generating unique avatars for the users. The hex string can be just a hash such as MD5, SHA1, etc., or can be a binary file in hex string form (if your JavaScript host enough to hold it, of cause) or even just some random numbers. The length of the hex string is not important as this function is works with any input length.

The original version of this program is used to be the core module in [Automatic Avatars](https://avatars.moe), and I would like to make it standalone and open-source package for everyone to use.

Usage
-----
`returns = splitHash(hash, fragments);`

**hash**: The input hex string, usually is a hash.

**fragments**: The array of the max values you expected to get, we call this "fragment masks". See tutorial for more information.

**returns**: The array of values based on the fragment array and hex string you provided.

### Basic usage
In this section, I will demostrate what you will get in certain situations.

If I want to get 3 values limited to *0-2*, then I should put this into fragment:

`[3, 3, 3]`

Then you will get an array with 3 values such as: `[1, 0, 2]`

If I want to get 5 values, the first one limited to *0-2*, the second one *0-100*, the rest is *0-4*:

`[3, 101, 5, 5, 5]`

### Advanced usage
This function supports selectors and grouped fragments too. The selectors can generate different values in different situation controlled by the input, it reads a single value while entered the selector, and "selects" different fragment mask, therefore the output can be more variable. The grouped fragments can be used with selectors, this is a way to give another array of values in controlled situation.

In order to use selectors, just use a sub-array to group the situation inside the fragments.

If I want to get 2 values, the first value sometimes gives me *0-2* and sometimes *0-12*, and the second one should be in *0-4*:

`[..., [3, 13], 5, ...]`

It will return something like this: `[..., 1, 6, 3, ...]`, the value before `6` indicates the selector have selected the item #1 (which means the second item as the array index is start from 0).

In order to use grouped fragments, you will have to wrap the fragments those are in a group with an array.

For example, if I want to have 2 group of values, one have 2 values limit to *0-2* and *0-3*, another one have 3 values limit to *0-3*, *0-4* and *0-5*, only one of the 2 groups will be selected, then I can enter it like this:

`[..., [[3, 4], [4, 5, 6]], ...]`

It will returns like this: `[..., 0, [2, 1], ...]`, same as above, there is a value before the selected values indicates the index provided, after it is the array of values it provided.

If you feel this is hard to understand, I'm highly recommand to try it out yourself.

Installation
------------
`npm install hash-splitter`

License
-------
[GPL v3](LICENSE)