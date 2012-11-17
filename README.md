## Make text objects with various ruby block structures

Combinations of textobject and Ruby block is below.

<table>
    <tr>
        <th>description</th>
        <th>blocks</th>
        <th>mappings</th>
    </tr>
    <tr>
        <td>definitions blocks</td>
        <td>module, class, def</td>
        <td>diro, daro, ciro, caro, yiro, yaro and more mappings...</td>
    </tr>
    <tr>
        <td>loop blocks</td>j
        <td>while, for, until</td>j
        <td>dirl, darl, cirl, carl, yirl, yarl and more mappings...</td>
    </tr>
    <tr>
        <td>control blocks</td>
        <td>do/begin/if/unless/case</td>
        <td>dird, dard, cird, card, yird, yard and more mappings...</td>
    </tr>
    <tr>
        <td>do statement</td>
        <td>do</td>
        <td>dird, dard, cird, card, yird, yard and more mappings...</td>
    </tr>
    <tr>
        <td>any block including above all</td>
        <td>all blocks</td>
        <td>dirr, darr, cirr, carr, yirr, yarr and more mappings...</td>
    </tr>
</table>

If you don't want to use above many mappings and want more simple interface, set `g:textobj_ruby_tiny` to `1`.

Then only
<table>
    <tr>
        <th>description</th>
        <th>blocks</th>
        <th>mappings</th>
    </tr>
    <tr>
        <td>any block with end-terminated</td>
        <td>all blocks</td>
        <td>dir, dar, cir, car, yir, yar and more mappings...</td>
    </tr>
</table>
is defined.

This plugin requires [vim-textobj-user](https://github.com/kana/vim-textobj-user)
