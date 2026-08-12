# Render DataTable to HTML

This function is a wrapper around the
[`DT::datatable`](https://rdrr.io/pkg/DT/man/datatable.html) function,
containing useful defaults. This function is particularly useful when to
provide interactivity (eg. sorting, saving) to tables when rendering
documents using RMarkdown or Quarto.

## Usage

``` r
render_datatable(
  df,
  extensions = c("Buttons"),
  class = c("compact", "stripe", "hover", "row-border"),
  rownames = FALSE,
  options = list(dom = "Bfrtip", buttons = c("copy", "csv"), scrollX = TRUE, scrollY =
    TRUE),
  height = 400,
  ...
)
```

## Arguments

- df:

  Dataframe to render

- extensions:

  Extensions parameter passed to
  [`DT::datatable`](https://rdrr.io/pkg/DT/man/datatable.html)

- class:

  Class parameters passed to
  [`DT::datatable`](https://rdrr.io/pkg/DT/man/datatable.html)

- rownames:

  (logical) Include rownames in output (Default = `FALSE`)

- options:

  List of options passed to
  [`DT::datatable`](https://rdrr.io/pkg/DT/man/datatable.html)

- height:

  Height of output (Default = `400`)

- ...:

  Additional arguments passed to
  [`DT::datatable`](https://rdrr.io/pkg/DT/man/datatable.html)

## Value

An HTML widget

## Examples

``` r
render_datatable(datasets::mtcars)

{"x":{"filter":"none","vertical":false,"extensions":["Buttons"],"data":[[21,21,22.8,21.4,18.7,18.1,14.3,24.4,22.8,19.2,17.8,16.4,17.3,15.2,10.4,10.4,14.7,32.4,30.4,33.9,21.5,15.5,15.2,13.3,19.2,27.3,26,30.4,15.8,19.7,15,21.4],[6,6,4,6,8,6,8,4,4,6,6,8,8,8,8,8,8,4,4,4,4,8,8,8,8,4,4,4,8,6,8,4],[160,160,108,258,360,225,360,146.7,140.8,167.6,167.6,275.8,275.8,275.8,472,460,440,78.7,75.7,71.09999999999999,120.1,318,304,350,400,79,120.3,95.09999999999999,351,145,301,121],[110,110,93,110,175,105,245,62,95,123,123,180,180,180,205,215,230,66,52,65,97,150,150,245,175,66,91,113,264,175,335,109],[3.9,3.9,3.85,3.08,3.15,2.76,3.21,3.69,3.92,3.92,3.92,3.07,3.07,3.07,2.93,3,3.23,4.08,4.93,4.22,3.7,2.76,3.15,3.73,3.08,4.08,4.43,3.77,4.22,3.62,3.54,4.11],[2.62,2.875,2.32,3.215,3.44,3.46,3.57,3.19,3.15,3.44,3.44,4.07,3.73,3.78,5.25,5.424,5.345,2.2,1.615,1.835,2.465,3.52,3.435,3.84,3.845,1.935,2.14,1.513,3.17,2.77,3.57,2.78],[16.46,17.02,18.61,19.44,17.02,20.22,15.84,20,22.9,18.3,18.9,17.4,17.6,18,17.98,17.82,17.42,19.47,18.52,19.9,20.01,16.87,17.3,15.41,17.05,18.9,16.7,16.9,14.5,15.5,14.6,18.6],[0,0,1,1,0,1,0,1,1,1,1,0,0,0,0,0,0,1,1,1,1,0,0,0,0,1,0,1,0,0,0,1],[1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,0,0,0,0,0,1,1,1,1,1,1,1],[4,4,4,3,3,3,3,4,4,4,4,3,3,3,3,3,3,4,4,4,3,3,3,3,3,4,5,5,5,5,5,4],[4,4,1,1,2,1,4,2,2,4,4,3,3,3,4,4,4,1,2,1,1,2,2,4,2,1,2,2,4,6,8,2]],"container":"<table class=\"compact stripe hover row-border\">\n  <thead>\n    <tr>\n      <th>mpg<\/th>\n      <th>cyl<\/th>\n      <th>disp<\/th>\n      <th>hp<\/th>\n      <th>drat<\/th>\n      <th>wt<\/th>\n      <th>qsec<\/th>\n      <th>vs<\/th>\n      <th>am<\/th>\n      <th>gear<\/th>\n      <th>carb<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"dom":"Bfrtip","buttons":["copy","csv"],"scrollX":true,"scrollY":true,"columnDefs":[{"className":"dt-right","targets":[0,1,2,3,4,5,6,7,8,9,10]},{"name":"mpg","targets":0},{"name":"cyl","targets":1},{"name":"disp","targets":2},{"name":"hp","targets":3},{"name":"drat","targets":4},{"name":"wt","targets":5},{"name":"qsec","targets":6},{"name":"vs","targets":7},{"name":"am","targets":8},{"name":"gear","targets":9},{"name":"carb","targets":10}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}
```
