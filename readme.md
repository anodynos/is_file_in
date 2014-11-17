# is_file_in / isFileIn

## Moved / Renamed

**This project has moved to `npm install umatch` / http://github.com/anodynos/umatch**

[![Build Status](https://travis-ci.org/anodynos/is_file_in.svg?branch=master)](https://travis-ci.org/anodynos/is_file_in)
[![Up to date Status](https://david-dm.org/anodynos/is_file_in.png)](https://david-dm.org/anodynos/is_file_in.png)

A `function(filename, specs)` thats checks if `'someFile.ext'` passes through an of Array of `minimatch` / `RegExp` / `callbacks` specs, with inclusion OR negation/exclusion '!' flag

The Array of filename specifications (or simply filenames), can expressed in either:

  * `String` in *gruntjs*'s-like expand `minimatch` format (eg `'**/*.coffee'`) and its exclusion cousin (eg `'!**/DRAFT*.*'`)

  * `RegExp`s that matches filenames (eg `/./`) again with a

  ```
  [..., '!', /regexp/, ...]
  ```

  negation / exclusion pattern.

  * A `function(filename){}` callback, returning `true` if filename is to be matched. Consistently it can have a negation / exclusion flag before it:

  ```
  [..., '!', function(f){ return f === 'excludeMe.js' }, ...]
  ```.

    Note the trap: use a `true` (i.e matched) as the function result, preceded by '!' for **exclusion**. The common trap is to return a `false` for your *excluded matches* and then all your non-excluded with match with `true`, which is probably not what you want!.

  * @todo: NOT IMPLEMENTED: An `Array<String|RegExp|Function|Array>, recursive, i.e
   ```
   [ ..., ['AllowMe*.*', '!', function(f){ return f === 'excludeMe.js' }, [.., []], ...], ...]
   ```

# Examples

```javascript

  var specs = [
    '**/recources/*',
    '!badFile.json',
    /.*\.someExtension$/i, '!',
    /.*\.excludeExtension$/i,
    function(fn) { return fn === 'includedFile.ext' },
    '!', function(fn) { return _.startsWith('DRAFT') }
  ];

  isFileIn('someFile.someExtension', specs) // true

  isFileIn('someFile.otherExtension', specs) // false

  isFileIn('includedFile.ext', specs) //true

  isFileIn('DRAFTFile.ext', specs) // false

```

See the [specs](https://github.com/anodynos/is_file_in/blob/master/source/spec/isFileIn-spec.coffee) for more examples.

# License

The MIT License

Copyright (c) 2013-2014 Agelos Pikoulas (agelos.pikoulas@gmail.com)

Permission is hereby granted, free of charge, to any person
obtaining a copy of this software and associated documentation
files (the "Software"), to deal in the Software without
restriction, including without limitation the rights to use,
copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the
Software is furnished to do so, subject to the following
conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.
