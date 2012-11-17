## Make text objects with various ruby block structures

Combinations of textobject and Ruby block is below.

<table>
    <tr>
        <th>description</th>
        <th>blocks</th>
        <th>mappings</th>
    </tr>
    <tr>
        <th>definitions blocks</th>
        <th>`module`, `class`, `def`</th>
        <th>`diro`, `daro`, `ciro`, `caro`, `yiro`, `yaro` and more mappings...</th>
    </tr>
    <tr>
        <th>loop blocks</th>j
        <th>`while`, `for`, `until`</th>j
        <th>`dirl`, `darl`, `cirl`, `carl`, `yirl`, `yarl` and more mappings...</th>
    </tr>
    <tr>
        <th>control blocks</th>
        <th>`do`/`begin`/`if`/`unless`/`case`</th>
        <th>`dird`, `dard`, `cird`, `card`, `yird`, `yard` and more mappings...</th>
    </tr>
    <tr>
        <th>do statement</th>
        <th>`do`</th>
        <th>`dird`, `dard`, `cird`, `card`, `yird`, `yard` and more mappings...</th>
    </tr>
    <tr>
        <th>any block including above all</th>
        <th>all</th>
        <th>`dirr`, `darr`, `cirr`, `carr`, `yirr`, `yarr` and more mappings...</th>
    </tr>
</table>

If you don't want to use above many mappings and want more simple interface, set `g:textobj_ruby_tiny` to `1`.

Then only
<table>
    <tr>
        <th>any block with end-terminated</th>
        <th>all</th>
        <th>`dir`, `dar`, `cir`, `car`, `yir`, `yar` and more mappings...</th>
    </tr>
</table>
is defined.

This plugin requires [vim-textobj-user](https://github.com/kana/vim-textobj-user)
