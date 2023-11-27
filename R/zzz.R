.onLoad <- function(libname, pkgname) {
  get <<- memoise::memoise(get)
}

