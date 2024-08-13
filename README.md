libproperties
=============

A simple library to parse properties. The rules for the format are as follows:

* Entries are generally expected to be a single line of the form, one of the
following:

	* propertyName=propertyValue
	* propertyName:propertyValue

* White space that appears between the property name and property value is
ignored, so the following are equivalent.

	* name=Stephen
	* name = Stephen

White space at the beginning of the line is also ignored.

* Lines that start with the comment characters `!` or `#` are ignored. Blank
lines are also ignored.

* A property value can span several lines if each line is terminated by a
backslash (‘\’) character. For example:

```
targetCities=\
        Detroit,\
        Chicago,\
        Los Angeles
```

This is equivalent to `targetCities=Detroit,Chicago,Los Angeles` (white space
at the beginning of lines is ignored).

* The characters _newline_, _carriage return_, and _tab_ can be inserted with
characters `\n`, `\r`, and `\t`, respectively.

* The backslash character must be escaped as a double backslash. For example:

```
path=c:\\docs\\doc1
```

* UNICODE characters can be entered as they are in a Java program, using the
`\u` prefix. For example, `\u002c`.
