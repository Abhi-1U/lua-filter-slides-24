## pandoc command


### Target Native AST

```
pandoc new.Rnw --from sweave_reader.lua --to native --output output.txt
```

### Target Markdown

```
pandoc new.Rnw --from sweave_reader.lua --to markdown --output output.md 
```


