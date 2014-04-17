if (base::getRversion() >= "2.15.1") {
  utils::globalVariables(c("long", "lat","group")) ## Neded in functions plot_density and plot_signposts
}