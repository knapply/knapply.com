start_table <- function() {
  htmltools::HTML('<table style="font-size:small" class="table table-bordered">')
  # htmltools::HTML('<table class="table table-bordered">')
}

start_row <- function() {
  htmltools::HTML('<tr> <td valign="top">')
}

end_col <- function() {
  htmltools::HTML('</td>')
}

new_col <- function() {
  htmltools::HTML('</td> <td>')
}

end_row <- function() {
  htmltools::HTML('</tr>')
}

new_row <- function() {
  htmltools::HTML('</td> </tr> <tr> <td valign="top">')
}

# end_table <- function() {
#   htmltools::HTML('</table>')
# }

label_r <- function() {
  htmltools::HTML('<font color="#0000FF"> > R </font>')
}

label_py <- function() {
  htmltools::HTML('<font color="#008000"> >> Python </font>')
}

label_numpy <- function() {
  htmltools::HTML('<font color="#006400"> >> NumPy </font>')
}

label_cpp <- function() {
  htmltools::HTML('<font color="#FF0000"> >>> C++ </font>')
}

end_table <- function() {
  htmltools::HTML('</td> </tr> </table>')
}

glue_html <- function(..., .envir = parent.frame(), .open = "<~", .close = "~>", .na = "NA", 
                      .transformer = glue::identity_transformer) {
  htmltools::HTML(glue::glue(..., .envir = .envir, .open = .open, .close = .close, 
                             .na = .na, .transformer = .transformer))
}

# include_stylesheets <- function() {
#   htmltools::HTML('
# <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.5.0/css/all.css" integrity="sha384-B4dIYHKNBt8Bc12p+WXckhzcICo0wtJAoU8YZTY5qE0Id1GSseTk6S+L3BlXeVIU" crossorigin="anonymous">
# <link rel="stylesheet" href="https://cdn.rawgit.com/konpa/devicon/df6431e323547add1b4cf45992913f15286456d3/devicon.min.css">
#   ')
# }

build_gist_html <- function(gist) {
  if (inherits(gist, "gist")) {
    out <- gistr::embed(gist)
  } else if (stringr::str_detect(gist, "^https://gist\\.github\\.com/[:A-z0-9]+/.+\\.js$")) {
    out <- glue_html('<script src="<~gist~>"></script>')
  } else if (stringr::str_detect(gist, "^https://gist\\.github\\.com/[:A-z0-9]+")) {
    out <- glue_html('<script src="<~gist~>.js"></script>')
  } else {
    stop("invalid gist")
  }
  out
}


build_code_tabs <- function(chunk_label, ...) {
  srcs <- list(...)
  if (length(names(srcs)) == 0) {
    stop("... must be a named list, with names corresponding to menu labels")
  }
  tab_labels <- names(srcs)
  gist_scripts <- purrr::map_chr(srcs, build_gist_html)

  active_lab <- glue_html('
<li class="active">
   <a data-toggle="pill" href="#<~tab_labels[[1]]~>-<~chunk_label~>">
     <font color="blue" class="<~tab_labels[[1]]~>-label">
       <~tab_labels[[1]]~>
     </font>
   </a>
 </li>
                          ')

  other_labs <- purrr::map_chr(tab_labels[-1],
    ~ glue_html('
<li> 
  <a data-toggle="pill" href="#<~.x~>-<~chunk_label~>">
    <font color="blue" class="<~.x~>-label">
    <~.x~>
    </font>
  </a>
</li>
                ')
    )

  menu_labels <- stringr::str_flatten(c(active_lab, other_labs))
  
  first_content <- glue_html('
<div id="<~tab_labels[[1]]~>-<~chunk_label~>" class="tab-pane fade in active">
  <~gist_scripts[[1]]~>
</div>
                ')

  other_content <- stringr::str_flatten(
    purrr::map2_chr(tab_labels[-1], gist_scripts[-1],
    ~ glue_html('
<div id="<~.x~>-<~chunk_label~>" class="tab-pane fade">
  <~.y~>
</div>
                ')
    )
  )
  content <- stringr::str_flatten(c(first_content, other_content))

  glue_html('

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">


<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<!--
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.5.0/css/all.css" integrity="sha384-B4dIYHKNBt8Bc12p+WXckhzcICo0wtJAoU8YZTY5qE0Id1GSseTk6S+L3BlXeVIU" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdn.rawgit.com/konpa/devicon/df6431e323547add1b4cf45992913f15286456d3/devicon.min.css">
-->
  
<div class="code-container">
  <ul class="nav nav-pills">

    <~menu_labels~>

  </ul>

  <div class="tab-content">

    <~content~>

  </div>
</div>
            ')
}

# named_list(R = "https://gist.github.com/knapply/c8436ed4ce1e7aa7db0ba93e3a97b542#file-foundational_programming-built_in-length-r",
#            Python = "https://gist.github.com/knapply/84dcb4ecc6f886f4b08ca83487c6d533#file-foundational_programming-built_in-len-py",
#            Rcpp = "https://gist.github.com/knapply/a4d985c8e9f41ec34310d873cf12305b#file-foundational_programming-built_in-size-cpp")
# 
# 

# build_code_tabs(
#   chunk_label = "test",
#   R = "https://gist.github.com/knapply/c8436ed4ce1e7aa7db0ba93e3a97b542",
#   Python = "https://gist.github.com/knapply/84dcb4ecc6f886f4b08ca83487c6d533",
#   Rcpp = "https://gist.github.com/knapply/a4d985c8e9f41ec34310d873cf12305b"
#   ) %>% cat()

# build_gist_html("https://gist.github.com/knapply/c8436ed4ce1e7aa7db0ba93e3a97b542")




# build_code_tabs <- function(chunk_label, r_gist, py_gist, cpp_gist) {
#   if (nchar(chunk_label) == 0L) {
#     stop("chunk is not labeled")
#   }
#   
#   r_tab <- build_gist_html(r_gist)
#   py_tab <- build_gist_html(py_gist)
#   cpp_tab <- build_gist_html(cpp_gist)
#   
#   glue_html('
# <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.5.0/css/all.css" integrity="sha384-B4dIYHKNBt8Bc12p+WXckhzcICo0wtJAoU8YZTY5qE0Id1GSseTk6S+L3BlXeVIU" crossorigin="anonymous">
# <link rel="stylesheet" href="https://cdn.rawgit.com/konpa/devicon/df6431e323547add1b4cf45992913f15286456d3/devicon.min.css">
# 
# <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
# <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
# <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
# 
# <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.5.0/css/all.css" integrity="sha384-B4dIYHKNBt8Bc12p+WXckhzcICo0wtJAoU8YZTY5qE0Id1GSseTk6S+L3BlXeVIU" crossorigin="anonymous">
# <link rel="stylesheet" href="https://cdn.rawgit.com/konpa/devicon/df6431e323547add1b4cf45992913f15286456d3/devicon.min.css">
# 
# 
# 
# <div class="code-container">
#   <ul class="nav nav-pills">
#   
#     <li class="active"> <a data-toggle="pill" href="#r-<~chunk_label~>"> <font color="blue" class="lang-label">R</font> </a> </li>
#     
#     <li><a data-toggle="pill" href="#py-<~chunk_label~>"> <font color="green" class="lang-label">Python</font> </a></li>
#     
#     <li><a data-toggle="pill" href="#cpp-<~chunk_label~>"> <font color="red" class="lang-label">Rcpp</font> </a> </li>
#     
#   </ul>
# 
#   <div class="tab-content">
#   
#     <div id="r-<~chunk_label~>" class="tab-pane fade in active">
#       <~r_tab~>
#     </div>
#     
#     <div id="py-<~chunk_label~>" class="tab-pane fade">
#       <~py_tab~>
#     </div>
#     
#     <div id="cpp-<~chunk_label~>" class="tab-pane fade">
#       <~cpp_tab~>
#     </div>
# 
#   </div>
# </div>
# ')
# }



# build_code_tabs <- function(chunk_label, r_gist, py_gist, cpp_gist) {
#   if (nchar(chunk_label) == 0L) {
#     stop("chunk is not labeled")
#   }
# 
#   r_tab <- build_gist_html(r_gist)
#   py_tab <- build_gist_html(py_gist)
#   cpp_tab <- build_gist_html(cpp_gist)
# 
#   glue_html('
# <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.5.0/css/all.css" integrity="sha384-B4dIYHKNBt8Bc12p+WXckhzcICo0wtJAoU8YZTY5qE0Id1GSseTk6S+L3BlXeVIU" crossorigin="anonymous">
# <link rel="stylesheet" href="https://cdn.rawgit.com/konpa/devicon/df6431e323547add1b4cf45992913f15286456d3/devicon.min.css">
# 
# <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
# <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
# <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
# 
# <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.5.0/css/all.css" integrity="sha384-B4dIYHKNBt8Bc12p+WXckhzcICo0wtJAoU8YZTY5qE0Id1GSseTk6S+L3BlXeVIU" crossorigin="anonymous">
# <link rel="stylesheet" href="https://cdn.rawgit.com/konpa/devicon/df6431e323547add1b4cf45992913f15286456d3/devicon.min.css">
# 
# 
# 
# <div class="code-container">
#   <ul class="nav nav-pills">
# 
#     <li class="active"> <a data-toggle="pill" href="#r-<~chunk_label~>"> <i class="fab fa-r-project"></i> </a> </li>
# 
#     <li><a data-toggle="pill" href="#py-<~chunk_label~>"> <i class="fab fa-python"></i> </a></li>
# 
#     <li><a data-toggle="pill" href="#cpp-<~chunk_label~>"> <i class="devicon-cplusplus-plain"></i> </a> </li>
# 
#   </ul>
# 
#   <div class="tab-content">
# 
#     <div id="r-<~chunk_label~>" class="tab-pane fade in active">
#       <~r_tab~>
#     </div>
# 
#     <div id="py-<~chunk_label~>" class="tab-pane fade">
#       <~py_tab~>
#     </div>
# 
#     <div id="cpp-<~chunk_label~>" class="tab-pane fade">
#       <~cpp_tab~>
#     </div>
# 
#   </div>
# </div>
# ')
# }


# build_code_tabs <- function(chunk_label, r_gist, py_gist, cpp_gist) {
#   if (nchar(chunk_label) == 0L) {
#     stop("chunk is not labeled")
#   }
# 
#   r_tab <- build_gist_html(r_gist)
#   py_tab <- build_gist_html(py_gist)
#   cpp_tab <- build_gist_html(cpp_gist)
# 
#   glue_html('
# <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.5.0/css/all.css" integrity="sha384-B4dIYHKNBt8Bc12p+WXckhzcICo0wtJAoU8YZTY5qE0Id1GSseTk6S+L3BlXeVIU" crossorigin="anonymous">
# <link rel="stylesheet" href="https://cdn.rawgit.com/konpa/devicon/df6431e323547add1b4cf45992913f15286456d3/devicon.min.css">
# 
# <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
# <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
# <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
# 
# <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.5.0/css/all.css" integrity="sha384-B4dIYHKNBt8Bc12p+WXckhzcICo0wtJAoU8YZTY5qE0Id1GSseTk6S+L3BlXeVIU" crossorigin="anonymous">
# <link rel="stylesheet" href="https://cdn.rawgit.com/konpa/devicon/df6431e323547add1b4cf45992913f15286456d3/devicon.min.css">
# 
# 
# 
# <div class="code-container">
#   <ul class="nav nav-pills">
# 
#     <li class="active"> <a data-toggle="pill" href="#r-<~chunk_label~>"> <font color="blue" class="lang-label">R</font> </a> </li>
# 
#     <li><a data-toggle="pill" href="#py-<~chunk_label~>"> <font color="green" class="lang-label">Python</font> </a></li>
# 
#     <li><a data-toggle="pill" href="#cpp-<~chunk_label~>"> <font color="red" class="lang-label">Rcpp</font> </a> </li>
# 
#   </ul>
# 
#   <div class="tab-content">
# 
#     <div id="r-<~chunk_label~>" class="tab-pane fade in active">
#       <~r_tab~>
#     </div>
# 
#     <div id="py-<~chunk_label~>" class="tab-pane fade">
#       <~py_tab~>
#     </div>
# 
#     <div id="cpp-<~chunk_label~>" class="tab-pane fade">
#       <~cpp_tab~>
#     </div>
# 
#   </div>
# </div>
# ')
# }


