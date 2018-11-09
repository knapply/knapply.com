start_tabset <- function() {
  glue_html('
<div class="code-container">
<ul class="nav nav-pills">
            ')
}

add_menu_tab <- function(chunk_name, is_active = TRUE) {
  lang <- stringr::str_extract(chunk_name, "^.+(?=-)")
  tooltip <- switch(lang, r = "Base R", py = "Pure Python", rcpp = "Rcpp", cpp = "C++", numpy = "NumPy")
  icon <- switch(lang,
                 r = '<i class="fab fa-r-project"> </i>',
                 py = '<i class="fab fa-python"></i>',
                 rcpp = '<i class="devicon-cplusplus-plain"></i>',
                 cpp = '<i class="devicon-cplusplus-plain"></i>',
                 numpy = '<i class="fab fa-python"></i>'
                 # numpy = '<img src="icons/numpy.svg" alt="NumPy">'
                 )
  font_class <- switch(lang, r = "R-label", py = "Python-label", rcpp = "Rcpp-label", cpp = "Cpp-label", numpy = "NumPy-label")
  li <- ifelse(is_active, "<li class='active'>", "<li>")

  glue_html('
<~li~>
  <a data-toggle="pill" href="#<~chunk_name~>">
    <font class="<~font_class~>">
      <p title="<~tooltip~>">
        <~icon~>
      </p>
    </font>
  </a>
</li>
            ')
}
  
end_menu <- function() {
  glue_html('</ul>')
}

start_tab_content <- function() {
  glue_html('<div class="tab-content">')
}

add_active_tab <- function(chunk_name) {
  glue_html('<div id="<~chunk_name~>" class="tab-pane fade in active">')
}

add_other_tab <- function(chunk_name) {
  glue_html('<div id="<~chunk_name~>" class="tab-pane fade">')
}

end_tab <- function() {
  glue_html('</div>')
}
end_tabset <- end_tab



glue_html <- function(..., .envir = parent.frame(), .open = "<~", .close = "~>", .na = "NA", 
                      .transformer = glue::identity_transformer) {
  htmltools::HTML(glue::glue(..., .envir = .envir, .open = .open, .close = .close, 
                             .na = .na, .transformer = .transformer))
}



as_chunk <- function (path, use_local = TRUE, lines = readr::read_lines(path), labels = NULL, 
    from = NULL, to = NULL, from.offset = 0L, to.offset = 0L, 
    roxygen_comments = TRUE) {
  if (use_local) {
    path <- glue::glue('C:/Users/Windows/Documents/tutorial-gists/sections/{path}')
  } else {
    path <- glue::glue("https://raw.githubusercontent.com/knapply/tutorial-gists/master/sections/{path}")
  }
  # print(path)
    if (!length(lines)) {
        warning("code is empty")
        return(invisible())
    }
    lab = "^(#|//|--)+\\s*(@knitr|----+)(.*?)-*\\s*$"
    if (is.null(labels)) {
        if (!knitr:::group_pattern(lab)) 
            return(invisible())
    }
    else {
        if (is.null(from)) 
            from = 1L
        if (!is.numeric(from)) 
            from = pattern_index(from, lines)
        if (is.null(to)) 
            to = c(from[-1L] - 1L, length(lines))
        if (!is.numeric(to)) 
            to = pattern_index(to, lines)
        stopifnot(length(labels) == length(from), length(from) == 
            length(to))
        from = from + from.offset
        to = to + to.offset
        code = list()
        for (i in seq_along(labels)) {
            code[[labels[i]]] = strip_white(lines[from[i]:to[i]])
        }
        knit_code$set(code)
        return(invisible())
    }
    idx = cumsum(grepl(lab, lines))
    if (idx[1] == 0) {
        idx = c(0, idx)
        lines = c("", lines)
    }
    groups = unname(split(lines, idx))
    labels = stringr::str_trim(gsub(lab, "\\3", sapply(groups, 
        `[`, 1)))
    labels = gsub(",.*", "", labels)
    code = lapply(groups, knitr:::strip_chunk, roxygen_comments)
    for (i in which(!nzchar(labels))) labels[i] = knitr:::unnamed_chunk()
    knitr:::knit_code$set(setNames(code, labels))
}

embed_github_link <- function(path) {
  # https://github.com/knapply/tutorial-gists/blob/master/sections/foundational-programming/r-length1.R
  if (stringr::str_detect(path, "(?<=/)r-.+\\.R$")) {
    lang <- "R"
  } else if (stringr::str_detect(path, "(?<=/)rcpp-.+\\.cpp$")) {
    lang <- "Rcpp"
  } else if (stringr::str_detect(path, "(?<=/)cpp-.+\\.cpp$")) {
    lang <- "Cpp"
  } else if (stringr::str_detect(path, "(?<=/)py-.+\\.py$")) {
    lang <- "Python"
  } else if (stringr::str_detect(path, "(?<=/)numpy-.+\\.py$")) {
    lang <- "NumPy"
  }

  glue_html('
<p class="<~lang~>-github-link" title="See code on GitHub">
  <a href="https://github.com/knapply/tutorial-gists/blob/master/sections/<~path~>" class="fab fa-github"></a>
</p>
            ')
}


# 
# 
# 
# 
# start_table <- function() {
#   htmltools::HTML('<table style="font-size:small" class="table table-bordered">')
#   # htmltools::HTML('<table class="table table-bordered">')
# }
# 
# start_row <- function() {
#   htmltools::HTML('<tr> <td valign="top">')
# }
# 
# end_col <- function() {
#   htmltools::HTML('</td>')
# }
# 
# new_col <- function() {
#   htmltools::HTML('</td> <td>')
# }
# 
# end_row <- function() {
#   htmltools::HTML('</tr>')
# }
# 
# new_row <- function() {
#   htmltools::HTML('</td> </tr> <tr> <td valign="top">')
# }
# 
# # end_table <- function() {
# #   htmltools::HTML('</table>')
# # }
# 
# label_r <- function() {
#   htmltools::HTML('<font color="#0000FF"> > R </font>')
# }
# 
# label_py <- function() {
#   htmltools::HTML('<font color="#008000"> >> Python </font>')
# }
# 
# label_numpy <- function() {
#   htmltools::HTML('<font color="#006400"> >> NumPy </font>')
# }
# 
# label_cpp <- function() {
#   htmltools::HTML('<font color="#FF0000"> >>> C++ </font>')
# }
# 
# end_table <- function() {
#   htmltools::HTML('</td> </tr> </table>')
# }



# include_stylesheets <- function() {
#   htmltools::HTML('
# <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.5.0/css/all.css" integrity="sha384-B4dIYHKNBt8Bc12p+WXckhzcICo0wtJAoU8YZTY5qE0Id1GSseTk6S+L3BlXeVIU" crossorigin="anonymous">
# <link rel="stylesheet" href="https://cdn.rawgit.com/konpa/devicon/df6431e323547add1b4cf45992913f15286456d3/devicon.min.css">
#   ')
# }

# build_gist_html <- function(gist) {
#   if (inherits(gist, "gist")) {
#     out <- gistr::embed(gist)
#   } else if (stringr::str_detect(gist, "^https://gist\\.github\\.com/[:A-z0-9]+/.+\\.js$")) {
#     out <- glue_html('<script src="<~gist~>"></script>')
#   } else if (stringr::str_detect(gist, "^https://gist\\.github\\.com/[:A-z0-9]+")) {
#     out <- glue_html('<script src="<~gist~>.js"></script>')
#   } else {
#     stop("invalid gist")
#   }
#   out
# }


# build_code_tabs <- function(chunk_label, ...) {
#   srcs <- list(...)
#   if (length(names(srcs)) == 0) {
#     stop("... must be a named list, with names corresponding to menu labels")
#   }
#   tab_labels <- names(srcs)
#   gist_scripts <- purrr::map_chr(srcs, build_gist_html)
# 
#   active_lab <- glue_html('
# <li class="active">
#    <a data-toggle="pill" href="#<~tab_labels[[1]]~>-<~chunk_label~>">
#      <font color="blue" class="<~tab_labels[[1]]~>-label">
#        <~tab_labels[[1]]~>
#      </font>
#    </a>
#  </li>
#                           ')
# 
#   other_labs <- purrr::map_chr(tab_labels[-1],
#     ~ glue_html('
# <li> 
#   <a data-toggle="pill" href="#<~.x~>-<~chunk_label~>">
#     <font color="blue" class="<~.x~>-label">
#     <~.x~>
#     </font>
#   </a>
# </li>
#                 ')
#     )
# 
#   menu_labels <- stringr::str_flatten(c(active_lab, other_labs))
#   
#   first_content <- glue_html('
# <div id="<~tab_labels[[1]]~>-<~chunk_label~>" class="tab-pane fade in active">
#   <~gist_scripts[[1]]~>
# </div>
#                 ')
# 
#   other_content <- stringr::str_flatten(
#     purrr::map2_chr(tab_labels[-1], gist_scripts[-1],
#     ~ glue_html('
# <div id="<~.x~>-<~chunk_label~>" class="tab-pane fade">
#   <~.y~>
# </div>
#                 ')
#     )
#   )
#   content <- stringr::str_flatten(c(first_content, other_content))
# 
#   glue_html('
# 
# <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
# 
# 
# <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
# 
# <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
# 
# <!--
# <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.5.0/css/all.css" integrity="sha384-B4dIYHKNBt8Bc12p+WXckhzcICo0wtJAoU8YZTY5qE0Id1GSseTk6S+L3BlXeVIU" crossorigin="anonymous">
# <link rel="stylesheet" href="https://cdn.rawgit.com/konpa/devicon/df6431e323547add1b4cf45992913f15286456d3/devicon.min.css">
# -->
#   
# <div class="code-container">
#   <ul class="nav nav-pills">
# 
#     <~menu_labels~>
# 
#   </ul>
# 
#   <div class="tab-content">
# 
#     <~content~>
# 
#   </div>
# </div>
#             ')
# }
# 


# source_code <- function(path) {
#   temp_file
# }
# 
# embed_gist <- function(gh_file_path, lang = NULL, minimal=TRUE) {
#   gist_url <- glue_html("https://github.com/knapply/tutorial-gists/blob/master/sections/<~gh_file_path~>")
#   raw_url <- glue_html("https://raw.githubusercontent.com/knapply/tutorial-gists/master/sections/<~gh_file_path~>")
#   
#   if (minimal) {
#     cat(glue_html('<script src="http://gist-it.appspot.com/<~gh_file_url~>?footer=minimal"></script>'))
#   } else {
#     cat(glue_html('<script src="http://gist-it.appspot.com/<~gh_file_url~>"></script>'))
#   }
#   code <- readr::read_lines(raw_url)
#   if (lang == "r") {
#     
#   }
# }



#' 
#' r_github_link <- function(path) {
#'   glue_html('
#' <a href="https://github.com/knapply/tutorial-gists/blob/master/sections/<~path~>" class="github-corner" aria-label="View source on GitHub">
#' <svg width="80" height="80" viewBox="0 0 250 250" style="fill:#70B7FD; color:#fff; position: relative; top: 0; border: 0; right: 0;" aria-hidden="true">
#' <path d="M0,0 L115,115 L130,115 L142,142 L250,250 L250,0 Z"></path>
#' <path d="M128.3,109.0 C113.8,99.7 119.0,89.6 119.0,89.6 C122.0,82.7 120.5,78.6 120.5,78.6 C119.2,72.0 123.4,76.3 123.4,76.3 C127.3,80.9 125.5,87.3 125.5,87.3 C122.9,97.6 130.6,101.9 134.4,103.2" fill="currentColor" style="transform-origin: 130px 106px;" class="octo-arm"></path>
#' <path d="M115.0,115.0 C114.9,115.1 118.7,116.5 119.8,115.4 L133.7,101.6 C136.9,99.2 139.9,
#'         98.4 142.2,98.6 C133.8,88.0 127.5,74.4 143.8,58.0 C148.5,53.4 154.0,51.2 159.7,51.0
#'         C160.3,49.4 163.2,43.6 171.4,40.1 C171.4,40.1 176.1,42.5 178.8,56.2 C183.1,58.6 187.2,
#'         61.8 190.9,65.4 C194.5,69.0 197.7,73.2 200.1,77.6 C213.8,80.2 216.3,84.9 216.3,84.9 C212.7,
#'         93.1 206.9,96.0 205.4,96.6 C205.1,102.4 203.0,107.8 198.3,112.5 C181.9,128.9 168.3,
#'         122.5 157.7,114.1 C157.9,116.9 156.7,120.9 152.7,124.9 L141.0,136.5 C139.8,137.7 141.6,141.9 141.8,141.8 Z" fill="currentColor" class="octo-body"></path>
#' </svg></a>
#' <style>
#' .github-corner:hover .octo-arm{
#'   animation:octocat-wave 560ms ease-in-out
#'   }
#' @keyframes octocat-wave{
#'   0%,100%{transform:rotate(0)}20%,60%{transform:rotate(-25deg)}40%,80%{transform:rotate(10deg)}
#' }
#' @media (max-width:500px){
#'   .github-corner:hover .octo-arm{animation:none}.github-corner .octo-arm{animation:octocat-wave 560ms ease-in-out}
#' }
#' </style>
#'             ')
#' }
#' 










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


