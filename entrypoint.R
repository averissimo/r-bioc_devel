setwd('/home/rstudio/glmSparseNet')

#BiocManager::install(remotes::local_package_deps(dependencies = TRUE))

#remotes::install_deps(dependencies = TRUE)

BiocManager::install(remotes::local_package_deps(dependencies = TRUE), Ncpus = 4)

remotes::install_deps(dependencies = TRUE, Ncpus = 4)


cat(glue::glue("Versions:\n {R.Version()$version.string}\n Bioconductor: {BiocManager::version()}\n\n"))

cat("-------------\n\n")

options(crayon.enabled = TRUE)

# download.file('https://github.com/sysbiomed/glmSparseNet/archive/refs/heads/master.zip', destfile = 'master.zip')

# unzip('master.zip')

devtools::check(manual = TRUE, cran = TRUE, check_dir = glue::glue("check_{BiocManager::version()}"), error_on = "warning")

BiocCheck::BiocCheck()

# rcmdcheck::rcmdcheck(args = c('-no-manual', '-as-cran'), error_on = 'warning', check_dir = 'check')
