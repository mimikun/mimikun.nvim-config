<div align="center">

# `core.highlights`

### No Colour Means no Productivity





</div>

# Overview

`core.highlights` maps all possible highlight groups available throughout
Neorg under a single tree of highlights: `@neorg.*`.

# Configuration

* <details open>
  
  <summary><h6><code>dim</h6></code> (table)</summary>
  
  <div>
  
  Handles the dimming of certain highlight groups.
  
  It sometimes is favourable to use an existing highlight group,
  but to dim or brighten it a little bit.
  
  To do so, you may use this table, which, similarly to the `highlights` table,
  will concatenate nested trees to form a highlight group name.
  
  The difference is, however, that the leaves of the tree are a table, not a single string.
  This table has three possible fields:
  - `reference` - which highlight to use as reference for the dimming.
  - `percentage` - by how much to darken the reference highlight. This value may be between
  `-100` and `100`, where negative percentages brighten the reference highlight, whereas
  positive values dim the highlight by the given percentage.
  
  </div>
  
  
  * <details>
    
    <summary><h6><code>markup</h6></code> (table)</summary>
    
    <br>
    
    
    * <details>
      
      <summary><h6><code>inline_comment</h6></code> (table)</summary>
      
      <br>
      
      
      * <details>
        
        <summary><h6><code>percentage</h6></code> (number)</summary>
        
        <br>
        
        ```lua
        40
        ```
        
        </details>
      * <details>
        
        <summary><h6><code>reference</h6></code> (string)</summary>
        
        <br>
        
        ```lua
        "Normal"
        ```
        
        </details>
      
      
      </details>
    * <details>
      
      <summary><h6><code>verbatim</h6></code> (table)</summary>
      
      <br>
      
      
      * <details>
        
        <summary><h6><code>percentage</h6></code> (number)</summary>
        
        <br>
        
        ```lua
        20
        ```
        
        </details>
      * <details>
        
        <summary><h6><code>reference</h6></code> (string)</summary>
        
        <br>
        
        ```lua
        "Normal"
        ```
        
        </details>
      
      
      </details>
    
    
    </details>
  * <details>
    
    <summary><h6><code>tags</h6></code> (table)</summary>
    
    <br>
    
    
    * <details>
      
      <summary><h6><code>ranged_verbatim</h6></code> (table)</summary>
      
      <br>
      
      
      * <details>
        
        <summary><h6><code>code_block</h6></code> (table)</summary>
        
        <br>
        
        
        * <details>
          
          <summary><h6><code>affect</h6></code> (string)</summary>
          
          <br>
          
          ```lua
          "background"
          ```
          
          </details>
        * <details>
          
          <summary><h6><code>percentage</h6></code> (number)</summary>
          
          <br>
          
          ```lua
          15
          ```
          
          </details>
        * <details>
          
          <summary><h6><code>reference</h6></code> (string)</summary>
          
          <br>
          
          ```lua
          "Normal"
          ```
          
          </details>
        
        
        </details>
      
      
      </details>
    
    
    </details>
  
  
  </details>

* <details open>
  
  <summary><h6><code>highlights</h6></code> (table)</summary>
  
  <div>
  
  The TS highlights for each Neorg type.
  
  The `highlights` table is a large collection of nested trees. At the leaves of each of these
  trees is the final highlight to apply to that tree. For example: `"+@comment"` tells Neorg to
  link to an existing highlight group `@comment` (denoted by the `+` prefix). When no prefix is
  found, the string is treated as arguments passed to `:highlight`, for example: `gui=bold
  fg=#000000`.
  
  Nested trees concatenate, thus:
  ```lua
  tags = {
  ranged_verbatim = {
  begin = "+@comment",
  },
  }
  ```
  matches the highlight group:
  ```lua
  @neorg.tags.ranged_verbatim.begin
  ```
  and converts into the following command:
  ```vim
  highlight! link @neorg.tags.ranged_verbatim.begin @comment
  ```
  
  </div>
  
  
  * <details>
    
    <summary><h6><code>anchors</h6></code> (table)</summary>
    
    <div>
    
    Highlights for the anchor syntax: `[name]{location}`.
    
    </div>
    
    
    * <details>
      
      <summary><h6><code>declaration</h6></code> (table)</summary>
      
      <br>
      
      
      * <details>
        
        <summary><h6><code>delimiter</h6></code> (string)</summary>
        
        <br>
        
        ```lua
        "+NonText"
        ```
        
        </details>
      
      
      </details>
    * <details>
      
      <summary><h6><code>definition</h6></code> (table)</summary>
      
      <br>
      
      
      * <details>
        
        <summary><h6><code>delimiter</h6></code> (string)</summary>
        
        <br>
        
        ```lua
        "+NonText"
        ```
        
        </details>
      
      
      </details>
    
    
    </details>
  * <details>
    
    <summary><h6><code>definitions</h6></code> (table)</summary>
    
    <div>
    
    Highlights for definitions (`$ Definition`).
    
    </div>
    
    
    * <details>
      
      <summary><h6><code>content</h6></code> (string)</summary>
      
      <br>
      
      ```lua
      "+@markup.italic"
      ```
      
      </details>
    * <details>
      
      <summary><h6><code>prefix</h6></code> (string)</summary>
      
      <br>
      
      ```lua
      "+@punctuation.delimiter"
      ```
      
      </details>
    * <details>
      
      <summary><h6><code>suffix</h6></code> (string)</summary>
      
      <br>
      
      ```lua
      "+@punctuation.delimiter"
      ```
      
      </details>
    * <details>
      
      <summary><h6><code>title</h6></code> (string)</summary>
      
      <br>
      
      ```lua
      "+@markup.strong"
      ```
      
      </details>
    
    
    </details>
  * <details>
    
    <summary><h6><code>delimiters</h6></code> (table)</summary>
    
    <div>
    
    Highlights for all the delimiter types. These include:
    - `---` - the weak delimiter
    - `===` - the strong delimiter
    - `___` - the horizontal rule
    
    </div>
    
    
    * <details>
      
      <summary><h6><code>horizontal_line</h6></code> (string)</summary>
      
      <br>
      
      ```lua
      "+@punctuation.delimiter"
      ```
      
      </details>
    * <details>
      
      <summary><h6><code>strong</h6></code> (string)</summary>
      
      <br>
      
      ```lua
      "+@punctuation.delimiter"
      ```
      
      </details>
    * <details>
      
      <summary><h6><code>weak</h6></code> (string)</summary>
      
      <br>
      
      ```lua
      "+@punctuation.delimiter"
      ```
      
      </details>
    
    
    </details>
  * <details>
    
    <summary><h6><code>error</h6></code> (string)</summary>
    
    <div>
    
    In case of errors in the syntax tree, use the following highlight.
    
    </div>
    
    ```lua
    "+Error"
    ```
    
    </details>
  * <details>
    
    <summary><h6><code>footnotes</h6></code> (table)</summary>
    
    <div>
    
    Highlights for footnotes (`^ My Footnote`).
    
    </div>
    
    
    * <details>
      
      <summary><h6><code>content</h6></code> (string)</summary>
      
      <br>
      
      ```lua
      "+@markup.italic"
      ```
      
      </details>
    * <details>
      
      <summary><h6><code>prefix</h6></code> (string)</summary>
      
      <br>
      
      ```lua
      "+@punctuation.delimiter"
      ```
      
      </details>
    * <details>
      
      <summary><h6><code>suffix</h6></code> (string)</summary>
      
      <br>
      
      ```lua
      "+@punctuation.delimiter"
      ```
      
      </details>
    * <details>
      
      <summary><h6><code>title</h6></code> (string)</summary>
      
      <br>
      
      ```lua
      "+@markup.strong"
      ```
      
      </details>
    
    
    </details>
  * <details>
    
    <summary><h6><code>headings</h6></code> (table)</summary>
    
    <div>
    
    Highlights for each individual heading level.
    
    </div>
    
    
    * <details>
      
      <summary><h6><code>1</h6></code> (table)</summary>
      
      <br>
      
      
      * <details>
        
        <summary><h6><code>prefix</h6></code> (string)</summary>
        
        <br>
        
        ```lua
        "+@attribute"
        ```
        
        </details>
      * <details>
        
        <summary><h6><code>title</h6></code> (string)</summary>
        
        <br>
        
        ```lua
        "+@attribute"
        ```
        
        </details>
      
      
      </details>
    * <details>
      
      <summary><h6><code>2</h6></code> (table)</summary>
      
      <br>
      
      
      * <details>
        
        <summary><h6><code>prefix</h6></code> (string)</summary>
        
        <br>
        
        ```lua
        "+@label"
        ```
        
        </details>
      * <details>
        
        <summary><h6><code>title</h6></code> (string)</summary>
        
        <br>
        
        ```lua
        "+@label"
        ```
        
        </details>
      
      
      </details>
    * <details>
      
      <summary><h6><code>3</h6></code> (table)</summary>
      
      <br>
      
      
      * <details>
        
        <summary><h6><code>prefix</h6></code> (string)</summary>
        
        <br>
        
        ```lua
        "+@constant"
        ```
        
        </details>
      * <details>
        
        <summary><h6><code>title</h6></code> (string)</summary>
        
        <br>
        
        ```lua
        "+@constant"
        ```
        
        </details>
      
      
      </details>
    * <details>
      
      <summary><h6><code>4</h6></code> (table)</summary>
      
      <br>
      
      
      * <details>
        
        <summary><h6><code>prefix</h6></code> (string)</summary>
        
        <br>
        
        ```lua
        "+@string"
        ```
        
        </details>
      * <details>
        
        <summary><h6><code>title</h6></code> (string)</summary>
        
        <br>
        
        ```lua
        "+@string"
        ```
        
        </details>
      
      
      </details>
    * <details>
      
      <summary><h6><code>5</h6></code> (table)</summary>
      
      <br>
      
      
      * <details>
        
        <summary><h6><code>prefix</h6></code> (string)</summary>
        
        <br>
        
        ```lua
        "+@label"
        ```
        
        </details>
      * <details>
        
        <summary><h6><code>title</h6></code> (string)</summary>
        
        <br>
        
        ```lua
        "+@label"
        ```
        
        </details>
      
      
      </details>
    * <details>
      
      <summary><h6><code>6</h6></code> (table)</summary>
      
      <br>
      
      
      * <details>
        
        <summary><h6><code>prefix</h6></code> (string)</summary>
        
        <br>
        
        ```lua
        "+@constructor"
        ```
        
        </details>
      * <details>
        
        <summary><h6><code>title</h6></code> (string)</summary>
        
        <br>
        
        ```lua
        "+@constructor"
        ```
        
        </details>
      
      
      </details>
    
    
    </details>
  * <details>
    
    <summary><h6><code>links</h6></code> (table)</summary>
    
    <br>
    
    
    * <details>
      
      <summary><h6><code>description</h6></code> (table)</summary>
      
      <br>
      
      
      * <details>
        
        <summary><h6><code>delimiter</h6></code> (string)</summary>
        
        <br>
        
        ```lua
        "+NonText"
        ```
        
        </details>
      
      
      </details>
    * <details>
      
      <summary><h6><code>file</h6></code> (table)</summary>
      
      <br>
      
      
      * <details>
        
        <summary><h6><code>delimiter</h6></code> (string)</summary>
        
        <br>
        
        ```lua
        "+NonText"
        ```
        
        </details>
      
      
      </details>
    * <details>
      
      <summary><h6><code>location</h6></code> (table)</summary>
      
      <br>
      
      
      * <details>
        
        <summary><h6><code>definition</h6></code> (table)</summary>
        
        <br>
        
        
        * <details>
          
          <summary><h6><code>prefix</h6></code> (string)</summary>
          
          <br>
          
          ```lua
          "+@neorg.definitions.prefix"
          ```
          
          </details>
        
        
        </details>
      * <details>
        
        <summary><h6><code>delimiter</h6></code> (string)</summary>
        
        <br>
        
        ```lua
        "+NonText"
        ```
        
        </details>
      * <details>
        
        <summary><h6><code>external_file</h6></code> (table)</summary>
        
        <br>
        
        
        * <details>
          
          <summary><h6><code>prefix</h6></code> (string)</summary>
          
          <br>
          
          ```lua
          "+@label"
          ```
          
          </details>
        
        
        </details>
      * <details>
        
        <summary><h6><code>footnote</h6></code> (table)</summary>
        
        <br>
        
        
        * <details>
          
          <summary><h6><code>prefix</h6></code> (string)</summary>
          
          <br>
          
          ```lua
          "+@neorg.footnotes.prefix"
          ```
          
          </details>
        
        
        </details>
      * <details>
        
        <summary><h6><code>generic</h6></code> (table)</summary>
        
        <br>
        
        
        * <details>
          
          <summary><h6><code>prefix</h6></code> (string)</summary>
          
          <br>
          
          ```lua
          "+@type"
          ```
          
          </details>
        
        
        </details>
      * <details>
        
        <summary><h6><code>heading</h6></code> (table)</summary>
        
        <br>
        
        
        * <details>
          
          <summary><h6><code>1</h6></code> (table)</summary>
          
          <br>
          
          
          * <details>
            
            <summary><h6><code>prefix</h6></code> (string)</summary>
            
            <br>
            
            ```lua
            "+@neorg.headings.1.prefix"
            ```
            
            </details>
          
          
          </details>
        * <details>
          
          <summary><h6><code>2</h6></code> (table)</summary>
          
          <br>
          
          
          * <details>
            
            <summary><h6><code>prefix</h6></code> (string)</summary>
            
            <br>
            
            ```lua
            "+@neorg.headings.2.prefix"
            ```
            
            </details>
          
          
          </details>
        * <details>
          
          <summary><h6><code>3</h6></code> (table)</summary>
          
          <br>
          
          
          * <details>
            
            <summary><h6><code>prefix</h6></code> (string)</summary>
            
            <br>
            
            ```lua
            "+@neorg.headings.3.prefix"
            ```
            
            </details>
          
          
          </details>
        * <details>
          
          <summary><h6><code>4</h6></code> (table)</summary>
          
          <br>
          
          
          * <details>
            
            <summary><h6><code>prefix</h6></code> (string)</summary>
            
            <br>
            
            ```lua
            "+@neorg.headings.4.prefix"
            ```
            
            </details>
          
          
          </details>
        * <details>
          
          <summary><h6><code>5</h6></code> (table)</summary>
          
          <br>
          
          
          * <details>
            
            <summary><h6><code>prefix</h6></code> (string)</summary>
            
            <br>
            
            ```lua
            "+@neorg.headings.5.prefix"
            ```
            
            </details>
          
          
          </details>
        * <details>
          
          <summary><h6><code>6</h6></code> (table)</summary>
          
          <br>
          
          
          * <details>
            
            <summary><h6><code>prefix</h6></code> (string)</summary>
            
            <br>
            
            ```lua
            "+@neorg.headings.6.prefix"
            ```
            
            </details>
          
          
          </details>
        
        
        </details>
      * <details>
        
        <summary><h6><code>marker</h6></code> (table)</summary>
        
        <br>
        
        
        * <details>
          
          <summary><h6><code>prefix</h6></code> (string)</summary>
          
          <br>
          
          ```lua
          "+@neorg.markers.prefix"
          ```
          
          </details>
        
        
        </details>
      * <details>
        
        <summary><h6><code>url</h6></code> (string)</summary>
        
        <br>
        
        ```lua
        "+@markup.link.url"
        ```
        
        </details>
      
      
      </details>
    
    
    </details>
  * <details>
    
    <summary><h6><code>lists</h6></code> (table)</summary>
    
    <div>
    
    Highlights for all the possible levels of ordered and unordered lists.
    
    </div>
    
    
    * <details>
      
      <summary><h6><code>ordered</h6></code> (table)</summary>
      
      <br>
      
      
      * <details>
        
        <summary><h6><code>prefix</h6></code> (string)</summary>
        
        <br>
        
        ```lua
        "+@keyword.repeat"
        ```
        
        </details>
      
      
      </details>
    * <details>
      
      <summary><h6><code>unordered</h6></code> (table)</summary>
      
      <br>
      
      
      * <details>
        
        <summary><h6><code>prefix</h6></code> (string)</summary>
        
        <br>
        
        ```lua
        "+@markup.list"
        ```
        
        </details>
      
      
      </details>
    
    
    </details>
  * <details>
    
    <summary><h6><code>markup</h6></code> (table)</summary>
    
    <div>
    
    Highlights for inline markup.
    
    This is all the highlights like `bold`, `italic` and so on.
    
    </div>
    
    
    * <details>
      
      <summary><h6><code>bold</h6></code> (table)</summary>
      
      <br>
      
      
      * <details>
        
        <summary><h6><code>delimiter</h6></code> (string)</summary>
        
        <br>
        
        ```lua
        "+NonText"
        ```
        
        </details>
      
      
      </details>
    * <details>
      
      <summary><h6><code>free_form_delimiter</h6></code> (string)</summary>
      
      <br>
      
      ```lua
      "+NonText"
      ```
      
      </details>
    * <details>
      
      <summary><h6><code>inline_comment</h6></code> (table)</summary>
      
      <br>
      
      
      * <details>
        
        <summary><h6><code>delimiter</h6></code> (string)</summary>
        
        <br>
        
        ```lua
        "+NonText"
        ```
        
        </details>
      
      
      </details>
    * <details>
      
      <summary><h6><code>inline_math</h6></code> (table)</summary>
      
      <br>
      
      
      * <details>
        
        <summary><h6><code>delimiter</h6></code> (string)</summary>
        
        <br>
        
        ```lua
        "+NonText"
        ```
        
        </details>
      
      
      </details>
    * <details>
      
      <summary><h6><code>italic</h6></code> (table)</summary>
      
      <br>
      
      
      * <details>
        
        <summary><h6><code>delimiter</h6></code> (string)</summary>
        
        <br>
        
        ```lua
        "+NonText"
        ```
        
        </details>
      
      
      </details>
    * <details>
      
      <summary><h6><code>spoiler</h6></code> (table)</summary>
      
      <br>
      
      
      * <details>
        
        <summary><h6><code>delimiter</h6></code> (string)</summary>
        
        <br>
        
        ```lua
        "+NonText"
        ```
        
        </details>
      
      
      </details>
    * <details>
      
      <summary><h6><code>strikethrough</h6></code> (table)</summary>
      
      <br>
      
      
      * <details>
        
        <summary><h6><code>delimiter</h6></code> (string)</summary>
        
        <br>
        
        ```lua
        "+NonText"
        ```
        
        </details>
      
      
      </details>
    * <details>
      
      <summary><h6><code>subscript</h6></code> (table)</summary>
      
      <br>
      
      
      * <details>
        
        <summary><h6><code>delimiter</h6></code> (string)</summary>
        
        <br>
        
        ```lua
        "+NonText"
        ```
        
        </details>
      
      
      </details>
    * <details>
      
      <summary><h6><code>superscript</h6></code> (table)</summary>
      
      <br>
      
      
      * <details>
        
        <summary><h6><code>delimiter</h6></code> (string)</summary>
        
        <br>
        
        ```lua
        "+NonText"
        ```
        
        </details>
      
      
      </details>
    * <details>
      
      <summary><h6><code>underline</h6></code> (table)</summary>
      
      <br>
      
      
      * <details>
        
        <summary><h6><code>delimiter</h6></code> (string)</summary>
        
        <br>
        
        ```lua
        "+NonText"
        ```
        
        </details>
      
      
      </details>
    * <details>
      
      <summary><h6><code>variable</h6></code> (table)</summary>
      
      <br>
      
      
      * <details>
        
        <summary><h6><code>delimiter</h6></code> (string)</summary>
        
        <br>
        
        ```lua
        "+NonText"
        ```
        
        </details>
      
      
      </details>
    * <details>
      
      <summary><h6><code>verbatim</h6></code> (table)</summary>
      
      <br>
      
      
      * <details>
        
        <summary><h6><code>delimiter</h6></code> (string)</summary>
        
        <br>
        
        ```lua
        "+NonText"
        ```
        
        </details>
      
      
      </details>
    
    
    </details>
  * <details>
    
    <summary><h6><code>modifiers</h6></code> (table)</summary>
    
    <div>
    
    Inline modifiers.
    
    This includes:
    - `~` - the trailing modifier
    - All link characters (`{`, `}`, `[`, `]`, `<`, `>`)
    - The escape character (`\`)
    
    </div>
    
    
    * <details>
      
      <summary><h6><code>escape</h6></code> (string)</summary>
      
      <br>
      
      ```lua
      "+@type"
      ```
      
      </details>
    * <details>
      
      <summary><h6><code>link</h6></code> (string)</summary>
      
      <br>
      
      ```lua
      "+NonText"
      ```
      
      </details>
    
    
    </details>
  * <details>
    
    <summary><h6><code>quotes</h6></code> (table)</summary>
    
    <div>
    
    Highlights for all the possible levels of quotes.
    
    </div>
    
    
    * <details>
      
      <summary><h6><code>1</h6></code> (table)</summary>
      
      <br>
      
      
      * <details>
        
        <summary><h6><code>content</h6></code> (string)</summary>
        
        <br>
        
        ```lua
        "+@punctuation.delimiter"
        ```
        
        </details>
      * <details>
        
        <summary><h6><code>prefix</h6></code> (string)</summary>
        
        <br>
        
        ```lua
        "+@punctuation.delimiter"
        ```
        
        </details>
      
      
      </details>
    * <details>
      
      <summary><h6><code>2</h6></code> (table)</summary>
      
      <br>
      
      
      * <details>
        
        <summary><h6><code>content</h6></code> (string)</summary>
        
        <br>
        
        ```lua
        "+Blue"
        ```
        
        </details>
      * <details>
        
        <summary><h6><code>prefix</h6></code> (string)</summary>
        
        <br>
        
        ```lua
        "+Blue"
        ```
        
        </details>
      
      
      </details>
    * <details>
      
      <summary><h6><code>3</h6></code> (table)</summary>
      
      <br>
      
      
      * <details>
        
        <summary><h6><code>content</h6></code> (string)</summary>
        
        <br>
        
        ```lua
        "+Yellow"
        ```
        
        </details>
      * <details>
        
        <summary><h6><code>prefix</h6></code> (string)</summary>
        
        <br>
        
        ```lua
        "+Yellow"
        ```
        
        </details>
      
      
      </details>
    * <details>
      
      <summary><h6><code>4</h6></code> (table)</summary>
      
      <br>
      
      
      * <details>
        
        <summary><h6><code>content</h6></code> (string)</summary>
        
        <br>
        
        ```lua
        "+Red"
        ```
        
        </details>
      * <details>
        
        <summary><h6><code>prefix</h6></code> (string)</summary>
        
        <br>
        
        ```lua
        "+Red"
        ```
        
        </details>
      
      
      </details>
    * <details>
      
      <summary><h6><code>5</h6></code> (table)</summary>
      
      <br>
      
      
      * <details>
        
        <summary><h6><code>content</h6></code> (string)</summary>
        
        <br>
        
        ```lua
        "+Green"
        ```
        
        </details>
      * <details>
        
        <summary><h6><code>prefix</h6></code> (string)</summary>
        
        <br>
        
        ```lua
        "+Green"
        ```
        
        </details>
      
      
      </details>
    * <details>
      
      <summary><h6><code>6</h6></code> (table)</summary>
      
      <br>
      
      
      * <details>
        
        <summary><h6><code>content</h6></code> (string)</summary>
        
        <br>
        
        ```lua
        "+Brown"
        ```
        
        </details>
      * <details>
        
        <summary><h6><code>prefix</h6></code> (string)</summary>
        
        <br>
        
        ```lua
        "+Brown"
        ```
        
        </details>
      
      
      </details>
    
    
    </details>
  * <details>
    
    <summary><h6><code>rendered</h6></code> (table)</summary>
    
    <div>
    
    Rendered Latex, this will dictate the foreground color of latex images rendered via
    core.latex.renderer
    
    </div>
    
    
    * <details>
      
      <summary><h6><code>latex</h6></code> (string)</summary>
      
      <br>
      
      ```lua
      "+Normal"
      ```
      
      </details>
    
    
    </details>
  * <details>
    
    <summary><h6><code>selection_window</h6></code> (table)</summary>
    
    <div>
    
    Highlights displayed in Neorg selection window popups.
    
    </div>
    
    
    * <details>
      
      <summary><h6><code>arrow</h6></code> (string)</summary>
      
      <br>
      
      ```lua
      "+@none"
      ```
      
      </details>
    * <details>
      
      <summary><h6><code>heading</h6></code> (string)</summary>
      
      <br>
      
      ```lua
      "+@annotation"
      ```
      
      </details>
    * <details>
      
      <summary><h6><code>key</h6></code> (string)</summary>
      
      <br>
      
      ```lua
      "+@module"
      ```
      
      </details>
    * <details>
      
      <summary><h6><code>keyname</h6></code> (string)</summary>
      
      <br>
      
      ```lua
      "+@constant"
      ```
      
      </details>
    * <details>
      
      <summary><h6><code>nestedkeyname</h6></code> (string)</summary>
      
      <br>
      
      ```lua
      "+@string"
      ```
      
      </details>
    
    
    </details>
  * <details>
    
    <summary><h6><code>tags</h6></code> (table)</summary>
    
    <div>
    
    Highlights displayed in all sorts of tag types.
    
    These include: `@`, `.`, `|`, `#`, `+` and `=`.
    
    </div>
    
    
    * <details>
      
      <summary><h6><code>carryover</h6></code> (table)</summary>
      
      <div>
      
      Highlights for the carryover (`#`, `+`) tags.
      
      </div>
      
      
      * <details>
        
        <summary><h6><code>begin</h6></code> (string)</summary>
        
        <br>
        
        ```lua
        "+@label"
        ```
        
        </details>
      * <details>
        
        <summary><h6><code>name</h6></code> (table)</summary>
        
        <br>
        
        
        * <details>
          
          <summary><h6><code>delimiter</h6></code> (string)</summary>
          
          <br>
          
          ```lua
          "+@none"
          ```
          
          </details>
        * <details>
          
          <summary><h6><code>word</h6></code> (string)</summary>
          
          <br>
          
          ```lua
          "+@label"
          ```
          
          </details>
        
        
        </details>
      * <details>
        
        <summary><h6><code>parameters</h6></code> (string)</summary>
        
        <br>
        
        ```lua
        "+@string"
        ```
        
        </details>
      
      
      </details>
    * <details>
      
      <summary><h6><code>comment</h6></code> (table)</summary>
      
      <div>
      
      Highlights for the content of any tag named `comment`.
      
      Most prominent use case is for the `#comment` carryover tag.
      
      </div>
      
      
      * <details>
        
        <summary><h6><code>content</h6></code> (string)</summary>
        
        <br>
        
        ```lua
        "+@comment"
        ```
        
        </details>
      
      
      </details>
    * <details>
      
      <summary><h6><code>ranged_verbatim</h6></code> (table)</summary>
      
      <div>
      
      Highlights for the `@` verbatim tags.
      
      </div>
      
      
      * <details>
        
        <summary><h6><code>begin</h6></code> (string)</summary>
        
        <br>
        
        ```lua
        "+@keyword"
        ```
        
        </details>
      * <details>
        
        <summary><h6><code>document_meta</h6></code> (table)</summary>
        
        <br>
        
        
        * <details>
          
          <summary><h6><code>array</h6></code> (table)</summary>
          
          <br>
          
          
          * <details>
            
            <summary><h6><code>bracket</h6></code> (string)</summary>
            
            <br>
            
            ```lua
            "+@punctuation.bracket"
            ```
            
            </details>
          * <details>
            
            <summary><h6><code>value</h6></code> (string)</summary>
            
            <br>
            
            ```lua
            "+@none"
            ```
            
            </details>
          
          
          </details>
        * <details>
          
          <summary><h6><code>authors</h6></code> (string)</summary>
          
          <br>
          
          ```lua
          "+@annotation"
          ```
          
          </details>
        * <details>
          
          <summary><h6><code>categories</h6></code> (string)</summary>
          
          <br>
          
          ```lua
          "+@keyword"
          ```
          
          </details>
        * <details>
          
          <summary><h6><code>created</h6></code> (string)</summary>
          
          <br>
          
          ```lua
          "+@number.float"
          ```
          
          </details>
        * <details>
          
          <summary><h6><code>description</h6></code> (string)</summary>
          
          <br>
          
          ```lua
          "+@label"
          ```
          
          </details>
        * <details>
          
          <summary><h6><code>key</h6></code> (string)</summary>
          
          <br>
          
          ```lua
          "+@variable.member"
          ```
          
          </details>
        * <details>
          
          <summary><h6><code>number</h6></code> (string)</summary>
          
          <br>
          
          ```lua
          "+@number"
          ```
          
          </details>
        * <details>
          
          <summary><h6><code>object</h6></code> (table)</summary>
          
          <br>
          
          
          * <details>
            
            <summary><h6><code>bracket</h6></code> (string)</summary>
            
            <br>
            
            ```lua
            "+@punctuation.bracket"
            ```
            
            </details>
          
          
          </details>
        * <details>
          
          <summary><h6><code>title</h6></code> (string)</summary>
          
          <br>
          
          ```lua
          "+@markup.heading"
          ```
          
          </details>
        * <details>
          
          <summary><h6><code>trailing</h6></code> (string)</summary>
          
          <br>
          
          ```lua
          "+@keyword.repeat"
          ```
          
          </details>
        * <details>
          
          <summary><h6><code>updated</h6></code> (string)</summary>
          
          <br>
          
          ```lua
          "+@number.float"
          ```
          
          </details>
        * <details>
          
          <summary><h6><code>value</h6></code> (string)</summary>
          
          <br>
          
          ```lua
          "+@string"
          ```
          
          </details>
        * <details>
          
          <summary><h6><code>version</h6></code> (string)</summary>
          
          <br>
          
          ```lua
          "+@number.float"
          ```
          
          </details>
        
        
        </details>
      * <details>
        
        <summary><h6><code>end</h6></code> (string)</summary>
        
        <br>
        
        ```lua
        "+@keyword"
        ```
        
        </details>
      * <details>
        
        <summary><h6><code>name</h6></code> (table)</summary>
        
        <br>
        
        
        * <details>
          
          <summary><h6><code>delimiter</h6></code> (string)</summary>
          
          <br>
          
          ```lua
          "+@none"
          ```
          
          </details>
        * <details>
          
          <summary><h6><code>word</h6></code> (string)</summary>
          
          <br>
          
          ```lua
          "+@keyword"
          ```
          
          </details>
        
        
        </details>
      * <details>
        
        <summary><h6><code>parameters</h6></code> (string)</summary>
        
        <br>
        
        ```lua
        "+@type"
        ```
        
        </details>
      
      
      </details>
    
    
    </details>
  * <details>
    
    <summary><h6><code>todo_items</h6></code> (table)</summary>
    
    <div>
    
    Highlights for TODO items.
    
    This strictly covers the `( )` component of any detached modifier. In other words, these
    highlights only bother with highlighting the brackets and the content within, but not the
    object containing the TODO item itself.
    
    </div>
    
    
    * <details>
      
      <summary><h6><code>cancelled</h6></code> (string)</summary>
      
      <br>
      
      ```lua
      "+NonText"
      ```
      
      </details>
    * <details>
      
      <summary><h6><code>done</h6></code> (string)</summary>
      
      <br>
      
      ```lua
      "+@string"
      ```
      
      </details>
    * <details>
      
      <summary><h6><code>on_hold</h6></code> (string)</summary>
      
      <br>
      
      ```lua
      "+@comment.note"
      ```
      
      </details>
    * <details>
      
      <summary><h6><code>pending</h6></code> (string)</summary>
      
      <br>
      
      ```lua
      "+@module"
      ```
      
      </details>
    * <details>
      
      <summary><h6><code>recurring</h6></code> (string)</summary>
      
      <br>
      
      ```lua
      "+@keyword.repeat"
      ```
      
      </details>
    * <details>
      
      <summary><h6><code>uncertain</h6></code> (string)</summary>
      
      <br>
      
      ```lua
      "+@boolean"
      ```
      
      </details>
    * <details>
      
      <summary><h6><code>undone</h6></code> (string)</summary>
      
      <br>
      
      ```lua
      "+@punctuation.delimiter"
      ```
      
      </details>
    * <details>
      
      <summary><h6><code>urgent</h6></code> (string)</summary>
      
      <br>
      
      ```lua
      "+@comment.error"
      ```
      
      </details>
    
    
    </details>
  
  
  </details>


# Dependencies

- [`core.autocommands`](https://github.com/nvim-neorg/neorg/wiki/Autocommands) - Handles the creation and management of Neovim's autocommands.

# Required By

- [`core.integrations.treesitter`](https://github.com/nvim-neorg/neorg/wiki/Treesitter-Integration) - A module designed to integrate Treesitter into Neorg.
- [`core.latex.renderer`](https://github.com/nvim-neorg/neorg/wiki/Core-Latex-Renderer) - An experimental module for rendering latex images inline.
