# Make text objects with various ruby block structures

This Vim plugin makes text objects with various ruby block structures.
Many end-terminated blocks are parsed using regex, indentation and syntax highlight.
This is more correct than parsing text with regex only.

## Simple one operator-pending mapping `r`

Operator-pending mapping `r` is added. `dir`, `yar` and other mappings are available like `diw`, `yi'`.
`if`, `unless`, `case`, `while`, `until`, `for`, `def`, `module`, `class`, `do`, `begin` blocks are selected as text-objects.

Example:

`#\%` is the place of your cursor.

```ruby
def hoge(yo)
    if yo
        puts "yo!"
        #\%
    end
    puts "everyone!"
end
```

Typing `dar` removes whole `if` block

```ruby
def hoge(yo)
    #\%
    puts "everyone!"
end
```

or `dir` removes innner `if` block.

```ruby
def hoge(yo)
    if yo
    #\%
    end
end
```

When a cursor places at line 6,

```ruby
def hoge(yo)
    if yo
        puts "yo!"
        
    end
    puts "everyone!" #\%
end
```

type `dir` removes inner `def` block.

```ruby
def hoge(yo)
end
```

Only bellow mapping is defined.
<table>
    <tr>
        <th>Description</th>
        <th>Blocks</th>
        <th>Operator-pending Mappings</th>
    </tr>
    <tr>
        <td>any block with end-terminated</td>
        <td>all blocks</td>
        <td>r</td>
    </tr>
</table>


This plugin requires [vim-textobj-user](https://github.com/kana/vim-textobj-user)

## Or many operator-pending mappings for Ruby blocks

If you set `g:textobj_ruby_more_mappings` to `1`, more mappings are defined.
You can specify kinds of Ruby blocks.
If you remember all mappings, it will be more convenient.

Combinations of textobjects and Ruby blocks are below.

<table>
    <tr>
        <th>Description</th>
        <th>Blocks</th>
        <th>Operator-pending Mappings</th>
    </tr>
    <tr>
        <td>definitions blocks</td>
        <td>module, class, def</td>
        <td>ro</td>
    </tr>
    <tr>
        <td>loop blocks</td>j
        <td>while, for, until</td>j
        <td>rl</td>
    </tr>
    <tr>
        <td>control blocks</td>
        <td>do, begin, if, unless, case</td>
        <td>rc</td>
    </tr>
    <tr>
        <td>do statement</td>
        <td>do</td>
        <td>rd</td>
    </tr>
    <tr>
        <td>any block including above all</td>
        <td>all blocks</td>
        <td>rr</td>
    </tr>
</table>

